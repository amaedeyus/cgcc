<?php
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$pass = "";
$db = "form_builder";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed', 'message' => $conn->connect_error]);
    exit;
}

// Optional: Set charset
$conn->set_charset("utf8mb4");
?>