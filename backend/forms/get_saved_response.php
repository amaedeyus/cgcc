<?php
session_start();

// Include your database configuration
require_once '../connect3.php'; // This gives us $conn from connect3.php

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
    // Get student index based on user
    $stmt = $conn->prepare("SELECT student_index FROM students WHERE user_index = ?");
    $stmt->bind_param("i", $user_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $student = $result->fetch_assoc();

    if (!$student) {
        http_response_code(404);
        echo json_encode(['error' => 'Student not found']);
        exit;
    }

    $student_index = $student['student_index'];

    // Get the latest saved response for this form and student
    $stmt = $conn->prepare("
        SELECT response_index 
        FROM responses 
        WHERE form_index = ? AND student_index = ? 
        ORDER BY updated_at DESC LIMIT 1
    ");
    $stmt->bind_param("ii", $form_index, $student_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $response = $result->fetch_assoc();

    if (!$response) {
        // No saved response found
        echo json_encode(['formId' => $form_index]);
        exit;
    }

    $response_index = $response['response_index'];

    // Prepare final data object
    $savedData = ['formId' => $form_index];

    // Load main question types
    $stmt = $conn->prepare("
        SELECT main_question_index
        FROM main_questions 
        WHERE form_index = ?
    ");
    $stmt->bind_param("i", $form_index);
    $stmt->execute();
    $result = $stmt->get_result();

    $questionTypes = [];
    while ($row = $result->fetch_assoc()) {
        $questionTypes[$row['main_question_index']] = true;
    }

    // Load regular answers
    $stmt = $conn->prepare("
        SELECT main_question_index, choice_index, text_answer 
        FROM answers 
        WHERE response_index = ?
    ");
    $stmt->bind_param("i", $response_index);
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        $questionId = $row['main_question_index'];
        $choice = $row['choice_index'];
        $text = $row['text_answer'];

        if (!isset($savedData[$questionId])) {
            $savedData[$questionId] = [
                'type' => 'unknown',
                'value' => []
            ];
        }

        // Convert choice_index to string
        $stringValue = $choice !== null ? (string)$choice : null;

        if ($stringValue !== null) {
            // Normal choice selected (as string)
            $savedData[$questionId]['type'] = 'checkbox';
            $savedData[$questionId]['value'][] = $stringValue;
        } elseif ($text !== null && $text !== '') {
            // Text input (non-grid)
            $savedData[$questionId]['type'] = 'text';
            $savedData[$questionId]['value'] = $text;
        }
    }

    // Load grid answers
    $stmt = $conn->prepare("
        SELECT main_question_index, sub_question_index, choice_index 
        FROM grid_answers 
        WHERE response_index = ?
    ");
    $stmt->bind_param("i", $response_index);
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        $questionId = $row['main_question_index'];
        $subIndex = (string)$row['sub_question_index']; // cast to string
        $choice = (string)$row['choice_index']; // cast to string

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

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}