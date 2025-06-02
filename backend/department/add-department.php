<?php
header('Content-Type: application/json');
require_once '../connect.php';

try {
    // Get POST data
    $data = json_decode(file_get_contents('php://input'), true);
    
    // Validate required fields
    if (empty($data['dept_code'])) {
        throw new Exception("Department code is required");
    }
    
    if (empty($data['dept_title'])) {
        throw new Exception("Department title is required");
    }
    
    // Sanitize inputs
    $dept_code = trim($data['dept_code']);
    $dept_title = trim($data['dept_title']);
    
    // Validate department code format (alphanumeric and underscore only)
    if (!preg_match('/^[A-Za-z0-9_]+$/', $dept_code)) {
        throw new Exception("Department code can only contain letters, numbers, and underscores");
    }
    
    // Check if department code already exists
    $stmt = $conn->prepare("SELECT COUNT(*) as count FROM departments WHERE dept_code = ?");
    $stmt->bind_param("s", $dept_code);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    
    if ($row['count'] > 0) {
        throw new Exception("Department code already exists");
    }
    
    // Insert new department
    $stmt = $conn->prepare("INSERT INTO departments (dept_code, dept_title) VALUES (?, ?)");
    $stmt->bind_param("ss", $dept_code, $dept_title);
    
    if ($stmt->execute()) {
        $new_dept_id = $conn->insert_id;
        echo json_encode([
            'success' => true,
            'message' => 'Department added successfully',
            'department' => [
                'dept_index' => $new_dept_id,
                'dept_code' => $dept_code,
                'dept_title' => $dept_title
            ]
        ]);
    } else {
        throw new Exception("Failed to add department");
    }
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}

$conn->close();
?> 