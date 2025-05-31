<?php
header('Content-Type: application/json');
require_once '../../connect.php';

try {
    $query = "SELECT 
                u.user_index, 
                c.counselor_index,
                c.counselor_number,
                c.first_name, 
                c.last_name, 
                u.email, 
                c.status,
                GROUP_CONCAT(p.program_code) as program_codes,
                GROUP_CONCAT(p.program_name) as program_names
              FROM counselors c
              JOIN users u ON c.user_index = u.user_index
              LEFT JOIN programs p ON c.counselor_index = p.counselor_index
              WHERE u.type = 'counselor' AND c.status != 'deleted'
              GROUP BY c.counselor_index";
    
    $result = $conn->query($query);
    
    $counselors = [];
    while ($row = $result->fetch_assoc()) {
        $programs = [];
        if (!empty($row['program_codes'])) {
            $codes = explode(',', $row['program_codes']);
            $names = explode(',', $row['program_names']);
            
            for ($i = 0; $i < count($codes); $i++) {
                $programs[] = [
                    'program_code' => $codes[$i],
                    'program_name' => $names[$i]
                ];
            }
        }
        
        $counselors[] = [
            'user_index' => $row['user_index'],
            'counselor_index' => $row['counselor_index'],
            'counselor_number' => $row['counselor_number'],
            'first_name' => $row['first_name'],
            'last_name' => $row['last_name'],
            'email' => $row['email'],
            'status' => $row['status'],
            'programs' => $programs
        ];
    }
    
    echo json_encode($counselors);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch counselors', 'message' => $e->getMessage()]);
}

$conn->close();
?>