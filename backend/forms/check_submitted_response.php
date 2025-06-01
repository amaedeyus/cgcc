<?php
session_start();

// Include your database configuration
require_once '../connect.php';

// Ensure the user is authenticated
if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

$user_index = $_SESSION['user_index'];
$student_index = $_SESSION['student_index'];
$form_index = isset($_GET['formId']) ? intval($_GET['formId']) : null;

if (!$form_index) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid form ID']);
    exit;
}

try {

    // Check if there's any submitted response (is_autosave = 0)
    $stmt = $conn->prepare("
        SELECT 1 FROM responses 
        WHERE form_index = ? AND student_index = ? AND is_autosave = 0
        LIMIT 1
    ");
    $stmt->bind_param("ii", $form_index, $student_index);
    $stmt->execute();
    $result = $stmt->get_result();
    
    echo json_encode(['hasSubmitted' => $result->num_rows > 0]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>