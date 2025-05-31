<?php
session_start();

if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Not logged in']);
    exit;
}

require_once '../connect.php';

$userIndex = $_SESSION['user_index'];

$stmt = $conn->prepare("SELECT student_index FROM students WHERE user_index = ?");
$stmt->bind_param("i", $userIndex);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    http_response_code(403);
    echo json_encode(['error' => 'No student record found']);
    exit;
}

$stmt->bind_result($studentId);
$stmt->fetch();

echo json_encode([
    'studentId' => $studentId
]);