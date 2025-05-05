<?php
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
    $stmt = $pdo->prepare("INSERT INTO Responses (Form_ID, Student_ID) VALUES (?, ?)");
    $stmt->execute([$formId, $data['studentId'] ?? null]);
    $responseId = $pdo->lastInsertId();

    foreach ($data['answers'] as $answer) {
        $questionId = $answer['questionId'] ?? null;
        $choiceId = $answer['choiceId'] ?? null;
        $textAnswer = $answer['textAnswer'] ?? null;
        $gridAnswers = $answer['gridAnswers'] ?? [];

        if ($choiceId || $textAnswer) {
            $pdo->prepare("INSERT INTO Answers (Response_ID, Main_Question_ID, Choice_ID, Text_Answer) VALUES (?, ?, ?, ?)")
               ->execute([$responseId, $questionId, $choiceId, $textAnswer]);
        }

        if (!empty($gridAnswers)) {
            foreach ($gridAnswers as $gridAnswer) {
                $pdo->prepare("INSERT INTO Grid_Answer (Response_id, Main_Question_ID, Sub_Question_ID, Choice_ID) VALUES (?, ?, ?, ?)")
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