<?php
session_start();

error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");

if (!isset($_SESSION['user_index']) || $_SESSION['user_type'] !== 'student') {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

require_once '../connect.php';

$userIndex = $_SESSION['user_index'];
$student_id = $_SESSION['student_index'] ?? null;

// Get student_index
$stmt = $conn->prepare("SELECT student_index FROM students WHERE user_index = ?");
$stmt->bind_param("i", $userIndex);
$stmt->execute();
$stmt->bind_result($studentId);
if (!$stmt->fetch()) {
    http_response_code(403);
    echo json_encode(['error' => 'Student not found']);
    exit;
}
$stmt->close();

// Get request body
$input = json_decode(file_get_contents("php://input"), true);

if (!$input || !isset($input['form_index'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid input']);
    exit;
}

$formId = (int)$input['form_index'];
$isAutosave = !empty($input['is_autosave']);
$forceNew = !empty($input['force_new']);
$answers = $input['answers'] ?? [];
$gridAnswers = $input['grid_answers'] ?? [];

try {
    $conn->begin_transaction();

    // Get academic year and active snapshot
    $stmt = $conn->prepare("SELECT academic_year FROM forms WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $formResult = $stmt->get_result();
    if ($formResult->num_rows === 0) {
        throw new Exception("Form not found");
    }
    $academicYear = $formResult->fetch_assoc()['academic_year'];
    $stmt->close();

    $snapshotStmt = $conn->prepare("SELECT snapshot_index FROM form_snapshots WHERE form_index = ? AND is_active = 1 ORDER BY created_at DESC LIMIT 1");
    $snapshotStmt->bind_param("i", $formId);
    $snapshotStmt->execute();
    $snapshotResult = $snapshotStmt->get_result();
    $snapshotIndex = $snapshotResult->num_rows > 0 ? $snapshotResult->fetch_assoc()['snapshot_index'] : null;
    $snapshotStmt->close();

    $responseId = null;
    $isNewDraft = false;

    if ($isAutosave) {
        // Autosave logic (same as before)
        $checkStmt = $conn->prepare("
            SELECT response_index FROM responses 
            WHERE form_index = ? AND student_index = ? AND is_autosave = 1 
            ORDER BY created_at DESC LIMIT 1
        ");
        $checkStmt->bind_param("ii", $formId, $studentId);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();
        
        if ($checkResult->num_rows > 0) {
            // Update existing autosave
            $responseId = $checkResult->fetch_assoc()['response_index'];
            $update = $conn->prepare("UPDATE responses SET snapshot_index = ?, academic_year = ?, updated_at = NOW() WHERE response_index = ?");
            $update->bind_param("isi", $snapshotIndex, $academicYear, $responseId);
            $update->execute();
            $update->close();

            // Delete existing answers
            $delAnswers = $conn->prepare("DELETE FROM answers WHERE response_index = ?");
            if ($delAnswers) {
                $delAnswers->bind_param("i", $responseId);
                $delAnswers->execute();
                $delAnswers->close();
            } else {
                throw new Exception("Failed to prepare statement for deleting answers: " . $conn->error);
            }

            $delGrid = $conn->prepare("DELETE FROM grid_answers WHERE response_index = ?");
            if ($delGrid) {
                $delGrid->bind_param("i", $responseId);
                $delGrid->execute();
                $delGrid->close();
            } else {
                throw new Exception("Failed to prepare statement for deleting grid answers: " . $conn->error);
            }
        } else {
            // Create new autosave response
            $stmt = $conn->prepare("INSERT INTO responses (form_index, student_index, created_at, updated_at, snapshot_index, is_autosave, academic_year) VALUES (?, ?, NOW(), NOW(), ?, ?, ?)");
            $isAuto = 1;
            $stmt->bind_param("iiiis", $formId, $studentId, $snapshotIndex, $isAuto, $academicYear);
            if (!$stmt->execute()) {
                throw new Exception("Failed to insert response");
            }
            $responseId = $stmt->insert_id;
            $stmt->close();
            $isNewDraft = true;
        }
    } else {
        // Final submission: try to update existing autosave to is_autosave=0
        $checkStmt = $conn->prepare("
            SELECT response_index FROM responses 
            WHERE form_index = ? AND student_index = ? AND is_autosave = 1 
            ORDER BY created_at DESC LIMIT 1
        ");
        $checkStmt->bind_param("ii", $formId, $studentId);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();
        if ($checkResult->num_rows > 0) {
            // Update existing autosave to final submission
            $responseId = $checkResult->fetch_assoc()['response_index'];
            $update = $conn->prepare("UPDATE responses SET is_autosave = 0, snapshot_index = ?, academic_year = ?, updated_at = NOW() WHERE response_index = ?");
            $update->bind_param("isi", $snapshotIndex, $academicYear, $responseId);
            $update->execute();
            $update->close();

            // Delete existing answers
            $delAnswers = $conn->prepare("DELETE FROM answers WHERE response_index = ?");
            if ($delAnswers) {
                $delAnswers->bind_param("i", $responseId);
                $delAnswers->execute();
                $delAnswers->close();
            } else {
                throw new Exception("Failed to prepare statement for deleting answers: " . $conn->error);
            }

            $delGrid = $conn->prepare("DELETE FROM grid_answers WHERE response_index = ?");
            if ($delGrid) {
                $delGrid->bind_param("i", $responseId);
                $delGrid->execute();
                $delGrid->close();
            } else {
                throw new Exception("Failed to prepare statement for deleting grid answers: " . $conn->error);
            }
        } else {
            // No autosave exists, create new final submission
            $stmt = $conn->prepare("INSERT INTO responses (form_index, student_index, created_at, updated_at, snapshot_index, is_autosave, academic_year) VALUES (?, ?, NOW(), NOW(), ?, ?, ?)");
            $isAuto = 0;
            $stmt->bind_param("iiiis", $formId, $studentId, $snapshotIndex, $isAuto, $academicYear);
            if (!$stmt->execute()) {
                throw new Exception("Failed to insert response");
            }
            $responseId = $stmt->insert_id;
            $stmt->close();
        }
    }

    // Insert answers
    foreach ($answers as $ans) {
        $stmt = $conn->prepare("INSERT INTO answers (response_index, main_question_index, choice_index, text_answer) VALUES (?, ?, ?, ?)");
        $stmt->bind_param(
            "iiis",
            $responseId,
            $ans['main_question_index'],
            $ans['choice_index'],
            $ans['text_answer']
        );
        $stmt->execute();
        $stmt->close();
    }

    foreach ($gridAnswers as $grid) {
        $stmt = $conn->prepare("INSERT INTO grid_answers (response_index, main_question_index, sub_question_index, choice_index) VALUES (?, ?, ?, ?)");
        $stmt->bind_param(
            "iiii",
            $responseId,
            $grid['main_question_index'],
            $grid['sub_question_index'],
            $grid['choice_index']
        );
        $stmt->execute();
        $stmt->close();
    }

    $conn->commit();

    echo json_encode([
        'success' => true,
        'message' => $isAutosave ? 'Auto-save successful' : 'Form submitted successfully',
        'response_index' => $responseId,
        'snapshot_index' => $snapshotIndex,
        'academic_year' => $academicYear,
        'is_autosave' => $isAutosave,
        'is_new_draft' => $isNewDraft
    ]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
        'is_autosave' => $isAutosave
    ]);
}

$conn->close();
