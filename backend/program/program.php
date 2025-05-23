<?php
header('Content-Type: application/json');
require_once '../connect3.php';

$method = $_SERVER['REQUEST_METHOD'];

try {
    switch ($method) {
        case 'GET':
            $stmt = $conn->prepare("
                SELECT 
                    p.program_index,
                    p.program_code,
                    p.program_name,
                    d.dept_index,
                    d.dept_code,
                    d.dept_title
                FROM programs p
                JOIN departments d ON p.dept_index = d.dept_index
                ORDER BY p.program_name
            ");
            $stmt->execute();
            $result = $stmt->get_result();
            $programs = $result->fetch_all(MYSQLI_ASSOC);
            
            // Format the data like the second script
            $formattedPrograms = array_map(function($program) {
                return [
                    'program_index' => $program['program_index'],
                    'program_code' => $program['program_code'],
                    'program_name' => $program['program_name'],
                    'dept_index' => $program['dept_index'],
                ];
            }, $programs);
            
            echo json_encode($formattedPrograms);
            break;
            
        case 'POST':
            // Add or update program
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['program_code'])) {
                throw new Exception("Program code is required");
            }
            
            if (empty($data['program_name'])) {
                throw new Exception("Program name is required");
            }
            
            if (empty($data['dept_index'])) {
                throw new Exception("Department is required");
            }
            
            $counselorIndex = !empty($data['counselor_index']) ? $data['counselor_index'] : null;
            
            if (isset($data['program_index'])) {
                // Update existing program
                $stmt = $conn->prepare("
                    UPDATE programs 
                    SET program_code = ?, program_name = ?, dept_index = ?, counselor_index = ?
                    WHERE program_index = ?
                ");
                $stmt->bind_param(
                    "ssiii", 
                    $data['program_code'], 
                    $data['program_name'], 
                    $data['dept_index'], 
                    $counselorIndex,
                    $data['program_index']
                );
                $stmt->execute();
                
                if ($stmt->affected_rows === 0) {
                    throw new Exception("No program found with that ID");
                }
            } else {
                // Add new program
                $stmt = $conn->prepare("
                    INSERT INTO programs (program_code, program_name, dept_index, counselor_index)
                    VALUES (?, ?, ?, ?)
                ");
                $stmt->bind_param(
                    "ssii", 
                    $data['program_code'], 
                    $data['program_name'], 
                    $data['dept_index'], 
                    $counselorIndex
                );
                $stmt->execute();
            }
            
            echo json_encode(['success' => true]);
            break;
            
        case 'DELETE':
            // Delete program
            $id = $_GET['id'] ?? null;
            
            if (!$id) {
                throw new Exception("Program ID is required");
            }
            
            // Check if program has sections
            $stmt = $conn->prepare("SELECT COUNT(*) as section_count FROM sections WHERE program_id = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            
            if ($row['section_count'] > 0) {
                throw new Exception("Cannot delete program with associated sections");
            }
            
            $stmt = $conn->prepare("DELETE FROM programs WHERE program_index = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            
            if ($stmt->affected_rows === 0) {
                throw new Exception("No program found with that ID");
            }
            
            echo json_encode(['success' => true]);
            break;
            
        default:
            http_response_code(405);
            echo json_encode(['error' => 'Method not allowed']);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}

$conn->close();
?>