<?php
session_start();

if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

$userType = $_SESSION['user_type'];

// Optional: Log user type
error_log("User type: " . $userType);

// Enable CORS and set headers
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

// CORS Handling - Development settings (adjust for production)
if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    
    exit(0);
}

// Error reporting for debugging (disable in production)
error_reporting(E_ALL);
ini_set('display_errors', 1);


require_once '../connect3.php';

// Database connection
try {
    // Adjust this path according to your actual file structure
    
    // Validate input
    $formId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
    
    if ($formId <= 0) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid form ID']);
        exit;
    }

    // Fetch form details
    $query = "SELECT form_index, form_name, description FROM forms WHERE form_index = ?";
    $stmt = $conn->prepare($query);
    if (!$stmt) {
        throw new Exception("Prepare failed: " . $conn->error);
    }
    
    $stmt->bind_param("i", $formId);
    if (!$stmt->execute()) {
        throw new Exception("Execute failed: " . $stmt->error);
    }
    
    $formResult = $stmt->get_result();
    if ($formResult->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['error' => 'Form not found']);
        exit;
    }

    $form = $formResult->fetch_assoc();
    $stmt->close();

    // Fetch sections
    // Fetch sections - corrected column name from section_behavior to behavior
    $query = "SELECT section_index, section_title, section_description, section_order, 
                    IFNULL(behavior, 'same-page') AS behavior 
            FROM form_sections 
            WHERE form_index = ? 
            ORDER BY section_order";
    $stmt = $conn->prepare($query);
    if (!$stmt) {
        throw new Exception("Prepare failed: " . $conn->error);
    }
    
    $stmt->bind_param("i", $formId);
    if (!$stmt->execute()) {
        throw new Exception("Execute failed: " . $stmt->error);
    }
    
    $sectionsResult = $stmt->get_result();
    $sections = [];
    $allQuestions = [];
    
    while ($section = $sectionsResult->fetch_assoc()) {
        // Fetch questions for this section
        $query = "SELECT mq.main_question_index, mq.main_question_text, mq.is_required,
                         qt.type_name, IFNULL(mq.include_other, 0) AS include_other
                  FROM main_questions mq
                  JOIN question_types qt ON mq.type_index = qt.type_index 
                  WHERE mq.section_index = ?
                  ORDER BY mq.main_question_index";
        $stmt2 = $conn->prepare($query);
        if (!$stmt2) {
            throw new Exception("Prepare failed: " . $conn->error);
        }
        
        $stmt2->bind_param("i", $section['section_index']);
        if (!$stmt2->execute()) {
            throw new Exception("Execute failed: " . $stmt2->error);
        }
        
        $questionsResult = $stmt2->get_result();
        $questions = [];

        while ($q = $questionsResult->fetch_assoc()) {
            // Get options
            $options = [];
            $stmt3 = $conn->prepare("SELECT choice_text FROM choices WHERE main_question_index = ? ORDER BY choice_index");
            if ($stmt3) {
                $stmt3->bind_param("i", $q['main_question_index']);
                $stmt3->execute();
                $choicesResult = $stmt3->get_result();
                while ($choice = $choicesResult->fetch_assoc()) {
                    $options[] = $choice['choice_text'];
                }
                $stmt3->close();
            }

            // Get sub-questions (rows)
            $rows = [];
            $stmt4 = $conn->prepare("SELECT sub_question_text FROM sub_questions WHERE main_question_index = ? ORDER BY sub_question_index");
            if ($stmt4) {
                $stmt4->bind_param("i", $q['main_question_index']);
                $stmt4->execute();
                $subQResult = $stmt4->get_result();
                while ($subQ = $subQResult->fetch_assoc()) {
                    $rows[] = $subQ['sub_question_text'];
                }
                $stmt4->close();
            }

            $questions[] = [
                'id' => (string)$q['main_question_index'],
                'question' => $q['main_question_text'],
                'type' => $q['type_name'],
                'required' => (bool)$q['is_required'],
                'includeOther' => (bool)$q['include_other'],
                'options' => $options,
                'rows' => $rows
            ];
        }
        $stmt2->close();

        $sections[] = [
            'id' => (string)$section['section_index'],
            'title' => $section['section_title'],
            'description' => $section['section_description'] ?? '',
            'order' => $section['section_order'],
            'behavior' => $section['behavior'],
            'questions' => $questions
        ];
        $allQuestions = array_merge($allQuestions, $questions);
    }
    $stmt->close();

    // If no sections found, create default section
    if (empty($sections)) {
        $sections[] = [
            'id' => '0',
            'title' => 'Default Section',
            'description' => '',
            'order' => 1,
            'behavior' => 'same-page',
            'questions' => $allQuestions
        ];
    }

    // Return the response
    echo json_encode([
        'form_index' => $form['form_index'],
        'form_name' => $form['form_name'],
        'description' => $form['description'],
        'sections' => $sections,
        'questions' => $allQuestions
    ], JSON_NUMERIC_CHECK);

} catch (Exception $e) {
    http_response_code(500);
    $errorResponse = [
        'error' => 'An error occurred',
        'message' => $e->getMessage(),
        'trace' => $e->getTraceAsString() // Only for debugging
    ];
    error_log(json_encode($errorResponse));
    echo json_encode(['error' => 'An error occurred while processing your request']);
}