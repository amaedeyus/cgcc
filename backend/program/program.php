<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
require_once '../connect.php';

$method = $_SERVER['REQUEST_METHOD'];

try {
    switch ($method) {
        case 'GET':
            // Check if dept_index is provided
            $dept_index = isset($_GET['dept_index']) ? (int)$_GET['dept_index'] : null;

            // Base query
            $query = "SELECT p.program_index, p.program_code, p.program_name, p.counselor_index, p.dept_index, d.dept_code 
                      FROM programs p
                      JOIN departments d ON p.dept_index = d.dept_index
                      WHERE 1=1";

            $params = [];
            $types = "";

            // Add department filter if provided
            if ($dept_index !== null) {
                $query .= " AND p.dept_index = ?";
                $params[] = $dept_index;
                $types .= "i";
            }

            // Order by department code and program code
            $query .= " ORDER BY d.dept_code, p.program_code";

            // Prepare and execute the query
            $stmt = $conn->prepare($query);

            if (!empty($params)) {
                $stmt->bind_param($types, ...$params);
            }

            $stmt->execute();
            $result = $stmt->get_result();

            if (!$result) {
                http_response_code(500);
                echo json_encode(['error' => 'Failed to fetch programs']);
                exit;
            }

            $programs = [];
            while ($row = $result->fetch_assoc()) {
                $programs[] = [
                    'program_index' => $row['program_index'],
                    'program_code' => $row['program_code'],
                    'program_name' => $row['program_name'],
                    'dept_index' => $row['dept_index'],
                    'dept_code' => $row['dept_code'],
                    'counselor_index' => $row['counselor_index']
                ];
            }

            echo json_encode($programs);
            break;
            
        case 'POST':
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
            } else {
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
            }
            
            $stmt->execute();
            echo json_encode(['success' => true]);
            break;
            
        case 'DELETE':
            $id = $_GET['id'] ?? null;
            
            if (!$id) {
                throw new Exception("Program ID is required");
            }
            
            // Check sections
            $stmt = $conn->prepare("SELECT COUNT(*) as section_count FROM sections WHERE program_index = ?");
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