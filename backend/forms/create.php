<?php

session_start();

if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

$userType = $_SESSION['user_type'];

// Optional: Log user type
error_log("User type: " . $userType);

// create.php

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

if (!isset($data['form_name'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Form name is required']);
    exit;
}

try {
    $conn->begin_transaction();

    // 1. Insert the form
    $formName = $data['form_name'];
    $description = $data['description'] ?? '';
    
    $stmt = $conn->prepare("INSERT INTO forms (form_name, description) VALUES (?, ?)");
    if (!$stmt) throw new Exception("Insert form prepare failed: " . $conn->error);

    $stmt->bind_param("ss", $formName, $description);
    if (!$stmt->execute()) throw new Exception("Insert form execute failed: " . $stmt->error);

    $formId = $conn->insert_id;
    $stmt->close();

    // 2. Handle sections and questions
    if (isset($data['sections']) && is_array($data['sections'])) {

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

                    // Insert question
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

                    // Insert rows (for grid)
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

    // 3. ✅ Create a snapshot of this new form
    try {
        // Build the full form structure as JSON
        $formStructure = [
            'form_index' => $formId,
            'form_name' => $formName,
            'description' => $description,
            'sections' => []
        ];

        // Rebuild sections and questions for snapshot
        $formStructure['sections'] = array_map(function ($sectionData) use (&$conn) {
            $section = [
                'section_index' => $sectionData['title'],
                'section_title' => $sectionData['title'],
                'section_description' => $sectionData['description'] ?? '',
                'behavior' => $sectionData['behavior'] ?? 'next-page',
                'questions' => []
            ];

            if (isset($sectionData['questions']) && is_array($sectionData['questions'])) {
                foreach ($sectionData['questions'] as $question) {
                    $section['questions'][] = [
                        'main_question_index' => null, // Will be assigned by DB
                        'main_question_text' => $question['question'] ?? '',
                        'type' => $question['type'] ?? 'short',
                        'is_required' => $question['required'] ? 1 : 0,
                        'include_other' => isset($question['includeOther']) ? (int)$question['includeOther'] : 0,
                        'options' => $question['options'] ?? [],
                        'rows' => $question['rows'] ?? []
                    ];
                }
            }

            return $section;
        }, $data['sections']);

        $snapshotData = json_encode($formStructure, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        if ($snapshotData === false) {
            throw new Exception("Failed to encode snapshot: " . json_last_error_msg());
        }

        // Insert into form_snapshots
        $stmtSnapshot = $conn->prepare("INSERT INTO form_snapshots (form_index, snapshot_data, is_active) VALUES (?, ?, 1)");
        if (!$stmtSnapshot) {
            throw new Exception("Snapshot prepare failed: " . $conn->error);
        }

        $stmtSnapshot->bind_param("is", $formId, $snapshotData);
        if (!$stmtSnapshot->execute()) {
            throw new Exception("Snapshot insert failed: " . $stmtSnapshot->error);
        }
        $stmtSnapshot->close();

    } catch (Exception $e) {
        error_log("Snapshot creation failed during create: " . $e->getMessage());
        // Continue even if snapshot fails
    }

    $conn->commit();

    // Return success response including the new form ID
    echo json_encode([
        'success' => true,
        'message' => 'Form created successfully',
        'form_index' => $formId
    ]);

} catch (Exception $e) {
    $conn->rollback();
    error_log("Create failed: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to create form',
        'message' => $e->getMessage()
    ]);
}