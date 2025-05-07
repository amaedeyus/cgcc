<?php
header("Access-Control-Allow-Methods: POST, OPTIONS");
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

// Validate input
if (!$data || !isset($data['title']) || !is_array($data['questions'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing title or questions']);
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

// Begin transaction
$conn->autocommit(FALSE); // Turn off auto-commit

try {
    // Insert form
    $stmt = $conn->prepare("INSERT INTO Forms (Form_Name, Description) VALUES (?, ?)");
    $stmt->bind_param("ss", $title, $description);
    $stmt->execute();
    $formId = $stmt->insert_id;

    foreach ($questions as $q) {
        if (!isset($q['question'], $q['type'])) {
            throw new Exception("Missing question or type");
        }

        $questionText = trim($q['question']);
        $type = $q['type'];
        $required = $q['required'] ?? false;

        // Get QType_ID
        $stmt = $conn->prepare("SELECT QType_ID FROM Question_Type WHERE Question_Type = ?");
        $stmt->bind_param("s", $type);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            throw new Exception("Invalid question type: $type");
        }

        $typeRow = $result->fetch_assoc();
        $typeId = $typeRow['QType_ID'];

        // Insert main question
        $stmt = $conn->prepare("INSERT INTO Main_Questions (Form_ID, Main_Question, QType_ID, Required) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $formId, $questionText, $typeId, $required);
        $stmt->execute();
        $questionId = $stmt->insert_id;

        // Insert choices (options)
        if (!empty($q['options']) && is_array($q['options'])) {
            foreach ($q['options'] as $opt) {
                $text = is_string($opt) ? $opt : ($opt['Choice_Text'] ?? '');
                $text = trim($text);
                if (!empty($text)) {
                    $stmt = $conn->prepare("INSERT INTO Choices (Main_Question_ID, Choice_Text) VALUES (?, ?)");
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
                    $stmt = $conn->prepare("INSERT INTO Sub_Question (Main_Question_ID, Sub_Question) VALUES (?, ?)");
                    $stmt->bind_param("ss", $questionId, $text);
                    $stmt->execute();
                }
            }
        }
    }

    $conn->commit();
    echo json_encode([
        'message' => 'Form created successfully',
        'id' => $formId
    ]);
} catch (Exception $e) {
    $conn->rollback();
    error_log("Error creating form: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => 'Failed to create form',
        'details' => $e->getMessage()
    ]);
}

$conn->autocommit(TRUE); // Turn auto-commit back on
?>