<?php
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

// CORS Handling - Only allow known origins
$allowed_origins = ['http://localhost:3000', 'http://localhost:3001'];
if (isset($_SERVER['HTTP_ORIGIN']) && in_array($_SERVER['HTTP_ORIGIN'], $allowed_origins)) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../connect.php';

$formId = $_GET['id'] ?? null;

if (!$formId || !is_numeric($formId)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid form ID']);
    exit;
}

// Fetch form details
$query = "SELECT * FROM forms WHERE form_index = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $formId);
$stmt->execute();
$formResult = $stmt->get_result();

if ($formResult->num_rows === 0) {
    http_response_code(404);
    echo json_encode(['error' => 'Form not found']);
    exit;
}

$form = $formResult->fetch_assoc();

// Fetch sections for the form
$query = "SELECT * FROM form_sections WHERE form_index = ? ORDER BY section_order";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $formId);
$stmt->execute();
$sectionsResult = $stmt->get_result();

$sections = [];

while ($section = $sectionsResult->fetch_assoc()) {
    // Fetch questions for this section
    $query = "SELECT mq.*, qt.type_name 
              FROM main_questions mq
              JOIN question_types qt ON mq.type_index = qt.type_index 
              WHERE mq.section_index = ?
              ORDER BY mq.main_question_index";
    $stmt2 = $conn->prepare($query);
    $stmt2->bind_param("i", $section['section_index']);
    $stmt2->execute();
    $questionsResult = $stmt2->get_result();

    $questions = [];
    while ($q = $questionsResult->fetch_assoc()) {
        // Get options for multiple choice, checkbox, dropdown, grid questions
        $options = [];
        if (in_array($q['type_name'], ['multiple', 'checkbox', 'dropdown', 'grid'])) {
            $query = "SELECT * FROM choices WHERE main_question_index = ? ORDER BY choice_index";
            $stmt3 = $conn->prepare($query);
            $stmt3->bind_param("i", $q['main_question_index']);
            $stmt3->execute();
            $choicesResult = $stmt3->get_result();
            $options = $choicesResult->fetch_all(MYSQLI_ASSOC);
        }

        // Get sub-questions (rows) for grid questions
        $rows = [];
        if ($q['type_name'] === 'grid') {
            $query = "SELECT * FROM sub_questions WHERE main_question_index = ? ORDER BY sub_question_index";
            $stmt4 = $conn->prepare($query);
            $stmt4->bind_param("i", $q['main_question_index']);
            $stmt4->execute();
            $subQResult = $stmt4->get_result();
            $rows = $subQResult->fetch_all(MYSQLI_ASSOC);
        }

        $questionData = [
            'id' => (string)$q['main_question_index'],
            'question' => $q['main_question_text'],
            'type' => $q['type_name'],
            'required' => (bool)$q['is_required'],
            'options' => array_map(function($opt) {
                return [
                    'id' => (string)$opt['choice_index'],
                    'text' => $opt['choice_text']
                ];
            }, $options),
            'rows' => array_map(function($row) {
                return [
                    'id' => (string)$row['sub_question_index'],
                    'text' => $row['sub_question_text']
                ];
            }, $rows)
        ];

        $questions[] = $questionData;
    }

    $sections[] = [
        'id' => (string)$section['section_index'],
        'title' => $section['section_title'],
        'description' => $section['section_description'],
        'order' => (int)$section['section_order'],
        'questions' => $questions
    ];
}

// Final response
echo json_encode([
    'form_id' => (string)$form['form_index'],
    'title' => $form['form_name'],
    'description' => $form['description'],
    'sections' => $sections
], JSON_NUMERIC_CHECK);

// Close all statements
if (isset($stmt)) $stmt->close();
if (isset($stmt2)) $stmt2->close();
if (isset($stmt3)) $stmt3->close();
if (isset($stmt4)) $stmt4->close();

$conn->close();
?>