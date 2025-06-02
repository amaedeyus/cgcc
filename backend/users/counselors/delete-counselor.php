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
    // Verify the counselor exists and get their user_index
    $checkStmt = $conn->prepare("SELECT counselor_index, user_index FROM counselors WHERE counselor_index = ?");
    $checkStmt->bind_param("i", $counselorId);
    $checkStmt->execute();
    $result = $checkStmt->get_result();
    
    if ($result->num_rows === 0) {
        throw new Exception("No counselor found with that ID");
    }
    
    $counselor = $result->fetch_assoc();
    $userId = $counselor['user_index'];
    $checkStmt->close();

    // Start transaction
    $conn->begin_transaction();

    // Update programs to remove counselor reference
    $stmt = $conn->prepare("UPDATE programs SET counselor_index = NULL WHERE counselor_index = ?");
    $stmt->bind_param("i", $counselorId);
    $stmt->execute();
    $stmt->close();

    // Delete the counselor
    $stmt = $conn->prepare("DELETE FROM counselors WHERE counselor_index = ?");
    $stmt->bind_param("i", $counselorId);
    $stmt->execute();
    
    if ($stmt->affected_rows === 0) {
        throw new Exception("Failed to delete counselor");
    }
    $stmt->close();

    // Delete the user
    $stmt = $conn->prepare("DELETE FROM users WHERE user_index = ?");
    $stmt->bind_param("i", $userId);
    $stmt->execute();
    
    if ($stmt->affected_rows === 0) {
        throw new Exception("Failed to delete user account");
    }
    $stmt->close();

    $conn->commit();
    
    echo json_encode(['success' => true, 'message' => 'Counselor and user account deleted successfully']);
    
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to delete counselor', 'message' => $e->getMessage()]);
}

$conn->close();
?>