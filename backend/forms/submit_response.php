<?php
session_start();

// Check if user is logged in
if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized – please log in']);
    exit;
}

// Get user type and index
$userIndex = $_SESSION['user_index'];
$userType = $_SESSION['user_type'];

// Only allow students to submit forms
if ($userType !== 'student') {
    http_response_code(403);
    echo json_encode(['error' => 'Access denied – only students can submit forms']);
    exit;
}

// Fetch student_index from DB using session user_index
require_once '../connect3.php'; // Adjust path as needed

$stmtStudent = $conn->prepare("SELECT student_index FROM students WHERE user_index = ?");
$stmtStudent->bind_param("i", $userIndex);
$stmtStudent->execute();
$stmtStudent->store_result();

if ($stmtStudent->num_rows === 0) {
    http_response_code(403);
    echo json_encode(['error' => 'No student record found for this user']);
    exit;
}

$stmtStudent->bind_result($studentId);
$stmtStudent->fetch();
$stmtStudent->close();

// Get form data from frontend
$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['form_index'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid request data – missing form_index']);
    exit;
}

$formId = (int)$data['form_index'];

try {
    $conn->begin_transaction();

    // 1. Get active snapshot for this form
    $snapshotId = null;
    $snapshotStmt = $conn->prepare("
        SELECT snapshot_id 
        FROM form_snapshots 
        WHERE form_index = ? AND is_active = 1
        ORDER BY created_at DESC 
        LIMIT 1
    ");
    $snapshotStmt->bind_param("i", $formId);
    $snapshotStmt->execute();
    $snapshotResult = $snapshotStmt->get_result();

    if ($snapshotResult->num_rows > 0) {
        $snapshotRow = $snapshotResult->fetch_assoc();
        $snapshotId = $snapshotRow['snapshot_id'];
    }
    $snapshotStmt->close();

    // 2. Insert into responses table
    $stmt = $conn->prepare("
        INSERT INTO responses (form_index, student_index, snapshot_id) 
        VALUES (?, ?, ?)
    ");
    $stmt->bind_param("iii", $formId, $studentId, $snapshotId);
    
    if (!$stmt->execute()) {
        throw new Exception("Failed to create response: " . $stmt->error);
    }
    $responseId = $conn->insert_id;
    $stmt->close();

    // 3. Process regular answers
    if (isset($data['answers']) && is_array($data['answers'])) {
        $answerStmt = $conn->prepare("
            INSERT INTO answers 
            (response_index, main_question_index, choice_index, text_answer) 
            VALUES (?, ?, ?, ?)
        ");

        foreach ($data['answers'] as $answer) {
            $questionId = (int)$answer['main_question_index'];
            $choiceId = isset($answer['choice_index']) ? (int)$answer['choice_index'] : null;
            $textAnswer = isset($answer['text_answer']) ? $answer['text_answer'] : null;

            $answerStmt->bind_param("iiis", $responseId, $questionId, $choiceId, $textAnswer);
            if (!$answerStmt->execute()) {
                throw new Exception("Failed to insert answer: " . $answerStmt->error);
            }
        }

        $answerStmt->close();
    }

    // 4. Process grid answers
    if (isset($data['grid_answers']) && is_array($data['grid_answers'])) {
        $gridStmt = $conn->prepare("
            INSERT INTO grid_answers 
            (response_index, main_question_index, sub_question_index, choice_index) 
            VALUES (?, ?, ?, ?)
        ");

        foreach ($data['grid_answers'] as $gridAnswer) {
            $questionId = (int)$gridAnswer['main_question_index'];
            $subQuestionId = (int)$gridAnswer['sub_question_index'];
            $choiceId = (int)$gridAnswer['choice_index'];

            $gridStmt->bind_param("iiii", $responseId, $questionId, $subQuestionId, $choiceId);
            if (!$gridStmt->execute()) {
                throw new Exception("Failed to insert grid answer: " . $gridStmt->error);
            }
        }

        $gridStmt->close();
    }

    $conn->commit();

    echo json_encode([
        'success' => true,
        'message' => 'Response submitted successfully',
        'response_index' => $responseId,
        'snapshot_id' => $snapshotId
    ]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to submit response',
        'message' => $e->getMessage()
    ]);
}