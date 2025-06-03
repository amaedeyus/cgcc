<?php
header('Content-Type: application/json');
require_once '../../connect.php';

$data = json_decode(file_get_contents('php://input'), true);
$counselorId = $_GET['id'] ?? null;

if (!$counselorId || empty($data['first_name']) || empty($data['last_name']) || empty($data['email']) || empty($data['status'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required fields']);
    exit;
}

try {
    $conn->begin_transaction();
    
    // First, check if status is being changed to inactive
    $checkStmt = $conn->prepare("SELECT status FROM counselors WHERE counselor_index = ?");
    $checkStmt->bind_param("i", $counselorId);
    $checkStmt->execute();
    $result = $checkStmt->get_result();
    $currentStatus = $result->fetch_assoc()['status'];
    $checkStmt->close();

    // Update counselor info
    $stmt = $conn->prepare("UPDATE counselors c
                           JOIN users u ON c.user_index = u.user_index
                           SET c.first_name = ?, c.last_name = ?, c.status = ?, u.email = ?
                           WHERE c.counselor_index = ?");
    $stmt->bind_param("ssssi", 
        $data['first_name'], 
        $data['last_name'], 
        $data['status'],
        $data['email'],
        $counselorId
    );
    $stmt->execute();
    
    if ($stmt->affected_rows === 0) {
        throw new Exception("No counselor found with that ID or no changes made");
    }
    $stmt->close();

    // If status is being changed to inactive, nullify program_index in programs table
    if ($currentStatus !== 'inactive' && $data['status'] === 'inactive') {
        $updateProgramsStmt = $conn->prepare("UPDATE programs SET counselor_index = NULL WHERE counselor_index = ?");
        $updateProgramsStmt->bind_param("i", $counselorId);
        $updateProgramsStmt->execute();
        $updateProgramsStmt->close();
    }
    
    $conn->commit();
    
    echo json_encode(['success' => true]);
    
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update counselor', 'message' => $e->getMessage()]);
}

$conn->close();
?>