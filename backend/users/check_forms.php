<?php
header('Content-Type: application/json');

// Include your existing connection file
require_once '../connect.php';

try {
    // Get student ID from session or request
    $student_id = $_GET['student_id'] ?? null;
    
    if (!$student_id) {
        throw new Exception("Student ID not provided");
    }

    // Get all required and active forms
    $query = "
        SELECT f.form_index, f.form_name, f.description 
        FROM forms f
        WHERE f.is_active = '1' AND f.is_required = 1
    ";
    $formsResult = $conn->query($query);
    
    if (!$formsResult) {
        throw new Exception("Database query error: " . $conn->error);
    }

    $requiredForms = [];
    while ($row = $formsResult->fetch_assoc()) {
        $requiredForms[] = $row;
    }

    // Check which forms the student has completed
    $completedForms = [];
    foreach ($requiredForms as $form) {
        $stmt = $conn->prepare("
            SELECT COUNT(*) as count 
            FROM responses 
            WHERE form_index = ? 
            AND student_index = ?
            AND is_autosave = 0
        ");
        
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $conn->error);
        }
        
        $stmt->bind_param("ii", $form['form_index'], $student_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        
        if ($row['count'] > 0) {
            $completedForms[] = $form['form_index'];
        }
        
        $stmt->close();
    }

    // Prepare response
    $response = [
        'required_forms' => $requiredForms,
        'completed_forms' => $completedForms,
        'status' => 'success'
    ];

    echo json_encode($response);

} catch(Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
} finally {
    // Close connection if it exists
    if (isset($conn)) {
        $conn->close();
    }
}
?>