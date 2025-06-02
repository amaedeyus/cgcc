<?php
session_start();
require "../../connect.php";

if (!isset($_SESSION['counselor_index'])) {
    header("Location: login.php");
    exit;
}

$counselor_index = $_SESSION['counselor_index'];

// Function to format name to formal case
function toFormalCase($name) {
    if (empty($name)) return '';
    return ucwords(strtolower($name));
}

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

    // Format names to formal case
    $counselor['first_name'] = toFormalCase($counselor['first_name']);
    $counselor['last_name'] = toFormalCase($counselor['last_name']);
    $counselor['guardian_name'] = toFormalCase($counselor['guardian_name']);

    // Set default email if not available
    if (empty($counselor['email'])) {
        $counselor['email'] = strtolower($counselor['first_name'] . '_' . $counselor['last_name'] . '@dlsl.edu.ph');
    }

    // Set default guardian name if not available
    if (empty($counselor['guardian_name'])) {
        $counselor['guardian_name'] = 'Jane ' . $counselor['last_name'];
    }

    // Set default contact number if not available
    if (empty($counselor['contact_number'])) {
        $counselor['contact_number'] = '09953011635';
    }

    // Fetch assigned program (only one program per counselor)
    $program_stmt = $conn->prepare("
        SELECT program_index, program_code, program_name 
        FROM programs 
        WHERE counselor_index = ?
        LIMIT 1
    ");
    $program_stmt->bind_param("i", $counselor_index);
    $program_stmt->execute();
    $program_result = $program_stmt->get_result();
    $assigned_program = $program_result->fetch_assoc();

    // Format program name to formal case
    if ($assigned_program) {
        $assigned_program['program_name'] = toFormalCase($assigned_program['program_name']);
    }

    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode([
        'success' => true,
        'counselor' => $counselor,
        'assigned_program' => $assigned_program
    ]);
    exit;
} 
elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Handle profile update
    $data = json_decode(file_get_contents('php://input'), true);
    
    $calendar_link = $data['calendar_link'] ?? '';
    $credentials = $data['credentials'] ?? '';
    $contact_number = $data['contact_number'] ?? '09953011635'; // Default contact number
    
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
            $image_path = $web_path;
        }
    }
    
    // Update counselor info
    $update_sql = "UPDATE counselors SET calendar_link = ?, credentials = ?, contact_number = ?";
    $params = [$calendar_link, $credentials, $contact_number];
    $types = "sss";
    
    if ($image_path) {
        $update_sql .= ", image_path = ?";
        $params[] = $image_path;
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

        // Format names to formal case
        $updated_counselor['first_name'] = toFormalCase($updated_counselor['first_name']);
        $updated_counselor['last_name'] = toFormalCase($updated_counselor['last_name']);
        $updated_counselor['guardian_name'] = toFormalCase($updated_counselor['guardian_name']);

        // Set default values for the updated counselor data
        if (empty($updated_counselor['email'])) {
            $updated_counselor['email'] = strtolower($updated_counselor['first_name'] . '_' . $updated_counselor['last_name'] . '@dlsl.edu.ph');
        }
        if (empty($updated_counselor['guardian_name'])) {
            $updated_counselor['guardian_name'] = 'Jane ' . $updated_counselor['last_name'];
        }
        if (empty($updated_counselor['contact_number'])) {
            $updated_counselor['contact_number'] = '09953011635';
        }
        
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