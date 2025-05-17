<?php
header("Access-Control-Allow-Origin: http://localhost:3001");
header("Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../connect.php';

$formId = $_GET['id'] ?? null;
$data = json_decode(file_get_contents('php://input'), true);

if (!$formId || !is_numeric($formId) || !$data || !isset($data['answers']) || !is_array($data['answers'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid request']);
    exit;
}

try {
    $pdo->beginTransaction();

    // Insert Response
    $stmt = $pdo->prepare("INSERT INTO responses (form_index, student_index) VALUES (?, ?)");
    $stmt->execute([$formId, $data['studentId'] ?? null]);
    $responseId = $pdo->lastInsertId();

    foreach ($data['answers'] as $answer) {
        $questionId = $answer['questionId'] ?? null;
        $choiceId = $answer['choiceId'] ?? null;
        $textAnswer = $answer['textAnswer'] ?? null;
        $gridAnswers = $answer['gridAnswers'] ?? [];

        if ($choiceId || $textAnswer) {
            $pdo->prepare("INSERT INTO answers (response_index, main_question_index, choice_index, Text_Answer) VALUES (?, ?, ?, ?)")
               ->execute([$responseId, $questionId, $choiceId, $textAnswer]);
        }

        if (!empty($gridAnswers)) {
            foreach ($gridAnswers as $gridAnswer) {
                $pdo->prepare("INSERT INTO grid_answers (response_index, main_question_index, sub_question_index, choice_index) VALUES (?, ?, ?, ?)")
                   ->execute([
                       $responseId,
                       $questionId,
                       $gridAnswer['subQuestionId'] ?? null,
                       $gridAnswer['choiceId'] ?? null
                   ]);
            }
        }
    }

    $pdo->commit();
    echo json_encode(['responseId' => $responseId, 'message' => 'Response submitted successfully']);
} catch (Exception $e) {
    $pdo->rollBack();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to submit response', 'message' => $e->getMessage()]);
}
?>