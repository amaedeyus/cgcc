<?php
header('Content-Type: application/json');
require_once '../connect.php';

$method = $_SERVER['REQUEST_METHOD'];
$programId = $_GET['program_id'] ?? null;

try {
    switch ($method) {
        case 'GET':
            // Fetch all sections for a program
            if (!$programId) {
                throw new Exception("Program ID is required");
            }
            
            $stmt = $conn->prepare("
                SELECT * FROM sections 
                WHERE program_index = ?
                ORDER BY year_level, section_name
            ");
            $stmt->bind_param("i", $programId);
            $stmt->execute();
            $result = $stmt->get_result();
            $sections = $result->fetch_all(MYSQLI_ASSOC);
            
            // Return as object with sections array for better structure
            echo json_encode([
                'success' => true,
                'sections' => $sections
            ]);
            break;
            
        case 'POST':
            // Add or update section
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['program_index'])) {
                throw new Exception("Program ID is required");
            }
            
            if (empty($data['year_level'])) {
                throw new Exception("Year level is required");
            }
            
            if (empty($data['section_name'])) {
                throw new Exception("Section name is required");
            }
            
            if (isset($data['section_index'])) {
                // Update existing section
                $stmt = $conn->prepare("
                    UPDATE sections 
                    SET section_name = ?, year_level = ?
                    WHERE section_index = ?
                ");
                $stmt->bind_param(
                    "sii", 
                    $data['section_name'], 
                    $data['year_level'],
                    $data['section_index']
                );
                $stmt->execute();
                
                if ($stmt->affected_rows === 0) {
                    throw new Exception("No section found with that ID");
                }
            } else {
                // Add new section
                $stmt = $conn->prepare("
                    INSERT INTO sections (program_index, year_level, section_name)
                    VALUES (?, ?, ?)
                ");
                $stmt->bind_param(
                    "iis", 
                    $data['program_index'], 
                    $data['year_level'], 
                    $data['section_name']
                );
                $stmt->execute();
            }
            
            echo json_encode(['success' => true]);
            break;
            
        case 'DELETE':
            // Delete section
            $id = $_GET['id'] ?? null;
            
            if (!$id) {
                throw new Exception("Section ID is required");
            }
            
            // Check if section has students
            $stmt = $conn->prepare("SELECT COUNT(*) as student_count FROM students WHERE section_index = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            
            if ($row['student_count'] > 0) {
                throw new Exception("Cannot delete section with assigned students");
            }
            
            $stmt = $conn->prepare("DELETE FROM sections WHERE section_index = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            
            if ($stmt->affected_rows === 0) {
                throw new Exception("No section found with that ID");
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