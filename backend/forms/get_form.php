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
$query = "SELECT * FROM Forms WHERE Form_ID = ?";
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
$query = "SELECT mq.*, qt.Question_Type 
          FROM Main_Questions mq
          JOIN Question_Type qt ON mq.QType_ID = qt.QType_ID 
          WHERE mq.Form_ID = ?
          ORDER BY mq.Main_Question_ID";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $formId);
$stmt->execute();
$questionsResult = $stmt->get_result();

$questions = [];
while ($q = $questionsResult->fetch_assoc()) {
    // Get options
    $query = "SELECT * FROM Choices WHERE Main_Question_ID = ? ORDER BY Choice_ID";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $q['Main_Question_ID']);
    $stmt->execute();
    $choicesResult = $stmt->get_result();
    $options = $choicesResult->fetch_all(MYSQLI_ASSOC);

    // Get sub-questions (rows)
    $query = "SELECT * FROM Sub_Question WHERE Main_Question_ID = ? ORDER BY Sub_Question_ID";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $q['Main_Question_ID']);
    $stmt->execute();
    $subQResult = $stmt->get_result();
    $rows = array_column($subQResult->fetch_all(MYSQLI_ASSOC), 'Sub_Question');

    // Match expected structure
    $questions[] = [
        'Main_Question_ID' => $q['Main_Question_ID'],
        'Main_Question' => $q['Main_Question'],
        'Question_Type' => $q['Question_Type'],
        'Required' => (bool)$q['Required'],
        'options' => $options,
        'rows' => $rows
    ];
}

// Final response
echo json_encode([
    'Form_ID' => $form['Form_ID'],
    'Form_Name' => $form['Form_Name'],
    'Description' => $form['Description'],
    'questions' => $questions
]);

$stmt->close();
$conn->close();
?>
