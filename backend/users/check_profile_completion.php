<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Only prevent direct browser access, allow AJAX requests
if (!isset($_SERVER['HTTP_X_REQUESTED_WITH']) || strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) !== 'xmlhttprequest') {
    if (basename($_SERVER['PHP_SELF']) === basename(__FILE__)) {
        header('HTTP/1.0 403 Forbidden');
        exit('Direct access to this file is forbidden.');
    }
}

require_once __DIR__ . "/../connect.php";

function checkProfileCompletion($conn, $student_index) {
    // Check if student has completed required profile fields
    $stmt = $conn->prepare("
        SELECT 
            s.contact_number,
            s.year_level,
            s.section_index,
            s.guardian_index,
            g.full_name as guardian_name,
            g.contact_number as guardian_contact
        FROM students s
        LEFT JOIN guardians g ON s.guardian_index = g.guardian_index
        WHERE s.student_index = ?
    ");
    
    $stmt->bind_param("i", $student_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $student = $result->fetch_assoc();
    
    // Check if all required fields are filled
    $isComplete = !empty($student['contact_number']) &&
                 !empty($student['year_level']) &&
                 !empty($student['section_index']) &&
                 !empty($student['guardian_index']) &&
                 !empty($student['guardian_name']) &&
                 !empty($student['guardian_contact']);
    
    return [
        'is_complete' => $isComplete,
        'missing_fields' => [
            'contact_number' => empty($student['contact_number']),
            'year_level' => empty($student['year_level']),
            'section_index' => empty($student['section_index']),
            'guardian_index' => empty($student['guardian_index']),
            'guardian_name' => empty($student['guardian_name']),
            'guardian_contact' => empty($student['guardian_contact'])
        ]
    ];
}

// Handle AJAX requests
if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
    if (!isset($_SESSION['student_index'])) {
        echo json_encode(['error' => 'Not logged in']);
        exit;
    }
    
    $result = checkProfileCompletion($conn, $_SESSION['student_index']);
    echo json_encode($result);
    exit;
}
?> 