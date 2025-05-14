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
require_once '../connect.php';

$input = file_get_contents('php://input');
$data = json_decode($input, true);
$formId = $_GET['id'] ?? null;

error_log("Raw Input: " . $input);
error_log("Decoded Data: " . print_r($data, true));

// Validate input
if (!$formId || !$data || !isset($data['title']) || !isset($data['sections'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid form ID, title, or sections']);
    exit;
}

$title = trim($data['title']);
$description = $data['description'] ?? null;
$sections = $data['sections'];

if (empty($title)) {
    http_response_code(400);
    echo json_encode(['error' => 'Form title is required']);
    exit;
}

if (!is_array($sections) || count($sections) === 0) {
    http_response_code(400);
    echo json_encode(['error' => 'At least one section is required']);
    exit;
}

// Begin transaction
$conn->autocommit(FALSE);

try {
    // 1. Check if form exists
    $stmt = $conn->prepare("SELECT * FROM forms WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        http_response_code(404);
        throw new Exception("Form not found");
    }

    // 2. Update form metadata
    $stmt = $conn->prepare("UPDATE forms SET form_name = ?, description = ? WHERE form_index = ?");
    $stmt->bind_param("ssi", $title, $description, $formId);
    $stmt->execute();

    // 3. Delete existing structure
    $stmt = $conn->prepare("DELETE FROM sub_questions WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)");
    $stmt->bind_param("i", $formId);
    $stmt->execute();

    $stmt = $conn->prepare("DELETE FROM choices WHERE main_question_index IN (SELECT main_question_index FROM main_questions WHERE form_index = ?)");
    $stmt->bind_param("i", $formId);
    $stmt->execute();

    $stmt = $conn->prepare("DELETE FROM main_questions WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();

    $stmt = $conn->prepare("DELETE FROM form_sections WHERE form_index = ?");
    $stmt->bind_param("i", $formId);
    $stmt->execute();

    // 4. Re-insert all sections and questions
    $order = 1;
    foreach ($sections as $sectionData) {
        // Insert section
        $stmt = $conn->prepare("INSERT INTO form_sections (form_index, section_title, section_description, section_order) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("issi", $formId, $sectionData['title'], $sectionData['description'], $order);
        $stmt->execute();
        $sectionId = $stmt->insert_id;
        $order++;

        foreach ($sectionData['questions'] as $q) {
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

            // Insert main question with section reference
            $stmt = $conn->prepare("INSERT INTO main_questions (form_index, section_index, main_question_text, type_index, is_required) VALUES (?, ?, ?, ?, ?)");
            $requiredInt = $required ? 1 : 0;
            $stmt->bind_param("iisii", $formId, $sectionId, $questionText, $typeId, $requiredInt);
            $stmt->execute();
            $questionId = $stmt->insert_id;

            // Insert choices (options)
            if (!empty($q['options']) && is_array($q['options'])) {
                foreach ($q['options'] as $opt) {
                    $text = is_string($opt) ? $opt : ($opt['choice_text'] ?? '');
                    $text = trim($text);
                    if (!empty($text)) {
                        $stmt = $conn->prepare("INSERT INTO choices (main_question_index, choice_text) VALUES (?, ?)");
                        $stmt->bind_param("is", $questionId, $text);
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
                        $stmt->bind_param("is", $questionId, $text);
                        $stmt->execute();
                    }
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

$conn->autocommit(TRUE);
?>