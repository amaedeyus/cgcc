<?php
header('Content-Type: application/json');
require_once '../connect3.php';

try {
    $query = "SELECT 
                p.program_index,
                p.program_code,
                p.program_name,
                d.dept_code,
                d.dept_title
              FROM programs p
              JOIN departments d ON p.dept_index = d.dept_index
              ORDER BY p.program_name";
    
    $result = $conn->query($query);
    
    $programs = [];
    while ($row = $result->fetch_assoc()) {
        $programs[] = [
            'program_index' => $row['program_index'],
            'program_code' => $row['program_code'],
            'program_name' => $row['program_name'],
            'department' => $row['dept_code'] . ' - ' . $row['dept_title']
        ];
    }
    
    echo json_encode($programs);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch programs', 'message' => $e->getMessage()]);
}

$conn->close();
?>