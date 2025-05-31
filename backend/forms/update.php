<?php
session_start();

// Debugging: Log session data
file_put_contents('session_debug.log', print_r($_SESSION, true), FILE_APPEND);

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

function logFormData($data, $filename = 'form_debug.log') {
    $timestamp = date('Y-m-d H:i:s');
    $logEntry = "[$timestamp] Received Form Data:\n" . print_r($data, true) . "\n" . str_repeat('-', 80) . "\n\n";
    file_put_contents($filename, $logEntry, FILE_APPEND);
}
// Optional: Log user type
error_log("User type: " . $userType);

header("Access-Control-Allow-Credentials: true");
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

logFormData($data);

$formId = (int)$data['form_index'];

try {
    // Proceed with updating the form first
    $conn->begin_transaction();

    // 1. Update form name and description
    if (isset($data['form_name']) || isset($data['description']) || isset($data['academic_year'])) {
        $name = $data['form_name'] ?? '';
        $desc = $data['description'] ?? '';
        $academicYear = $data['academic_year'] ?? ''; // Get academic year if provided

        $stmt = $conn->prepare("UPDATE forms SET form_name = ?, description = ?, academic_year = ? WHERE form_index = ?");
        $stmt->bind_param("sssi", $name, $desc, $academicYear, $formId);
        $stmt->execute();
        $stmt->close();
    }


    // First delete dependent tables
    $stmt = $conn->prepare("DELETE FROM choices WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE FROM sub_questions WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE FROM main_questions WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    $stmt = $conn->prepare("DELETE FROM form_sections WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $stmt->close();

    // 3. Insert updated sections and questions
    $sectionInsert = $conn->prepare("INSERT INTO form_sections (form_index, section_title, section_description, section_order, behavior) VALUES (?, ?, ?, ?, ?)");
    $questionInsert = $conn->prepare("INSERT INTO main_questions (form_index, form_section_index, main_question_text, type_index, subtype, is_required) VALUES (?, ?, ?, (SELECT type_index FROM question_types WHERE type_name = ?), ?, ?)");
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
                $subtype = ($type === 'short') ? ($question['subtype'] ?? 'text') : null;

                // Update the bind_param call:
                $questionInsert->bind_param(
                    "iisssi", // Changed to 6 parameters
                    $formId,
                    $sectionIndex,
                    $question['question'],
                    $type,
                    $subtype, // New subtype parameter
                    $required
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

    // Now take snapshot with updated indexes
    try {
        $stmt = $conn->prepare("
            SELECT 
                f.form_index,
                f.form_name,
                f.description,
                fs.form_section_index,
                fs.section_title,
                fs.section_description,
                fs.section_order,
                IFNULL(fs.behavior, 'same-page') as behavior,
                q.main_question_index,
                q.main_question_text,
                qt.type_name AS type_name,
                q.subtype,
                q.is_required,
                c.choice_index,
                c.choice_text,
                sq.sub_question_index,
                sq.sub_question_text
            FROM forms f
            LEFT JOIN form_sections fs ON f.form_index = fs.form_index
            LEFT JOIN main_questions q ON fs.form_section_index = q.form_section_index
            LEFT JOIN question_types qt ON q.type_index = qt.type_index
            LEFT JOIN choices c ON q.main_question_index = c.main_question_index
            LEFT JOIN sub_questions sq ON q.main_question_index = sq.main_question_index
            WHERE f.form_index = ?
            ORDER BY fs.section_order, q.main_question_index, c.choice_index, sq.sub_question_index
        ");
        $stmt->bind_param("i", $formId);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            throw new Exception("No form data found");
        }

        $form = null;
        $sections = [];
        $allQuestions = [];

        $sectionMap = [];
        $questionMap = [];
        $uniqueChoices = []; // Track unique choices per question

        while ($row = $result->fetch_assoc()) {
            if (!$form) {
                $form = [
                    'form_index' => $row['form_index'],
                    'form_name' => $row['form_name'],
                    'description' => $row['description']
                ];
            }

            $sectionId = $row['form_section_index'];
            if (!isset($sectionMap[$sectionId])) {
                $sectionMap[$sectionId] = [
                    'id' => (string)$sectionId,
                    'title' => $row['section_title'],
                    'description' => $row['section_description'] ?? '',
                    'order' => $row['section_order'],
                    'behavior' => $row['behavior'],
                    'questions' => []
                ];
            }

            $questionId = $row['main_question_index'];
            if ($questionId && !isset($questionMap[$questionId])) {
                $questionMap[$questionId] = [
                    'id' => (string)$questionId,
                    'question' => $row['main_question_text'],
                    'type' => $row['type_name'],
                    'subtype' => $row['subtype'],
                    'required' => (bool)$row['is_required'],
                    'options' => [],
                    'rows' => [],
                    'form_section_index' => $sectionId
                ];
                $uniqueChoices[$questionId] = []; // Initialize for this question
            }

            // Add unique choices if they exist
            if ($row['choice_index'] !== null && $row['choice_text'] !== null) {
                $choiceKey = $row['choice_index'].'_'.$row['choice_text'];
                if (!in_array($choiceKey, $uniqueChoices[$questionId])) {
                    $questionMap[$questionId]['options'][] = [
                        'choice_index' => $row['choice_index'],
                        'choice_text' => $row['choice_text']
                    ];
                    $uniqueChoices[$questionId][] = $choiceKey;
                }
            }

            // Add subquestions with their indexes if they exist
            if ($row['sub_question_index'] !== null && $row['sub_question_text'] !== null) {
                $questionMap[$questionId]['rows'][] = [
                    'sub_question_index' => $row['sub_question_index'],
                    'sub_question_text' => $row['sub_question_text']
                ];
            }
        }

        foreach ($questionMap as $qid => $qdata) {
            $sectionId = $qdata['form_section_index'];
            if (isset($sectionMap[$sectionId])) {
                $sectionMap[$sectionId]['questions'][] = $qid;
                $allQuestions[] = $qdata;
            }
        }

        $sections = array_values($sectionMap);

        if (empty($sections)) {
            $sections[] = [
                'id' => '0',
                'title' => 'Default Section',
                'description' => '',
                'order' => 1,
                'behavior' => 'same-page',
                'questions' => array_map(function($q) { return $q['id']; }, $allQuestions)
            ];
        }

        $snapshotData = json_encode([
            'form_index' => $form['form_index'],
            'form_name' => $form['form_name'],
            'description' => $form['description'],
            'sections' => $sections,
            'questions' => $allQuestions,
            'timestamp' => date('c')
        ], JSON_NUMERIC_CHECK);

        if (!$snapshotData || json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Failed to encode snapshot: " . json_last_error_msg());
        }

        $stmtDeactivate = $conn->prepare("UPDATE form_snapshots SET is_active = 0 WHERE form_index = ?");
        $stmtDeactivate->bind_param("i", $formId);
        $stmtDeactivate->execute();
        $stmtDeactivate->close();

        $stmtInsert = $conn->prepare("INSERT INTO form_snapshots (form_index, snapshot_data, is_active) VALUES (?, ?, 1)");
        $stmtInsert->bind_param("is", $formId, $snapshotData);
        $stmtInsert->execute();
        $snapshotId = $conn->insert_id;
        $stmtInsert->close();
    } catch (Exception $e) {
        error_log("Snapshot failed: " . $e->getMessage());
    }

    echo json_encode(['success' => true, 'message' => 'Form updated and snapshot saved']);

} catch (Exception $e) {
    $conn->rollback();
    error_log("Update failed: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update form', 'message' => $e->getMessage()]);
}
