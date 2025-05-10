<?php
header("Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// CORS Handling
$allowed_origins = ['http://localhost:3000', 'http://localhost:3001'];
if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowed_origins)) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Include mysqli connection
require_once '../connect.php'; // Make sure this defines $conn as a mysqli object

$input = file_get_contents('php://input');
$data = json_decode($input, true);

error_log("Raw Input: " . $input);
error_log("Decoded Data: " . print_r($data, true));

// Get form ID from query param
$formId = $_GET['id'] ?? null;

if (!$formId || !$data || !isset($data['title']) || !is_array($data['questions'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid form ID, title, or questions']);
    exit;
}

$title = trim($data['title']);
$description = $data['description'] ?? null;
$questions = $data['questions'];

if (empty($title)) {
    http_response_code(400);
    echo json_encode(['error' => 'Form title is required']);
    exit;
}

if (!is_array($questions) || count($questions) === 0) {
    http_response_code(400);
    echo json_encode(['error' => 'At least one question is required']);
    exit;
}

// Begin transaction (manual via autocommit)
$conn->autocommit(FALSE); // Turn off auto-commit

try {
    // 1. Check if form exists
    $stmt = $conn->prepare("SELECT * FROM forms WHERE form_index = ?");
    $stmt->bind_param("s", $formId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        http_response_code(404);
        throw new Exception("Form not found");
    }

    // 2. Update form metadata
    $stmt = $conn->prepare("UPDATE forms SET form_name = ?, description = ? WHERE form_index = ?");
    $stmt->bind_param("sss", $title, $description, $formId);
    $stmt->execute();

    // 3. Delete existing structure
    $stmt = $conn->prepare("DELETE FROM sub_questions WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)");
    $stmt->bind_param("s", $formId);
    $stmt->execute();

    $stmt = $conn->prepare("DELETE FROM choices WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)");
    $stmt->bind_param("s", $formId);
    $stmt->execute();

    $stmt = $conn->prepare("DELETE FROM main_questions WHERE form_index = ?");
    $stmt->bind_param("s", $formId);
    $stmt->execute();

    // 4. Re-insert all questions
    foreach ($questions as $q) {
        if (!isset($q['question'], $q['type'])) {
            throw new Exception("Missing question or type");
        }

        $questionText = trim($q['question']);
        $type = $q['type'];
        $required = $q['required'] ?? false;

        // Get type_index
        $stmt = $conn->prepare("SELECT type_index FROM question_types WHERE type_name = ?");
        $stmt->bind_param("s", $type);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            throw new Exception("Invalid question type: $type");
        }

        $typeRow = $result->fetch_assoc();
        $typeId = $typeRow['type_index'];

        // Insert main question
        $stmt = $conn->prepare("INSERT INTO main_questions (form_index, main_question_text, type_index, is_required) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $formId, $questionText, $typeId, $required);
        $stmt->execute();
        $questionId = $stmt->insert_id;

        // Insert choices (options)
        if (!empty($q['options']) && is_array($q['options'])) {
            foreach ($q['options'] as $opt) {
                $text = is_string($opt) ? $opt : ($opt['choice_text'] ?? '');
                $text = trim($text);
                if (!empty($text)) {
                    $stmt = $conn->prepare("INSERT INTO choices (main_question_index, choice_text) VALUES (?, ?)");
                    $stmt->bind_param("ss", $questionId, $text);
                    $stmt->execute();
                }
            }
        }

        // Insert subquestions (rows)
        if (!empty($q['rows']) && is_array($q['rows'])) {
            foreach ($q['rows'] as $row) {
                $text = trim($row);
                if (!empty($text)) {
                    $stmt = $conn->prepare("INSERT INTO sub_questions (main_question_index, sub_question_text) VALUES (?, ?)");
                    $stmt->bind_param("ss", $questionId, $text);
                    $stmt->execute();
                }
            }
        }
    }

    $conn->commit();
    echo json_encode([
        'message' => 'Form updated successfully',
        'id' => $formId
    ]);
} catch (Exception $e) {
    $conn->rollback();
    error_log("Error updating form: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to update form',
        'details' => $e->getMessage()
    ]);
}

$conn->autocommit(TRUE); // Turn auto-commit back on
?>