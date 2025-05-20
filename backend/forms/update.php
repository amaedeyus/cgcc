<?php
session_start();

if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

$userType = $_SESSION['user_type'];


if ($userType !== 'admin') {
    http_response_code(403);
    echo json_encode(['error' => 'Access denied']);
    exit;
}

// Optional: Log user type
error_log("User type: " . $userType);
// update_form.php

header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header("Access-Control-Allow-Credentials: true");
    header("Access-Control-Allow-Methods: POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type");
    exit(0);
}

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../connect3.php'; // Adjust path as needed

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['form_index'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Form ID missing']);
    exit;
}

$formId = (int)$data['form_index'];

try {
    // First, create snapshot before making any destructive changes
    try {
        // Fetch current form state
        $stmt = $conn->prepare("
            SELECT 
                f.form_index,
                f.form_name,
                f.description,
                fs.section_index,
                fs.section_title,
                fs.section_description,
                fs.behavior,
                q.main_question_index,
                q.main_question_text,
                qt.type_name AS type,
                q.is_required,
                q.include_other,
                c.choice_text,
                sq.sub_question_text
            FROM forms f
            LEFT JOIN form_sections fs ON f.form_index = fs.form_index
            LEFT JOIN main_questions q ON fs.section_index = q.section_index
            LEFT JOIN question_types qt ON q.type_index = qt.type_index
            LEFT JOIN choices c ON q.main_question_index = c.main_question_index
            LEFT JOIN sub_questions sq ON q.main_question_index = sq.main_question_index
            WHERE f.form_index = ?
        ");
        $stmt->bind_param("i", $formId);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            throw new Exception("No form data found to snapshot");
        }

        $sections = [];
        $sectionMap = [];

        while ($row = $result->fetch_assoc()) {
            $sectionIndex = $row['section_index'];
            if (!isset($sectionMap[$sectionIndex])) {
                $sectionMap[$sectionIndex] = [
                    'section_index' => $sectionIndex,
                    'section_title' => $row['section_title'],
                    'section_description' => $row['section_description'],
                    'behavior' => $row['behavior'],
                    'questions' => []
                ];
            }

            $questionIndex = $row['main_question_index'];
            if ($questionIndex && !in_array($questionIndex, array_column($sectionMap[$sectionIndex]['questions'], 'main_question_index'))) {
                $question = [
                    'main_question_index' => $questionIndex,
                    'main_question_text' => $row['main_question_text'],
                    'type' => $row['type'],
                    'is_required' => (bool)$row['is_required'],
                    'include_other' => (bool)$row['include_other'],
                    'options' => [],
                    'rows' => []
                ];

                // Get options
                $optStmt = $conn->prepare("SELECT choice_text FROM choices WHERE main_question_index = ?");
                $optStmt->bind_param("i", $questionIndex);
                $optStmt->execute();
                $optResult = $optStmt->get_result();
                while ($optRow = $optResult->fetch_assoc()) {
                    $question['options'][] = $optRow['choice_text'];
                }

                // Get rows
                $rowStmt = $conn->prepare("SELECT sub_question_text FROM sub_questions WHERE main_question_index = ?");
                $rowStmt->bind_param("i", $questionIndex);
                $rowStmt->execute();
                $rowResult = $rowStmt->get_result();
                while ($rowRow = $rowResult->fetch_assoc()) {
                    $question['rows'][] = $rowRow['sub_question_text'];
                }

                $sectionMap[$sectionIndex]['questions'][] = $question;
            }
        }

        // Convert section map to array
        foreach ($sectionMap as $s) {
            $sections[] = $s;
        }

        // Build snapshot data
        $snapshotData = json_encode([
            'form_index' => $formId,
            'form_name' => $data['form_name'] ?? 'Untitled',
            'description' => $data['description'] ?? '',
            'sections' => $sections,
            'timestamp' => date('c')
        ]);

        if (!$snapshotData || json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Failed to encode snapshot: " . json_last_error_msg());
        }

        // Deactivate previous active snapshot
        $stmtDeactivate = $conn->prepare("UPDATE form_snapshots SET is_active = 0 WHERE form_index = ?");
        $stmtDeactivate->bind_param("i", $formId);
        $stmtDeactivate->execute();
        $stmtDeactivate->close();

        // Insert new snapshot
        $stmtInsert = $conn->prepare("INSERT INTO form_snapshots (form_index, snapshot_data, is_active) VALUES (?, ?, 1)");
        $stmtInsert->bind_param("is", $formId, $snapshotData);
        $stmtInsert->execute();
        $snapshotId = $conn->insert_id;
        $stmtInsert->close();

    } catch (Exception $e) {
        error_log("Snapshot failed: " . $e->getMessage());
        // Continue even if snapshot fails
    }

    // Now proceed with updating the form
    $conn->begin_transaction();

    // 1. Update form name and description
    if (isset($data['form_name']) || isset($data['description'])) {
        $name = $data['form_name'] ?? '';
        $desc = $data['description'] ?? '';

        $stmt = $conn->prepare("UPDATE forms SET form_name = ?, description = ? WHERE form_index = ?");
        $stmt->bind_param("ssi", $name, $desc, $formId);
        $stmt->execute();
        $stmt->close();
    }

    // 2. Delete existing sections and questions
    $stmt = $conn->prepare("DELETE FROM form_sections WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE mq FROM main_questions mq INNER JOIN choices c ON mq.main_question_index = c.main_question_index WHERE mq.form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE mq FROM main_questions mq INNER JOIN sub_questions sq ON mq.main_question_index = sq.main_question_index WHERE mq.form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE FROM main_questions WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    // 3. Insert updated sections and questions
    $sectionInsert = $conn->prepare("INSERT INTO form_sections (form_index, section_title, section_description, section_order, behavior) VALUES (?, ?, ?, ?, ?)");
    $questionInsert = $conn->prepare("INSERT INTO main_questions (form_index, section_index, main_question_text, type_index, is_required, include_other) VALUES (?, ?, ?, (SELECT type_index FROM question_types WHERE type_name = ?), ?, ?)");

    $choiceInsert = $conn->prepare("INSERT INTO choices (main_question_index, choice_text) VALUES (?, ?)");
    $subQuestionInsert = $conn->prepare("INSERT INTO sub_questions (main_question_index, sub_question_text) VALUES (?, ?)");

    foreach ($data['sections'] as $index => $section) {
        $title = $section['title'] ?? 'Untitled Section';
        $description = $section['description'] ?? '';
        $order = $index + 1;
        $behavior = $section['behavior'] ?? 'next-page';

        // Insert section
        $sectionInsert->bind_param("issis", $formId, $title, $description, $order, $behavior);
        $sectionInsert->execute();
        $sectionIndex = $conn->insert_id;

        // Insert questions
        if (isset($section['questions']) && is_array($section['questions'])) {
            foreach ($section['questions'] as $question) {
                $type = $question['type'] ?? 'short';
                $required = $question['required'] ? 1 : 0;
                $includeOther = isset($question['includeOther']) ? (int)$question['includeOther'] : 0;

                // Insert question
                $questionInsert->bind_param(
                    "iissii",
                    $formId,
                    $sectionIndex,
                    $question['question'],
                    $type,
                    $required,
                    $includeOther
                );
                $questionInsert->execute();
                $questionIndex = $conn->insert_id;

                // Insert options
                if (isset($question['options']) && is_array($question['options'])) {
                    foreach ($question['options'] as $option) {
                        $choiceInsert->bind_param("is", $questionIndex, $option);
                        $choiceInsert->execute();
                    }
                }

                // Insert rows (for grid)
                if (isset($question['rows']) && is_array($question['rows'])) {
                    foreach ($question['rows'] as $row) {
                        $subQuestionInsert->bind_param("is", $questionIndex, $row);
                        $subQuestionInsert->execute();
                    }
                }
            }
        }
    }

    $sectionInsert->close();
    $questionInsert->close();
    $choiceInsert->close();
    $subQuestionInsert->close();

    $conn->commit();
    echo json_encode(['success' => true, 'message' => 'Form updated successfully']);

} catch (Exception $e) {
    $conn->rollback();
    error_log("Update failed: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update form', 'message' => $e->getMessage()]);
}