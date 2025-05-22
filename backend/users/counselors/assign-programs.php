<?php
header('Content-Type: application/json');
require_once '../../connect3.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['counselor_index']) || !isset($data['program_codes'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required parameters']);
    exit;
}

$counselorIndex = $data['counselor_index'];
$programCodes = $data['program_codes'];

try {
    $conn->begin_transaction();

    // First, unassign all programs from this counselor
    $stmt = $conn->prepare("UPDATE programs SET counselor_index = NULL WHERE counselor_index = ?");
    $stmt->bind_param("i", $counselorIndex);
    $stmt->execute();
    $stmt->close();

    // Then assign the selected programs
    if (!empty($programCodes)) {
        $placeholders = implode(',', array_fill(0, count($programCodes), '?'));
        $types = str_repeat('s', count($programCodes));
        
        $stmt = $conn->prepare("UPDATE programs SET counselor_index = ? WHERE program_code IN ($placeholders)");
        $stmt->bind_param("i".$types, $counselorIndex, ...$programCodes);
        $stmt->execute();
        $stmt->close();
    }

    $conn->commit();
    echo json_encode(['success' => true]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => 'Failed to update program assignments', 'message' => $e->getMessage()]);
}

$conn->close();
?>