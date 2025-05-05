<?php
require '../connect.php';

try {
    $stmt = $pdo->query("SELECT * FROM Forms");
    $forms = $stmt->fetchAll();
    echo json_encode($forms);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to retrieve forms']);
}
?>
