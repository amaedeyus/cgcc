<?php
session_start();

// Check if user is logged in
if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

header("Access-Control-Allow-Methods: GET, POST, PATCH, OPTIONS");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

require '../connect3.php';

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header("Access-Control-Allow-Headers: Content-Type");
    exit;
}

// GET Request: Fetch forms or single form
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        if (isset($_GET['form_index'])) {
            // Fetch single form by ID
            $formIndex = intval($_GET['form_index']);
            $stmt = $conn->prepare("SELECT * FROM forms WHERE form_index = ?");
            if (!$stmt) {
                throw new Exception("Prepare failed: " . $conn->error);
            }

            $stmt->bind_param("i", $formIndex);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $form = $result->fetch_assoc();
                // Convert is_active to boolean
                $form['is_active'] = (bool)$form['is_active'];
                echo json_encode($form);
            } else {
                http_response_code(404);
                echo json_encode(['error' => 'Form not found']);
            }
            $stmt->close();
        } else {
            // Fetch all forms
            $query = "SELECT * FROM forms";
            $result = $conn->query($query);

            if ($result) {
                $forms = [];
                while ($row = $result->fetch_assoc()) {
                    // Convert is_active to boolean
                    $row['is_active'] = (bool)$row['is_active'];
                    $forms[] = $row;
                }
                echo json_encode($forms);
            } else {
                throw new Exception("Query failed: " . $conn->error);
            }
        }
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Server error', 'message' => $e->getMessage()]);
    }
    
    $conn->close();
    exit;
}

// POST Request: Update form status
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['form_id']) || !isset($data['is_active'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Missing required parameters']);
            exit;
        }

        $formId = intval($data['form_id']);
        $isActive = $data['is_active'] ? 1 : 0;

        $stmt = $conn->prepare("UPDATE forms SET is_active = ? WHERE form_index = ?");
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $conn->error);
        }

        $stmt->bind_param("ii", $isActive, $formId);
        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                echo json_encode(['success' => true, 'message' => 'Status updated successfully']);
            } else {
                echo json_encode(['success' => false, 'message' => 'No changes made']);
            }
        } else {
            throw new Exception('Execution failed: ' . $stmt->error);
        }
        $stmt->close();
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Server error', 'message' => $e->getMessage()]);
    }
    
    $conn->close();
    exit;
}

// If none of the methods match
http_response_code(405);
echo json_encode(['error' => 'Method Not Allowed']);
?>