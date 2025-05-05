<?php
require_once '../connect.php';

parse_str(file_get_contents('php://input'), $_PUT);
$formId = $_PUT['id'] ?? null;

$data = json_decode(file_get_contents('php://input'), true);
if (!$data || empty($data['title']) || !isset($data['questions']) || !is_array($data['questions'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid or missing data']);
    exit;
}

try {
    $pdo->beginTransaction();

    // Check if form exists
    $stmt = $pdo->prepare("SELECT * FROM Forms WHERE Form_ID = ?");
    $stmt->execute([$formId]);
    if ($stmt->rowCount() === 0) {
        throw new Exception("Form not found");
    }

    // Update form metadata
    $stmt = $pdo->prepare("UPDATE Forms SET Form_Name = ?, Description = ? WHERE Form_ID = ?");
    $stmt->execute([$data['title'], $data['description'] ?? null, $formId]);

    // Delete old structure
    $stmt = $pdo->prepare("DELETE FROM Sub_Question WHERE Main_Question_ID IN (SELECT Main_Question_ID FROM Main_Questions WHERE Form_ID = ?)");
    $stmt->execute([$formId]);
    $stmt = $pdo->prepare("DELETE FROM Choices WHERE Main_Question_ID IN (SELECT Main_Question_ID FROM Main_Questions WHERE Form_ID = ?)");
    $stmt->execute([$formId]);
    $stmt = $pdo->prepare("DELETE FROM Main_Questions WHERE Form_ID = ?");
    $stmt->execute([$formId]);

    // Re-insert all questions
    foreach ($data['questions'] as $q) {
        if (!isset($q['question'], $q['type'])) {
            throw new Exception("Missing question or type");
        }

        // Get QType_ID
        $stmt = $pdo->prepare("SELECT QType_ID FROM Question_Type WHERE Question_Type = ?");
        $stmt->execute([$q['type']]);
        if ($stmt->rowCount() === 0) {
            throw new Exception("Invalid question type: {$q['type']}");
        }
        $typeId = $stmt->fetch(PDO::FETCH_ASSOC)['QType_ID'];

        // Insert Main_Questions
        $stmt = $pdo->prepare("INSERT INTO Main_Questions (Form_ID, Main_Question, QType_ID, Required) VALUES (?, ?, ?, ?)");
        $stmt->execute([$formId, $q['question'], $typeId, $q['required'] ?? false]);
        $questionId = $pdo->lastInsertId();

        // Insert options
        if (!empty($q['options'])) {
            foreach ($q['options'] as $opt) {
                $text = is_array($opt) ? ($opt['Choice_Text'] ?? '') : $opt;
                if (!empty(trim($text))) {
                    $pdo->prepare("INSERT INTO Choices (Main_Question_ID, Choice_Text) VALUES (?, ?)")
                        ->execute([$questionId, trim($text)]);
                }
            }
        }

        // Insert rows
        if (!empty($q['rows'])) {
            foreach ($q['rows'] as $row) {
                if (!empty(trim($row))) {
                    $pdo->prepare("INSERT INTO Sub_Question (Main_Question_ID, Sub_Question) VALUES (?, ?)")
                        ->execute([$questionId, trim($row)]);
                }
            }
        }
    }

    $pdo->commit();
    echo json_encode(['message' => 'Form updated successfully', 'id' => $formId]);
} catch (Exception $e) {
    $pdo->rollBack();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update form', 'message' => $e->getMessage()]);
}
?>