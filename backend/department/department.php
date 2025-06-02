<?php
header('Content-Type: application/json');
require_once '../connect.php';

$method = $_SERVER['REQUEST_METHOD'];

try {
    switch ($method) {
        case 'GET':
            // Fetch all departments
            $stmt = $conn->prepare("SELECT * FROM departments");
            $stmt->execute();
            $result = $stmt->get_result();
            $departments = $result->fetch_all(MYSQLI_ASSOC);
            
            echo json_encode($departments);
            break;
            
        case 'POST':
            // Add or update department
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['dept_code'])) {
                throw new Exception("Department code is required");
            }
            
            if (empty($data['dept_title'])) {
                throw new Exception("Department title is required");
            }
            
            if (isset($data['dept_index'])) {
                // Update existing department
                $stmt = $conn->prepare("UPDATE departments SET dept_code = ?, dept_title = ? WHERE dept_index = ?");
                $stmt->bind_param("ssi", $data['dept_code'], $data['dept_title'], $data['dept_index']);
                $stmt->execute();
                
                if ($stmt->affected_rows === 0) {
                    throw new Exception("No department found with that ID");
                }
            } else {
                // Add new department
                $stmt = $conn->prepare("INSERT INTO departments (dept_code, dept_title) VALUES (?, ?)");
                $stmt->bind_param("ss", $data['dept_code'], $data['dept_title']);
                $stmt->execute();
            }
            
            echo json_encode(['success' => true]);
            break;
            
        case 'DELETE':
            // Get department ID from URL parameter
            $id = $_GET['id'] ?? null;
            
            if (!$id) {
                throw new Exception("Department ID is required");
            }
            
            // Validate ID is numeric
            if (!is_numeric($id)) {
                throw new Exception("Invalid department ID format");
            }
            
            // First check if department exists
            $stmt = $conn->prepare("SELECT dept_index, dept_code, dept_title FROM departments WHERE dept_index = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $department = $result->fetch_assoc();
            
            if (!$department) {
                throw new Exception("Department not found");
            }
            
            // Check if department has programs
            $stmt = $conn->prepare("SELECT COUNT(*) as program_count FROM programs WHERE dept_index = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            
            if ($row['program_count'] > 0) {
                throw new Exception("Cannot delete department with associated programs. Please remove or reassign all programs first.");
            }
            
            // Check if department has sections
            $stmt = $conn->prepare("
                SELECT COUNT(*) as section_count 
                FROM sections s 
                JOIN programs p ON s.program_index = p.program_index 
                WHERE p.dept_index = ?
            ");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            
            if ($row['section_count'] > 0) {
                throw new Exception("Cannot delete department with associated sections. Please remove or reassign all sections first.");
            }
            
            // Delete the department
            $stmt = $conn->prepare("DELETE FROM departments WHERE dept_index = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            
            if ($stmt->affected_rows === 0) {
                throw new Exception("Failed to delete department");
            }
            
            echo json_encode([
                'success' => true,
                'message' => 'Department deleted successfully',
                'deleted_department' => $department
            ]);
            break;
            
        default:
            http_response_code(405);
            echo json_encode(['error' => 'Method not allowed']);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}

$conn->close();
?>