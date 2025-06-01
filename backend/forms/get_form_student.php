<?php
session_start();

// Enable error reporting for debugging (should be disabled in production)
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
require_once '../connect.php';

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
    $statusCheck = $conn->prepare("SELECT form_index, form_name, description, is_active FROM forms WHERE form_index = ?");
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

    $form = $statusResult->fetch_assoc();
    $statusCheck->close();

    if ($form['is_active'] !== '1') {
        http_response_code(403);
        echo json_encode(['error' => 'This form is not currently available for responses']);
        exit;
    }

    // 2. Check if student has previous responses (but don't block access)
    $previousResponses = [];
    $submissionCheck = $conn->prepare("SELECT response_index, created_at FROM responses WHERE form_index = ? AND student_index = ? ORDER BY created_at DESC");
    if (!$submissionCheck) {
        throw new Exception("Prepare failed for submission check: " . $conn->error);
    }
    
    $submissionCheck->bind_param("ii", $formId, $_SESSION['user_index']);
    if (!$submissionCheck->execute()) {
        throw new Exception("Execute failed for submission check: " . $submissionCheck->error);
    }
    
    $submissionResult = $submissionCheck->get_result();
    
    while ($response = $submissionResult->fetch_assoc()) {
        $previousResponses[] = [
            'response_index' => $response['response_index'],
            'created_at' => $response['created_at']
        ];
    }
    $submissionCheck->close();

    // 3. Fetch sections and questions in a single optimized query
    $sectionQuery = "SELECT 
                    fs.form_section_index, fs.section_title, fs.section_description, fs.section_order, 
                    IFNULL(fs.behavior, 'same-page') AS behavior,
                    mq.main_question_index, mq.main_question_text, mq.is_required, mq.subtype,
                    qt.type_name
                    FROM form_sections fs
                    LEFT JOIN main_questions mq ON fs.form_section_index = mq.form_section_index
                    LEFT JOIN question_types qt ON mq.type_index = qt.type_index
                    WHERE fs.form_index = ?
                    ORDER BY fs.section_order, mq.main_question_index";
    
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
    $currentSectionId = null;
    
    while ($row = $sectionsResult->fetch_assoc()) {
        // If this is a new section, add it to the sections array
        if ($currentSectionId !== $row['form_section_index']) {
            if ($currentSectionId !== null) {
                // Add the completed section to the sections array
                $sections[] = [
                    'id' => (string)$currentSectionId,
                    'title' => $currentSection['title'],
                    'description' => $currentSection['description'] ?? '',
                    'order' => $currentSection['order'],
                    'behavior' => $currentSection['behavior'],
                    'questions' => $currentSection['questions']
                ];
            }
            
            // Start a new section
            $currentSectionId = $row['form_section_index'];
            $currentSection = [
                'id' => (string)$row['form_section_index'],
                'title' => $row['section_title'],
                'description' => $row['section_description'] ?? '',
                'order' => $row['section_order'],
                'behavior' => $row['behavior'],
                'questions' => []
            ];
        }
        
        // Add question to current section if it exists
        if ($row['main_question_index'] !== null) {
            // Get options for this question
            $options = [];
            $optionStmt = $conn->prepare("SELECT choice_index, choice_text FROM choices WHERE main_question_index = ? ORDER BY choice_index");
            if ($optionStmt) {
                $optionStmt->bind_param("i", $row['main_question_index']);
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

            // Get sub-questions (rows) for this question
            $rows = [];
            $rowStmt = $conn->prepare("SELECT sub_question_index, sub_question_text FROM sub_questions WHERE main_question_index = ? ORDER BY sub_question_index");
            if ($rowStmt) {
                $rowStmt->bind_param("i", $row['main_question_index']);
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

            $question = [
                'id' => (string)$row['main_question_index'],
                'question' => $row['main_question_text'],
                'type' => $row['type_name'],
                'required' => (bool)$row['is_required'],
                'subtype' => $row['subtype'] ?? null,
                'options' => $options,
                'rows' => $rows
            ];
            
            $currentSection['questions'][] = $question;
            $allQuestions[] = $question;
        }
    }
    
    // Add the last section if it exists
    if ($currentSectionId !== null) {
        $sections[] = [
            'id' => (string)$currentSectionId,
            'title' => $currentSection['title'],
            'description' => $currentSection['description'] ?? '',
            'order' => $currentSection['order'],
            'behavior' => $currentSection['behavior'],
            'questions' => $currentSection['questions']
        ];
    }
    $sectionStmt->close();

    // If no sections found, create default section with all questions
    if (empty($sections)) {
        // Get all questions for the form (without sections)
        $questionQuery = "SELECT 
                        mq.main_question_index, mq.main_question_text, mq.is_required, mq.subtype,
                        qt.type_name
                        FROM main_questions mq
                        JOIN question_types qt ON mq.type_index = qt.type_index
                        WHERE mq.form_index = ?
                        ORDER BY mq.main_question_index";
        
        $questionStmt = $conn->prepare($questionQuery);
        if (!$questionStmt) {
            throw new Exception("Prepare failed for questions: " . $conn->error);
        }
        
        $questionStmt->bind_param("i", $formId);
        if (!$questionStmt->execute()) {
            throw new Exception("Execute failed for questions: " . $questionStmt->error);
        }
        
        $questionsResult = $questionStmt->get_result();
        $allQuestions = [];
        
        while ($row = $questionsResult->fetch_assoc()) {
            // Get options for this question
            $options = [];
            $optionStmt = $conn->prepare("SELECT choice_index, choice_text FROM choices WHERE main_question_index = ? ORDER BY choice_index");
            if ($optionStmt) {
                $optionStmt->bind_param("i", $row['main_question_index']);
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

            // Get sub-questions (rows) for this question
            $rows = [];
            $rowStmt = $conn->prepare("SELECT sub_question_index, sub_question_text FROM sub_questions WHERE main_question_index = ? ORDER BY sub_question_index");
            if ($rowStmt) {
                $rowStmt->bind_param("i", $row['main_question_index']);
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

            $allQuestions[] = [
                'id' => (string)$row['main_question_index'],
                'question' => $row['main_question_text'],
                'type' => $row['type_name'],
                'required' => (bool)$row['is_required'],
                'subtype' => $row['subtype'] ?? null,
                'options' => $options,
                'rows' => $rows
            ];
        }
        $questionStmt->close();

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
        'student_index' => $_SESSION['user_index'],
        'previous_responses' => $previousResponses,
        'can_submit_again' => true
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