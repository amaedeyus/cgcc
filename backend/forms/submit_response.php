<?php
session_start();

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

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

// Database connection
require_once '../connect3.php';

// Fetch student_index from DB using session user_index
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

// Get and validate form data from frontend
$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['form_index'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid request data – missing form_index']);
    exit;
}

$formId = (int)$data['form_index'];

try {
    $conn->begin_transaction();

    // 1. Get active snapshot for this form (to maintain form state at time of submission)
    $snapshotIndex = null;
    $snapshotStmt = $conn->prepare("
        SELECT snapshot_index 
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
        $snapshotIndex = $snapshotRow['snapshot_index'];
    }
    $snapshotStmt->close();

    // 2. Create the main response record
    $stmt = $conn->prepare("
        INSERT INTO responses (form_index, student_index, created_at, snapshot_index) 
        VALUES (?, ?, NOW(), ?)
    ");
    $stmt->bind_param("iii", $formId, $studentId, $snapshotIndex);
    
    if (!$stmt->execute()) {
        throw new Exception("Failed to create response: " . $stmt->error);
    }
    $responseId = $conn->insert_id;
    $stmt->close();

    // 3. Process regular answers (non-grid questions)
    if (isset($data['answers']) && is_array($data['answers'])) {
        $answerStmt = $conn->prepare("
            INSERT INTO answers 
            (response_index, main_question_index, choice_index, text_answer) 
            VALUES (?, ?, ?, ?)
        ");

        foreach ($data['answers'] as $answer) {
            error_log("Answer received: " . json_encode($answer));
            $questionId = (int)$answer['main_question_index'];
            
            // Initialize both fields as null
            $choiceId = null;
            $textAnswer = null;
            
            // Check if this is a choice-based answer or text answer
            if (isset($answer['choice_index']) && $answer['choice_index'] !== null) {
                // This is a regular choice selection
                $choiceId = (int)$answer['choice_index'];

                $checkChoice = $conn->prepare("
                    SELECT 1 FROM choices 
                    WHERE choice_index = ? AND main_question_index = ?
                ");
                $checkChoice->bind_param("ii", $choiceId, $questionId);
                $checkChoice->execute();
                $checkChoice->store_result();

                if ($checkChoice->num_rows === 0) {
                    throw new Exception("Invalid choice_index $choiceId for question $questionId");
                }
                $checkChoice->close();

            } else if (isset($answer['text_answer']) && $answer['text_answer'] !== '') {
                $textAnswer = $answer['text_answer'];

                if (isset($answer['is_other']) && $answer['is_other']) {
                    $checkOther = $conn->prepare("
                        SELECT include_other FROM main_questions 
                        WHERE main_question_index = ?
                    ");
                    $checkOther->bind_param("i", $questionId);
                    $checkOther->execute();
                    $checkOther->bind_result($includeOther);
                    $checkOther->fetch();
                    $checkOther->close();

                    if (!$includeOther) {
                        throw new Exception("Question $questionId doesn't allow 'other' option");
                    }
                }

            } else {
                continue; // No valid input
            }

            
            // Insert the answer
            $answerStmt->bind_param("iiis", $responseId, $questionId, $choiceId, $textAnswer);
            if (!$answerStmt->execute()) {
                throw new Exception("Failed to insert answer: " . $answerStmt->error);
            }
        }

        $answerStmt->close();
    }

    // 4. Process grid answers (matrix questions)
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

            // Verify the sub-question exists for this main question
            $checkSubQuestion = $conn->prepare("
                SELECT 1 FROM sub_questions 
                WHERE sub_question_index = ? AND main_question_index = ?
            ");
            $checkSubQuestion->bind_param("ii", $subQuestionId, $questionId);
            $checkSubQuestion->execute();
            $checkSubQuestion->store_result();
            
            if ($checkSubQuestion->num_rows === 0) {
                throw new Exception("Invalid sub_question_index $subQuestionId for question $questionId");
            }
            $checkSubQuestion->close();
            
            // Verify the choice exists for this question
            $checkGridChoice = $conn->prepare("
                SELECT 1 FROM choices 
                WHERE choice_index = ? AND main_question_index = ?
            ");
            $checkGridChoice->bind_param("ii", $choiceId, $questionId);
            $checkGridChoice->execute();
            $checkGridChoice->store_result();
            
            if ($checkGridChoice->num_rows === 0) {
                throw new Exception("Invalid grid choice_index $choiceId for question $questionId");
            }
            $checkGridChoice->close();

            // Insert the grid answer
            $gridStmt->bind_param("iiii", $responseId, $questionId, $subQuestionId, $choiceId);
            if (!$gridStmt->execute()) {
                throw new Exception("Failed to insert grid answer: " . $gridStmt->error);
            }
        }

        $gridStmt->close();
    }

    $conn->commit();

    // Successful response
    echo json_encode([
        'success' => true,
        'message' => 'Response submitted successfully',
        'response_index' => $responseId,
        'snapshot_index' => $snapshotIndex
    ]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to submit response',
        'message' => $e->getMessage(),
        'trace' => $e->getTrace() // Only for debugging, remove in production
    ]);
}

// Close connection
$conn->close();
?>