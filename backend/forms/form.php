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
                // Return raw enum values
                $form['is_active'] = $form['is_active'];
                $form['is_required'] = $form['is_required'];
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
                    // Return raw enum values
                    $row['is_active'] = $row['is_active'];
                    $row['is_required'] = $row['is_required'];
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

// POST Request: Update form status and required setting
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Get raw POST data
        $json = file_get_contents('php://input');
        $data = json_decode($json, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Invalid JSON data");
        }

        if (!isset($data['form_id'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Missing form_id parameter']);
            exit;
        }

        $formId = intval($data['form_id']);
        $isActive = $data['is_active'] ?? null;
        $isRequired = $data['is_required'] ?? null;
        $academicYear = $data['academic_year'] ?? null;

        // Validate parameters
        if ($isActive !== null && !in_array($isActive, ['0', '1', '-1'], true)) {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid is_active value. Must be one of: 0, 1, -1']);
            exit;
        }

        if ($isRequired !== null && !in_array($isRequired, ['0', '1'], true)) {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid is_required value. Must be one of: 0, 1']);
            exit;
        }

        if ($academicYear !== null && !preg_match('/^[0-9]{4}-[0-9]{4}$/', $academicYear)) {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid academic year format. Must be YYYY-YYYY']);
            exit;
        }

        // Build the update query based on provided parameters
        $updates = [];
        $params = [];
        $types = '';

        if ($isActive !== null) {
            $updates[] = "is_active = ?";
            $params[] = $isActive;
            $types .= 's';
        }

        if ($isRequired !== null) {
            $updates[] = "is_required = ?";
            $params[] = $isRequired;
            $types .= 's';
        }

        if ($academicYear !== null) {
            $updates[] = "academic_year = ?";
            $params[] = $academicYear;
            $types .= 's';
        }

        if (empty($updates)) {
            http_response_code(400);
            echo json_encode(['error' => 'No valid parameters provided for update']);
            exit;
        }

        $params[] = $formId;
        $types .= 'i';

        $query = "UPDATE forms SET " . implode(', ', $updates) . " WHERE form_index = ?";
        $stmt = $conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Prepare failed: " . $conn->error);
        }

        $stmt->bind_param($types, ...$params);
        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                echo json_encode([
                    'success' => true, 
                    'message' => 'Form updated successfully',
                    'updates' => [
                        'is_active' => $isActive,
                        'is_required' => $isRequired,
                        'academic_year' => $academicYear
                    ]
                ]);
            } else {
                // No rows affected - form might not exist or no change
                $checkStmt = $conn->prepare("SELECT form_index FROM forms WHERE form_index = ?");
                $checkStmt->bind_param("i", $formId);
                $checkStmt->execute();
                $checkStmt->store_result();
                
                if ($checkStmt->num_rows === 0) {
                    http_response_code(404);
                    echo json_encode(['error' => 'Form not found']);
                } else {
                    echo json_encode([
                        'success' => true, 
                        'message' => 'No changes made (values already set)',
                        'updates' => [
                            'is_active' => $isActive,
                            'is_required' => $isRequired,
                            'academic_year' => $academicYear
                        ]
                    ]);
                }
                $checkStmt->close();
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