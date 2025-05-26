<?php
// restore_snapshot.php
header("Content-Type: application/json");
require_once '../connect3.php'; // Adjust path as needed

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Check if user is authorized (admin)
session_start();
if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

if ($_SESSION['user_type'] !== 'admin') {
    http_response_code(403);
    echo json_encode(['error' => 'Access denied']);
    exit;
}

// Get form ID from request
$formId = isset($_GET['form_id']) ? (int)$_GET['form_id'] : 0;
if ($formId <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid form ID']);
    exit;
}

try {
    // Get the active snapshot for this form
    $stmt = $conn->prepare("
        SELECT snapshot_index, snapshot_data 
        FROM form_snapshots 
        WHERE form_index = ? AND is_active = 1
        ORDER BY created_at DESC 
        LIMIT 1
    ");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['error' => 'No active snapshot found for this form']);
        exit;
    }
    
    $snapshot = $result->fetch_assoc();
    $snapshotData = json_decode($snapshot['snapshot_data'], true);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        throw new Exception("Failed to decode snapshot data: " . json_last_error_msg());
    }
    
    // Begin transaction
    $conn->begin_transaction();
    
    // 1. Delete existing form data
    $deleteStmts = [
        "DELETE FROM form_sections WHERE form_index = ?",
        "DELETE FROM choices WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)",
        "DELETE FROM sub_questions WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)",
        "DELETE FROM main_questions WHERE form_index = ?"
    ];
    
    foreach ($deleteStmts as $sql) {
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $formId);
        $stmt->execute();
        $stmt->close();
    }
    
    // 2. Restore form metadata
    $stmt = $conn->prepare("UPDATE forms SET form_name = ?, description = ? WHERE form_index = ?");
    $stmt->bind_param("ssi", $snapshotData['form_name'], $snapshotData['description'], $formId);
    $stmt->execute();
    $stmt->close();
    
    // 3. Restore sections and questions
    $sectionInsert = $conn->prepare("
        INSERT INTO form_sections (form_index, section_title, section_description, section_order, behavior) 
        VALUES (?, ?, ?, ?, ?)
    ");
    
    $questionInsert = $conn->prepare("
        INSERT INTO main_questions (form_index, section_index, main_question_text, type_index, is_required, include_other) 
        VALUES (?, ?, ?, (SELECT type_index FROM question_types WHERE type_name = ?), ?, ?)
    ");
    
    $choiceInsert = $conn->prepare("
        INSERT INTO choices (main_question_index, choice_text) 
        VALUES (?, ?)
    ");
    
    $subQuestionInsert = $conn->prepare("
        INSERT INTO sub_questions (main_question_index, sub_question_text) 
        VALUES (?, ?)
    ");
    
    foreach ($snapshotData['sections'] as $section) {
        // Insert section
        $sectionInsert->bind_param(
            "issis", 
            $formId, 
            $section['title'], 
            $section['description'], 
            $section['order'], 
            $section['behavior']
        );
        $sectionInsert->execute();
        $sectionId = $conn->insert_id;
        
        // Insert questions for this section
        foreach ($section['questions'] as $question) {
            $questionInsert->bind_param(
                "iissii", 
                $formId, 
                $sectionId, 
                $question['question'], 
                $question['type'], 
                $question['required'] ? 1 : 0, 
                $question['includeOther'] ? 1 : 0
            );
            $questionInsert->execute();
            $questionId = $conn->insert_id;
            
            // Insert choices if they exist
            if (!empty($question['options'])) {
                foreach ($question['options'] as $option) {
                    $choiceInsert->bind_param("is", $questionId, $option['choice_text']);
                    $choiceInsert->execute();
                }
            }
            
            // Insert sub-questions (for grid questions)
            if (!empty($question['rows'])) {
                foreach ($question['rows'] as $rowText) {
                    $subQuestionInsert->bind_param("is", $questionId, $rowText);
                    $subQuestionInsert->execute();
                }
            }
        }
    }
    
    $conn->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'Snapshot restored successfully',
        'snapshot_id' => $snapshot['snapshot_index']
    ]);
    
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to restore snapshot',
        'message' => $e->getMessage()
    ]);
}
?>