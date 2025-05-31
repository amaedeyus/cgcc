<?php
session_start();
require "../../connect.php";

if (!isset($_SESSION['counselor_index'])) {
    header("Location: login.php");
    exit;
}

$counselor_index = $_SESSION['counselor_index'];

// Handle different request methods
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch counselor info for display
    $stmt = $conn->prepare("
        SELECT c.*, u.email 
        FROM counselors c
        LEFT JOIN users u ON c.user_index = u.user_index
        WHERE c.counselor_index = ?
    ");
    $stmt->bind_param("i", $counselor_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $counselor = $result->fetch_assoc();

    // Fetch assigned programs
    $program_stmt = $conn->prepare("
        SELECT program_index, program_name 
        FROM programs 
        WHERE counselor_index = ?
    ");
    $program_stmt->bind_param("i", $counselor_index);
    $program_stmt->execute();
    $program_result = $program_stmt->get_result();
    $assigned_programs = $program_result->fetch_all(MYSQLI_ASSOC);

    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode([
        'success' => true,
        'counselor' => $counselor,
        'assigned_programs' => $assigned_programs
    ]);
    exit;
} 
elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Handle profile update
    $data = json_decode(file_get_contents('php://input'), true);
    
    $calendar_link = $data['calendar_link'] ?? '';
    $credentials = $data['credentials'] ?? '';
    $contact_number = $data['contact_number'] ?? '';
    
    // Handle base64 image upload if present
    $image_path = null;
    if (!empty($data['profile_image'])) {
        $upload_dir = '../../public/Media/uploads/counselors/';
        if (!file_exists($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }
        
        $image_data = $data['profile_image'];
        $image_parts = explode(";base64,", $image_data);
        $image_type = explode("image/", $image_parts[0])[1];
        $image_base64 = base64_decode($image_parts[1]);
        $new_filename = 'counselor_' . $counselor_index . '_' . time() . '.' . $image_type;
        $upload_path = $upload_dir . $new_filename;
        $web_path = '../../backend/public/Media/uploads/counselors/' . $new_filename;
        
        if (file_put_contents($upload_path, $image_base64)) {
            $image_path = $web_path; // Use web-accessible path instead of filesystem path
        }
    }
    
    // Update counselor info
    $update_sql = "UPDATE counselors SET calendar_link = ?, credentials = ?";
    $params = [$calendar_link, $credentials];
    $types = "ss";
    
    if ($image_path) {
        $update_sql .= ", image_path = ?";
        $params[] = $image_path;
        $types .= "s";
    }
    
    if ($contact_number) {
        $update_sql .= ", contact_number = ?";
        $params[] = $contact_number;
        $types .= "s";
    }
    
    $update_sql .= " WHERE counselor_index = ?";
    $params[] = $counselor_index;
    $types .= "i";
    
    $update_stmt = $conn->prepare($update_sql);
    $update_stmt->bind_param($types, ...$params);
    
    if ($update_stmt->execute()) {
        // Get updated counselor data
        $stmt = $conn->prepare("
            SELECT c.*, u.email 
            FROM counselors c
            LEFT JOIN users u ON c.user_index = u.user_index
            WHERE c.counselor_index = ?
        ");
        $stmt->bind_param("i", $counselor_index);
        $stmt->execute();
        $result = $stmt->get_result();
        $updated_counselor = $result->fetch_assoc();
        
        header('Content-Type: application/json');
        echo json_encode([
            'success' => true,
            'message' => 'Profile updated successfully',
            'counselor' => $updated_counselor
        ]);
    } else {
        header('Content-Type: application/json');
        echo json_encode([
            'success' => false,
            'message' => 'Error updating profile: ' . $conn->error
        ]);
    }
    exit;
}

// Invalid request method
header('Content-Type: application/json');
http_response_code(405);
echo json_encode([
    'success' => false,
    'message' => 'Method not allowed'
]);
?>