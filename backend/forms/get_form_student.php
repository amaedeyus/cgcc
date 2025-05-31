<?php
session_start();

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Check if student is logged in
if (!isset($_SESSION['user_index']) || $_SESSION['user_type'] !== 'student') {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized - Please log in as a student']);
    exit;
}

// Enable CORS and set headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// CORS preflight handling
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Database connection
require_once '../connect3.php';

// Check database connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed: ' . $conn->connect_error]);
    exit;
}

try {
    // Validate input
    $formId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
    
    if ($formId <= 0) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid form ID']);
        exit;
    }

    // 1. Check if form exists and is active
    $statusCheck = $conn->prepare("SELECT is_active FROM forms WHERE form_index = ?");
    if (!$statusCheck) {
        throw new Exception("Prepare failed for form check: " . $conn->error);
    }
    
    $statusCheck->bind_param("i", $formId);
    if (!$statusCheck->execute()) {
        throw new Exception("Execute failed for form check: " . $statusCheck->error);
    }
    
    $statusResult = $statusCheck->get_result();
    if ($statusResult->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['error' => 'Form not found']);
        exit;
    }

    $status = $statusResult->fetch_assoc();
    $statusCheck->close();

    if ($status['is_active'] !== '1') {
        http_response_code(403);
        echo json_encode(['error' => 'This form is not currently available for responses']);
        exit;
    }

    // 2. Check if student has already submitted this form
    $submissionCheck = $conn->prepare("SELECT response_index FROM responses WHERE form_index = ? AND student_index = ?");
    if (!$submissionCheck) {
        throw new Exception("Prepare failed for submission check: " . $conn->error);
    }
    
    $submissionCheck->bind_param("ii", $formId, $_SESSION['user_index']);
    if (!$submissionCheck->execute()) {
        throw new Exception("Execute failed for submission check: " . $submissionCheck->error);
    }
    
    $submissionResult = $submissionCheck->get_result();
    
    if ($submissionResult->num_rows > 0) {
        http_response_code(403);
        echo json_encode(['error' => 'You have already submitted this form']);
        exit;
    }
    $submissionCheck->close();

    // 3. Fetch form details
    $formQuery = "SELECT form_index, form_name, description FROM forms WHERE form_index = ?";
    $formStmt = $conn->prepare($formQuery);
    if (!$formStmt) {
        throw new Exception("Prepare failed for form details: " . $conn->error);
    }
    
    $formStmt->bind_param("i", $formId);
    if (!$formStmt->execute()) {
        throw new Exception("Execute failed for form details: " . $formStmt->error);
    }
    
    $formResult = $formStmt->get_result();
    $form = $formResult->fetch_assoc();
    $formStmt->close();

    // 4. Fetch sections
    $sectionQuery = "SELECT form_section_index, section_title, section_description, section_order, 
                    IFNULL(behavior, 'same-page') AS behavior 
                    FROM form_sections 
                    WHERE form_index = ? 
                    ORDER BY section_order";
    $sectionStmt = $conn->prepare($sectionQuery);
    if (!$sectionStmt) {
        throw new Exception("Prepare failed for sections: " . $conn->error);
    }
    
    $sectionStmt->bind_param("i", $formId);
    if (!$sectionStmt->execute()) {
        throw new Exception("Execute failed for sections: " . $sectionStmt->error);
    }
    
    $sectionsResult = $sectionStmt->get_result();
    $sections = [];
    $allQuestions = [];
    
    while ($section = $sectionsResult->fetch_assoc()) {
        // Fetch questions for this section
        $questionQuery = "SELECT mq.main_question_index, mq.main_question_text, mq.is_required,
                        qt.type_name, mq.subtype
                        FROM main_questions mq
                        JOIN question_types qt ON mq.type_index = qt.type_index 
                        WHERE mq.form_section_index = ?
                        ORDER BY mq.main_question_index";
        $questionStmt = $conn->prepare($questionQuery);
        if (!$questionStmt) {
            throw new Exception("Prepare failed for questions: " . $conn->error);
        }
        
        $questionStmt->bind_param("i", $section['form_section_index']);
        if (!$questionStmt->execute()) {
            throw new Exception("Execute failed for questions: " . $questionStmt->error);
        }
        
        $questionsResult = $questionStmt->get_result();
        $questions = [];

        while ($q = $questionsResult->fetch_assoc()) {
            // Get options
            $options = [];
            $optionStmt = $conn->prepare("SELECT choice_index, choice_text FROM choices WHERE main_question_index = ? ORDER BY choice_index");
            if ($optionStmt) {
                $optionStmt->bind_param("i", $q['main_question_index']);
                if (!$optionStmt->execute()) {
                    throw new Exception("Execute failed for options: " . $optionStmt->error);
                }
                $choicesResult = $optionStmt->get_result();
                while ($choice = $choicesResult->fetch_assoc()) {
                    $options[] = [
                        'choice_index' => $choice['choice_index'],
                        'choice_text' => $choice['choice_text']
                    ];
                }
                $optionStmt->close();
            }

            // Get sub-questions (rows)
            $rows = [];
            $rowStmt = $conn->prepare("SELECT sub_question_index, sub_question_text FROM sub_questions WHERE main_question_index = ? ORDER BY sub_question_index");
            if ($rowStmt) {
                $rowStmt->bind_param("i", $q['main_question_index']);
                if (!$rowStmt->execute()) {
                    throw new Exception("Execute failed for sub-questions: " . $rowStmt->error);
                }
                $subQResult = $rowStmt->get_result();
                while ($subQ = $subQResult->fetch_assoc()) {
                    $rows[] = [
                        'sub_question_index' => $subQ['sub_question_index'],
                        'sub_question_text' => $subQ['sub_question_text']
                    ];
                }
                $rowStmt->close();
            }

            $questions[] = [
                'id' => (string)$q['main_question_index'],
                'question' => $q['main_question_text'],
                'type' => $q['type_name'],
                'required' => (bool)$q['is_required'],
                'subtype' => $q['subtype'] ?? null,
                'options' => $options,
                'rows' => $rows
            ];
        }
        $questionStmt->close();

        $sections[] = [
            'id' => (string)$section['form_section_index'],
            'title' => $section['section_title'],
            'description' => $section['section_description'] ?? '',
            'order' => $section['section_order'],
            'behavior' => $section['behavior'],
            'questions' => $questions
        ];
        $allQuestions = array_merge($allQuestions, $questions);
    }
    $sectionStmt->close();

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
        'questions' => $allQuestions,
        'student_index' => $_SESSION['user_index']
    ], JSON_NUMERIC_CHECK);

} catch (Exception $e) {
    http_response_code(500);
    error_log("Error in get_form_student.php: " . $e->getMessage());
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
} finally {
    if (isset($conn)) {
        $conn->close();
    }
}