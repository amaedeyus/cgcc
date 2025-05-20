<?php

session_start();

if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

$userType = $_SESSION['user_type'];

if ($userType !== 'admin' && $userType !== 'staff') {
    http_response_code(403);
    echo json_encode(['error' => 'Access denied']);
    exit;
}

// Optional: Log user type
error_log("User type: " . $userType);

header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Origin: http://localhost:3001");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

// Include your database connection
require '../connect3.php'; // Make sure the path is correct

// Try to fetch the forms
$query = "SELECT * FROM forms";
$result = $conn->query($query);

if ($result) {
    $forms = [];
    
    // Fetch all results and store in the $forms array
    while ($row = $result->fetch_assoc()) {
        $forms[] = $row;
    }

    // Return the forms as JSON
    echo json_encode($forms);
} else {
    // Return 500 error if the query fails
    http_response_code(500);
    echo json_encode(['error' => 'Failed to retrieve forms', 'message' => $conn->error]);
}

// Close the connection
$conn->close();
?>
