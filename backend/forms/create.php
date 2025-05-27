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

require_once '../connect3.php';

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

        $questionInsert = $conn->prepare("INSERT INTO main_questions (form_index, form_section_index, main_question_text, type_index, is_required, include_other) VALUES (?, ?, ?, (SELECT type_index FROM question_types WHERE type_name = ?), ?, ?)");
        if (!$questionInsert) throw new Exception("Prepare main_questions failed: " . $conn->error);

        $choiceInsert = $conn->prepare("INSERT INTO choices (main_question_index, choice_text) VALUES (?, ?)");
        if (!$choiceInsert) throw new Exception("Prepare choices failed: " . $conn->error);

        $subQuestionInsert = $conn->prepare("INSERT INTO sub_questions (main_question_index, sub_question_text) VALUES (?, ?)");
        if (!$subQuestionInsert) throw new Exception("Prepare sub_questions failed: " . $conn->error);

        foreach ($data['sections'] as $sectionOrder => $section) {
            $title = $section['title'] ?? 'Untitled Section';
            $description = $section['description'] ?? '';
            $behavior = $section['behavior'] ?? 'next-page';

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

    // 3. Create snapshot with proper format
    try {
        // Fetch complete form structure with proper IDs
        $stmt = $conn->prepare("
            SELECT 
                f.form_index,
                f.form_name,
                f.description,
                fs.form_section_index,
                fs.section_title,
                fs.section_description,
                fs.section_order,
                IFNULL(fs.behavior, 'next-page') as behavior,
                q.main_question_index,
                q.main_question_text,
                qt.type_name AS type_name,
                q.is_required,
                IFNULL(q.include_other, 0) AS include_other,
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

        $formData = [
            'form_index' => $formId,
            'form_name' => $formName,
            'description' => $description,
            'sections' => [],
            'questions' => [],
            'timestamp' => date('c')
        ];

        $sectionMap = [];
        $questionMap = [];

        while ($row = $result->fetch_assoc()) {
            // Build sections structure
            if (!isset($sectionMap[$row['form_section_index']])) {
                $sectionMap[$row['form_section_index']] = [
                    'form_section_index' => $row['form_section_index'],
                    'section_title' => $row['section_title'],
                    'section_description' => $row['section_description'],
                    'section_order' => $row['section_order'],
                    'behavior' => $row['behavior']
                ];
            }

            // Build questions structure
            if ($row['main_question_index'] && !isset($questionMap[$row['main_question_index']])) {
                $questionMap[$row['main_question_index']] = [
                    'main_question_index' => $row['main_question_index'],
                    'main_question_text' => $row['main_question_text'],
                    'type' => $row['type_name'],
                    'is_required' => (bool)$row['is_required'],
                    'include_other' => (bool)$row['include_other'],
                    'options' => [],
                    'rows' => [],
                    'form_section_index' => $row['form_section_index']
                ];
            }

            // Add choices if they exist
            if ($row['choice_index'] && $row['choice_text']) {
                $questionMap[$row['main_question_index']]['options'][] = [
                    'choice_index' => $row['choice_index'],
                    'choice_text' => $row['choice_text']
                ];
            }

            // Add subquestions if they exist
            if ($row['sub_question_index'] && $row['sub_question_text']) {
                $questionMap[$row['main_question_index']]['rows'][] = $row['sub_question_text'];
            }
        }

        // Organize questions by section
        foreach ($questionMap as $question) {
            $formData['questions'][] = $question;
            if (!isset($sectionMap[$question['form_section_index']]['questions'])) {
                $sectionMap[$question['form_section_index']]['questions'] = [];
            }
            $sectionMap[$question['form_section_index']]['questions'][] = $question['main_question_index'];
        }

        $formData['sections'] = array_values($sectionMap);

        $snapshotData = json_encode($formData, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
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

    // Return success response
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