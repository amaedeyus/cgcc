<?php
header('Content-Type: application/json');
require_once '../../connect.php';

$counselorId = $_GET['id'] ?? null;

if (!$counselorId) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing counselor ID']);
    exit;
}

try {
    // Verify the counselor exists and is not already deleted
    $checkStmt = $conn->prepare("SELECT counselor_index FROM counselors WHERE counselor_index = ? AND status != 'deleted'");
    $checkStmt->bind_param("i", $counselorId);
    $checkStmt->execute();
    $checkStmt->store_result();
    
    if ($checkStmt->num_rows === 0) {
        throw new Exception("No active counselor found with that ID");
    }
    $checkStmt->close();

    // Start transaction
    $conn->begin_transaction();

    // Soft delete by updating status
    $stmt = $conn->prepare("UPDATE counselors SET status = 'deleted' WHERE counselor_index = ?");
    $stmt->bind_param("i", $counselorId);
    $stmt->execute();
    
    if ($stmt->affected_rows === 0) {
        throw new Exception("Failed to mark counselor as deleted");
    }
    $stmt->close();

    // Update programs to remove counselor reference
    $stmt = $conn->prepare("UPDATE programs SET counselor_index = NULL WHERE counselor_index = ?");
    $stmt->bind_param("i", $counselorId);
    $stmt->execute();
    $stmt->close();

    $conn->commit();
    
    echo json_encode(['success' => true, 'message' => 'Counselor marked as deleted and program assignments cleared']);
    
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to delete counselor', 'message' => $e->getMessage()]);
}

$conn->close();
?>