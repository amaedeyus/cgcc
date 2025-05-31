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
$isAutoSave = isset($data['is_autosave']) ? (bool)$data['is_autosave'] : false;

try {
    $conn->begin_transaction();

    // 1. Get form details including academic year
    $formStmt = $conn->prepare("
        SELECT academic_year 
        FROM forms 
        WHERE form_index = ?
    ");
    $formStmt->bind_param("i", $formId);
    $formStmt->execute();
    $formResult = $formStmt->get_result();

    if ($formResult->num_rows === 0) {
        throw new Exception("Form not found");
    }
    
    $formRow = $formResult->fetch_assoc();
    $academicYear = $formRow['academic_year'];
    $formStmt->close();

    // 2. Get active snapshot for this form
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

    // 3. Handle auto-save updates or create new response
    $responseId = null;
    if ($isAutoSave) {
        // Check for existing auto-save response
        $checkStmt = $conn->prepare("
            SELECT response_index FROM responses 
            WHERE form_index = ? AND student_index = ? AND is_autosave = 1
            ORDER BY created_at DESC 
            LIMIT 1
        ");
        $checkStmt->bind_param("ii", $formId, $studentId);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();
        
        if ($checkResult->num_rows > 0) {
            $responseRow = $checkResult->fetch_assoc();
            $responseId = $responseRow['response_index'];
            
            // Update existing auto-save response
            $updateStmt = $conn->prepare("
                UPDATE responses 
                SET snapshot_index = ?, academic_year = ?, updated_at = NOW()
                WHERE response_index = ?
            ");
            $updateStmt->bind_param("isi", $snapshotIndex, $academicYear, $responseId);
            $updateStmt->execute();
            $updateStmt->close();
            
            // Delete previous answers to replace them
            $deleteAnswers = $conn->prepare("DELETE FROM answers WHERE response_index = ?");
            $deleteAnswers->bind_param("i", $responseId);
            $deleteAnswers->execute();
            $deleteAnswers->close();
            
            $deleteGridAnswers = $conn->prepare("DELETE FROM grid_answers WHERE response_index = ?");
            $deleteGridAnswers->bind_param("i", $responseId);
            $deleteGridAnswers->execute();
            $deleteGridAnswers->close();
        }
    }

    // If not updating an auto-save, create new response record
    if (!$responseId) {
        $stmt = $conn->prepare("
            INSERT INTO responses 
            (form_index, student_index, created_at, snapshot_index, is_autosave, academic_year) 
            VALUES (?, ?, NOW(), ?, ?, ?)
        ");
        $isAutoSaveInt = $isAutoSave ? 1 : 0;
        $stmt->bind_param("iiiis", $formId, $studentId, $snapshotIndex, $isAutoSaveInt, $academicYear);
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to create response: " . $stmt->error);
        }
        $responseId = $conn->insert_id;
        $stmt->close();
    }

    // 4. Process regular answers (choice-based and text answers)
    if (isset($data['answers']) && is_array($data['answers'])) {
        $answerStmt = $conn->prepare("
            INSERT INTO answers 
            (response_index, main_question_index, choice_index, text_answer) 
            VALUES (?, ?, ?, ?)
        ");

        foreach ($data['answers'] as $answer) {
            if (!isset($answer['main_question_index'])) {
                continue; // Skip invalid answers
            }

            $questionId = (int)$answer['main_question_index'];
            $choiceId = isset($answer['choice_index']) ? (int)$answer['choice_index'] : null;
            $textAnswer = isset($answer['text_answer']) ? $answer['text_answer'] : null;

            // For text answers, skip choice validation
            if ($textAnswer !== null) {
                $answerStmt->bind_param("iiis", $responseId, $questionId, $choiceId, $textAnswer);
                if (!$answerStmt->execute()) {
                    throw new Exception("Failed to insert text answer: " . $answerStmt->error);
                }
                continue;
            }

            // For choice answers, validate the choice
            if ($choiceId !== null) {
                // Verify the choice exists for this question
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
                
                // Insert the answer
                $answerStmt->bind_param("iiis", $responseId, $questionId, $choiceId, $textAnswer);
                if (!$answerStmt->execute()) {
                    throw new Exception("Failed to insert answer: " . $answerStmt->error);
                }
            }
        }
        $answerStmt->close();
    }

    // 5. Process grid answers (matrix questions)
    if (isset($data['grid_answers']) && is_array($data['grid_answers'])) {
        $gridStmt = $conn->prepare("
            INSERT INTO grid_answers 
            (response_index, main_question_index, sub_question_index, choice_index) 
            VALUES (?, ?, ?, ?)
        ");

        foreach ($data['grid_answers'] as $gridAnswer) {
            if (!isset($gridAnswer['main_question_index']) || 
                !isset($gridAnswer['sub_question_index']) || 
                !isset($gridAnswer['choice_index'])) {
                continue; // Skip invalid grid answers
            }

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
        'message' => $isAutoSave ? 'Response auto-saved successfully' : 'Response submitted successfully',
        'response_index' => $responseId,
        'snapshot_index' => $snapshotIndex,
        'academic_year' => $academicYear,
        'is_autosave' => $isAutoSave
    ]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode([
        'error' => $isAutoSave ? 'Auto-save failed' : 'Failed to submit response',
        'message' => $e->getMessage(),
        'is_autosave' => $isAutoSave
    ]);
}

$conn->close();
?>