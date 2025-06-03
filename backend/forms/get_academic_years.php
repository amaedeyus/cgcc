<?php
require_once '../connect.php';

// Get unique academic years from responses table
$query = "SELECT DISTINCT academic_year 
          FROM responses 
          WHERE academic_year IS NOT NULL 
          ORDER BY academic_year DESC";

$result = $conn->query($query);

if (!$result) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch academic years']);
    exit;
}

$years = [];
while ($row = $result->fetch_assoc()) {
    $years[] = $row['academic_year'];
}

// Output as JSON
header('Content-Type: application/json');
echo json_encode($years);
?> 