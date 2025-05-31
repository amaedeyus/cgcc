<?php
header('Content-Type: application/json');
require_once '../../connect.php';

$data = json_decode(file_get_contents('php://input'), true);

// Validate input
if (empty($data['first_name']) || empty($data['last_name']) || empty($data['email']) || empty($data['status'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required fields']);
    exit;
}

try {
    $conn->begin_transaction();
    
    // Set default password and hash it
    $defaultPassword = 'counselorPass';
    $hashedPassword = password_hash($defaultPassword, PASSWORD_DEFAULT);
    
    // First, check if email already exists in users table
    $checkStmt = $conn->prepare("SELECT user_index FROM users WHERE email = ?");
    $checkStmt->bind_param("s", $data['email']);
    $checkStmt->execute();
    $checkStmt->store_result();
    
    if ($checkStmt->num_rows > 0) {
        throw new Exception("Email already exists in the system");
    }
    $checkStmt->close();
    
    // Insert into users table
    $stmt = $conn->prepare("INSERT INTO users (email, password, type, created_at) VALUES (?, ?, 'counselor', NOW())");
    $stmt->bind_param("ss", $data['email'], $hashedPassword);
    $stmt->execute();
    $userId = $stmt->insert_id;
    $stmt->close();
    
    // Generate counselor number
    $counselorNumber = 'CG' . str_pad($userId, 4, '0', STR_PAD_LEFT);
    
    // Insert into counselors table
    $stmt = $conn->prepare("INSERT INTO counselors (user_index, counselor_number, first_name, last_name, status) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("issss", $userId, $counselorNumber, $data['first_name'], $data['last_name'], $data['status']);
    $stmt->execute();
    $counselorId = $stmt->insert_id;
    $stmt->close();
    
    $conn->commit();
    
    echo json_encode([
        'success' => true, 
        'counselor_index' => $counselorId,
        'message' => 'Counselor added successfully with default password'
    ]);
    
} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to add counselor', 'message' => $e->getMessage()]);
}

$conn->close();
?>