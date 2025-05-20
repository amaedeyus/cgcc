<?php
// update_form.php

// Enable CORS and set headers
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

// Get raw POST data
$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['form_index'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Form ID missing']);
    exit;
}

$formId = (int)$data['form_index'];

try {
    $conn->begin_transaction();

    // 1. Update form name and description
    if (isset($data['form_name']) || isset($data['description'])) {
        $name = $data['form_name'] ?? '';
        $desc = $data['description'] ?? '';

        $stmt = $conn->prepare("UPDATE forms SET form_name = ?, description = ? WHERE form_index = ?");
        if (!$stmt) throw new Exception("Update form prepare failed: " . $conn->error);

        $stmt->bind_param("sss", $name, $desc, $formId);
        if (!$stmt->execute()) throw new Exception("Update form execute failed: " . $stmt->error);
        $stmt->close();
    }

    // 2. Handle sections
    if (isset($data['sections']) && is_array($data['sections'])) {

        // Delete existing sections and their questions
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

        // Prepare inserts
        $sectionInsert = $conn->prepare("INSERT INTO form_sections (form_index, section_title, section_description, section_order, behavior) VALUES (?, ?, ?, ?, ?)");
        if (!$sectionInsert) throw new Exception("Prepare form_sections failed: " . $conn->error);

        $questionInsert = $conn->prepare("INSERT INTO main_questions (form_index, section_index, main_question_text, type_index, is_required, include_other) VALUES (?, ?, ?, (SELECT type_index FROM question_types WHERE type_name = ?), ?, ?)");
        if (!$questionInsert) throw new Exception("Prepare main_questions failed: " . $conn->error);

        $choiceInsert = $conn->prepare("INSERT INTO choices (main_question_index, choice_text) VALUES (?, ?)");
        if (!$choiceInsert) throw new Exception("Prepare choices failed: " . $conn->error);

        $subQuestionInsert = $conn->prepare("INSERT INTO sub_questions (main_question_index, sub_question_text) VALUES (?, ?)");
        if (!$subQuestionInsert) throw new Exception("Prepare sub_questions failed: " . $conn->error);

        foreach ($data['sections'] as $sectionOrder => $section) {
            $title       = $section['title'] ?? 'Untitled Section';
            $description = $section['description'] ?? '';
            $behavior    = $section['behavior'] ?? 'next-page';

            // Insert section
            $sectionInsert->bind_param("issis", $formId, $title, $description, $sectionOrder, $behavior);
            if (!$sectionInsert->execute()) {
                throw new Exception("Section insert failed: " . $sectionInsert->error);
            }
            $sectionIndex = $conn->insert_id;

            // Insert questions
            if (isset($section['questions']) && is_array($section['questions'])) {
                foreach ($section['questions'] as $question) {
                    $type = $question['type'] ?? 'short';
                    $required = $question['required'] ? 1 : 0;
                    $includeOther = isset($question['includeOther']) ? (int)$question['includeOther'] : 0;

                    $questionText = $question['question'] ?? '';
                    $questionType = $type;

                    $questionInsert->bind_param(
                        "iissii",
                        $formId,
                        $sectionIndex,
                        $questionText,
                        $questionType,
                        $required,
                        $includeOther
                    );

                    if (!$questionInsert->execute()) {
                        throw new Exception("Question insert failed: " . $questionInsert->error);
                    }

                    $questionIndex = $conn->insert_id;

                    // Insert options
                    if (isset($question['options']) && is_array($question['options'])) {
                        foreach ($question['options'] as $option) {
                            $opt = $option;
                            $choiceInsert->bind_param("is", $questionIndex, $opt);
                            if (!$choiceInsert->execute()) {
                                throw new Exception("Option insert failed: " . $choiceInsert->error);
                            }
                        }
                    }

                    // Insert rows (for grid questions)
                    if (isset($question['rows']) && is_array($question['rows'])) {
                        foreach ($question['rows'] as $row) {
                            $r = $row;
                            $subQuestionInsert->bind_param("is", $questionIndex, $r);
                            if (!$subQuestionInsert->execute()) {
                                throw new Exception("Row insert failed: " . $subQuestionInsert->error);
                            }
                        }
                    }
                }
            }
        }

        $sectionInsert->close();
        $questionInsert->close();
        $choiceInsert->close();
        $subQuestionInsert->close();
    }

    $conn->commit();
    echo json_encode(['success' => true, 'message' => 'Form updated successfully']);

} catch (Exception $e) {
    $conn->rollback();
    error_log("Update failed: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update form', 'message' => $e->getMessage()]);
}