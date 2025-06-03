<?php
// Include database connection
require_once '../connect.php'; // Make sure this file sets up $conn (mysqli connection)

$formIndex = isset($_GET['form_index']) ? intval($_GET['form_index']) : 0;

if ($formIndex === 0) {
    http_response_code(400);
    echo json_encode(["error" => "Invalid or missing form_index"]);
    exit;
}

// Get form info
$formQuery = "
    SELECT * FROM forms
    WHERE form_index = ?
";
$formStmt = $conn->prepare($formQuery);
$formStmt->bind_param("i", $formIndex);
$formStmt->execute();
$formResult = $formStmt->get_result();
$formData = $formResult->fetch_assoc();

if (!$formData) {
    http_response_code(404);
    echo json_encode(["error" => "Form not found"]);
    exit;
}

// Get sections
$sectionsQuery = "
    SELECT * FROM form_sections
    WHERE form_index = ?
    ORDER BY section_order
";
$sectionsStmt = $conn->prepare($sectionsQuery);
$sectionsStmt->bind_param("i", $formIndex);
$sectionsStmt->execute();
$sectionsResult = $sectionsStmt->get_result();

$sections = [];

while ($section = $sectionsResult->fetch_assoc()) {
    $sectionId = $section['form_section_index'];

    // Get questions for this section
    $questionsQuery = "
        SELECT mq.*, qt.type_name
        FROM main_questions mq
        LEFT JOIN question_types qt ON mq.type_index = qt.type_index
        WHERE mq.form_section_index = ?
    ";
    $questionsStmt = $conn->prepare($questionsQuery);
    $questionsStmt->bind_param("i", $sectionId);
    $questionsStmt->execute();
    $questionsResult = $questionsStmt->get_result();

    $questions = [];

    while ($question = $questionsResult->fetch_assoc()) {
        $questionId = $question['main_question_index'];

        // Get sub-questions
        $subQuestionsQuery = "
            SELECT * FROM sub_questions
            WHERE main_question_index = ?
        ";
        $subStmt = $conn->prepare($subQuestionsQuery);
        $subStmt->bind_param("i", $questionId);
        $subStmt->execute();
        $subResult = $subStmt->get_result();
        $subQuestions = $subResult->fetch_all(MYSQLI_ASSOC);

        // Get choices
        $choicesQuery = "
            SELECT * FROM choices
            WHERE main_question_index = ?
        ";
        $choicesStmt = $conn->prepare($choicesQuery);
        $choicesStmt->bind_param("i", $questionId);
        $choicesStmt->execute();
        $choicesResult = $choicesStmt->get_result();
        $choices = $choicesResult->fetch_all(MYSQLI_ASSOC);

        $questions[] = [
            "question" => $question,
            "sub_questions" => $subQuestions,
            "choices" => $choices
        ];
    }

    $sections[] = [
        "section" => $section,
        "questions" => $questions
    ];
}

// Final structure
$response = [
    "form" => $formData,
    "sections" => $sections
];

// Output JSON
header("Content-Type: application/json");
echo json_encode($response, JSON_PRETTY_PRINT);

?>
