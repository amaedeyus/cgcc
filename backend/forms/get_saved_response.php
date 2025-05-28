<?php
session_start();

// Include your database configuration
require_once '../../config/db.php'; // Adjust this path as needed

// Ensure the user is authenticated (example assumes student login)
if (!isset($_SESSION['user_index'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

$user_index = $_SESSION['user_index'];
$form_index = isset($_GET['formId']) ? intval($_GET['formId']) : null;

if (!$form_index) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid form ID']);
    exit;
}

try {
    $pdo = getPDO(); // Your function to get PDO connection

    // Get student index based on user
    $stmt = $pdo->prepare("SELECT student_index FROM students WHERE user_index = ?");
    $stmt->execute([$user_index]);
    $student = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$student) {
        http_response_code(404);
        echo json_encode(['error' => 'Student not found']);
        exit;
    }

    $student_index = $student['student_index'];

    // Get the latest saved response for this form and student
    $stmt = $pdo->prepare("
        SELECT response_index 
        FROM responses 
        WHERE form_index = ? AND student_index = ? 
        ORDER BY updated_at DESC LIMIT 1
    ");
    $stmt->execute([$form_index, $student_index]);
    $response = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$response) {
        // No saved response found
        echo json_encode(['formId' => $form_index]);
        exit;
    }

    $response_index = $response['response_index'];

    // Prepare final data object
    $savedData = ['formId' => $form_index];

    // Load main question types to detect include_other status
    $stmt = $pdo->prepare("
        SELECT main_question_index, include_other 
        FROM main_questions 
        WHERE form_index = ?
    ");
    $stmt->execute([$form_index]);
    $questionTypes = [];
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $questionTypes[$row['main_question_index']] = $row['include_other'];
    }

    // Load regular answers
    $stmt = $pdo->prepare("
        SELECT main_question_index, choice_index, text_answer, is_other 
        FROM answers 
        WHERE response_index = ?
    ");
    $stmt->execute([$response_index]);

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $questionId = $row['main_question_index'];
        $choice = $row['choice_index'];
        $text = $row['text_answer'];
        $isOtherFlag = $row['is_other'];

        if (!isset($savedData[$questionId])) {
            $savedData[$questionId] = [
                'type' => 'unknown',
                'value' => []
            ];
        }

        $includeOther = !empty($questionTypes[$questionId]);

        // Handle checkbox/radio/dropdown with "Other" option
        if ($isOtherFlag && $includeOther && $text !== null && $text !== '') {
            // Store Other value as a string
            $savedData[$questionId]['type'] = 'checkbox'; // or match actual type
            $savedData[$questionId]['is_other'] = true;
            $savedData[$questionId]['otherText'] = $text;
        } elseif ($choice !== null) {
            // Normal choice selected
            $savedData[$questionId]['type'] = 'checkbox';
            $savedData[$questionId]['value'][] = $choice;
        } elseif ($text !== null && $text !== '') {
            // Text input (non-grid)
            $savedData[$questionId]['type'] = 'text';
            $savedData[$questionId]['value'] = $text;
        }
    }

    // Load grid answers
    $stmt = $pdo->prepare("
        SELECT main_question_index, sub_question_index, choice_index 
        FROM grid_answers 
        WHERE response_index = ?
    ");
    $stmt->execute([$response_index]);

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $questionId = $row['main_question_index'];
        $subIndex = $row['sub_question_index'];
        $choice = $row['choice_index'];

        if (!isset($savedData[$questionId])) {
            $savedData[$questionId] = [
                'type' => 'grid',
                'value' => []
            ];
        }

        $savedData[$questionId]['value'][] = [
            'rowIndex' => $subIndex,
            'optionIndex' => $choice
        ];
    }

    echo json_encode($savedData);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}