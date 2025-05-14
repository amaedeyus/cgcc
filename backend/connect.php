<?php
header("Content-Type: application/json");

$host = "localhost";
$username = "root";
$password = "";
$database = "form_builder";

// Create connection
$conn = new mysqli($host, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed', 'message' => $conn->connect_error]);
    exit;
}

// Optional: Set charset
$conn->set_charset("utf8mb4");