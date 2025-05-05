<?php
require_once '../connect.php';

$formId = $_GET['id'] ?? null;

if (!$formId || !is_numeric($formId)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid form ID']);
    exit;
}

try {
    // Get form
    $stmt = $pdo->prepare("SELECT * FROM Forms WHERE Form_ID = ?");
    $stmt->execute([$formId]);
    $form = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$form) {
        http_response_code(404);
        echo json_encode(['error' => 'Form not found']);
        exit;
    }

    // Get questions
    $stmt = $pdo->prepare("SELECT mq.*, qt.Question_Type FROM Main_Questions mq JOIN Question_Type qt ON mq.QType_ID = qt.QType_ID WHERE mq.Form_ID = ?");
    $stmt->execute([$formId]);
    $questions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($questions as &$q) {
        // Get options
        $stmt = $pdo->prepare("SELECT * FROM Choices WHERE Main_Question_ID = ?");
        $stmt->execute([$q['Main_Question_ID']]);
        $q['options'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Get sub-questions (rows)
        $stmt = $pdo->prepare("SELECT Sub_Question FROM Sub_Question WHERE Main_Question_ID = ?");
        $stmt->execute([$q['Main_Question_ID']]);
        $q['rows'] = array_column($stmt->fetchAll(PDO::FETCH_ASSOC), 'Sub_Question');
    }

    echo json_encode([
        'Form_ID' => $form['Form_ID'],
        'Form_Name' => $form['Form_Name'],
        'Description' => $form['Description'],
        'questions' => $questions
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch form', 'message' => $e->getMessage()]);
}
?>