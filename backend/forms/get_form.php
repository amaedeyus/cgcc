<?php
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

// ✅ CORS Fix — Only allow known origins
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

// Fetch questions for the form
$query = "SELECT mq.*, qt.type_name 
          FROM main_questions mq
          JOIN question_types qt ON mq.type_index = qt.type_index 
          WHERE mq.form_index = ?
          ORDER BY mq.main_question_index";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $formId);
$stmt->execute();
$questionsResult = $stmt->get_result();

$questions = [];
while ($q = $questionsResult->fetch_assoc()) {
    // Get options
    $query = "SELECT * FROM choices WHERE main_question_index = ? ORDER BY choice_index";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $q['main_question_index']);
    $stmt->execute();
    $choicesResult = $stmt->get_result();
    $options = $choicesResult->fetch_all(MYSQLI_ASSOC);

    // Get sub-questions (rows)
    $query = "SELECT * FROM sub_questions WHERE main_question_index = ? ORDER BY sub_question_index";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $q['main_question_index']);
    $stmt->execute();
    $subQResult = $stmt->get_result();
    $rows = array_column($subQResult->fetch_all(MYSQLI_ASSOC), 'sub_question_text');

    // Match expected structure
    $questions[] = [
        'main_question_index' => $q['main_question_index'],
        'main_question_text' => $q['main_question_text'],
        'type_name' => $q['type_name'],
        'is_required' => (bool)$q['is_required'],
        'options' => $options,
        'rows' => $rows
    ];
}

// Final response
echo json_encode([
    'form_index' => $form['form_index'],
    'form_name' => $form['form_name'],
    'description' => $form['description'],
    'questions' => $questions
]);

$stmt->close();
$conn->close();
?>
