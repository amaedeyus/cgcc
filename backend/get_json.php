<?php
// Set JSON header
header('Content-Type: application/json');

// DB connection
$host = 'localhost';
$db = 'form_new';
$user = 'root';
$pass = '';

// Get form_index from GET request
if (!isset($_GET['form_index']) || !is_numeric($_GET['form_index'])) {
    echo json_encode(['error' => 'Missing or invalid form_index']);
    exit;
}

$formIndex = intval($_GET['form_index']);

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Fetch the specified form
    $stmt = $pdo->prepare("SELECT * FROM forms WHERE form_index = ?");
    $stmt->execute([$formIndex]);
    $form = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$form) {
        echo json_encode(['error' => 'Form not found']);
        exit;
    }

    // Get sections
    $sectionStmt = $pdo->prepare("SELECT * FROM form_sections WHERE form_index = ? ORDER BY section_order ASC");
    $sectionStmt->execute([$formIndex]);
    $sections = $sectionStmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($sections as &$section) {
        $sectionIndex = $section['form_section_index'];

        // Get questions for section
        $questionStmt = $pdo->prepare("
            SELECT q.*, t.type_name 
            FROM main_questions q
            JOIN question_types t ON q.type_index = t.type_index
            WHERE q.form_section_index = ?
        ");
        $questionStmt->execute([$sectionIndex]);
        $questions = $questionStmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($questions as &$question) {
            $mainQuestionIndex = $question['main_question_index'];

            // Get choices
            $choiceStmt = $pdo->prepare("SELECT * FROM choices WHERE main_question_index = ?");
            $choiceStmt->execute([$mainQuestionIndex]);
            $question['choices'] = $choiceStmt->fetchAll(PDO::FETCH_ASSOC);

            // Get subquestions (if applicable)
            $subQStmt = $pdo->prepare("SELECT * FROM sub_questions WHERE main_question_index = ?");
            $subQStmt->execute([$mainQuestionIndex]);
            $question['sub_questions'] = $subQStmt->fetchAll(PDO::FETCH_ASSOC);
        }

        $section['questions'] = $questions;
    }

    $form['sections'] = $sections;

    echo json_encode(['form' => $form], JSON_PRETTY_PRINT);

} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
