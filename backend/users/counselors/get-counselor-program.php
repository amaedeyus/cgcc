<?php
header('Content-Type: application/json');
require_once '../../connect3.php';

$counselorId = $_GET['id'] ?? null;

if (!$counselorId) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing counselor ID']);
    exit;
}

try {
    $query = "SELECT 
                p.program_code,
                p.program_name
              FROM programs p
              WHERE p.counselor_index = ?";
    
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $counselorId);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $programs = [];
    while ($row = $result->fetch_assoc()) {
        $programs[] = [
            'program_code' => $row['program_code'],
            'program_name' => $row['program_name']
        ];
    }
    
    echo json_encode($programs);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch assigned programs', 'message' => $e->getMessage()]);
}

$conn->close();
?>