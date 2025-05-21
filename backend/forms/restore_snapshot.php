<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");

session_start();

// Check if user is logged in and is admin
if (!isset($_SESSION['user_type']) || ($_SESSION['user_type'] !== 'admin' && $_SESSION['user_type'] !== 'counselor')) {
    http_response_code(403);
    echo json_encode(["message" => "Access denied. Admins only."]);
    exit();
}

// Include DB config
require_once 'config/db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['snapshot_id'])) {
    http_response_code(400);
    echo json_encode(["message" => "Missing snapshot ID."]);
    exit();
}

$snapshot_id = $data['snapshot_id'];

try {
    // Fetch the snapshot
    $stmt = $conn->prepare("SELECT snapshot_json FROM form_snapshots WHERE id = :snapshot_id");
    $stmt->bindParam(':snapshot_id', $snapshot_id, PDO::PARAM_INT);
    $stmt->execute();

    if ($stmt->rowCount() === 0) {
        http_response_code(404);
        echo json_encode(["message" => "Snapshot not found."]);
        exit();
    }

    $snapshot = $stmt->fetch(PDO::FETCH_ASSOC);
    $snapshot_json = $snapshot['snapshot_json'];

    // Update the main form structure table
    $update = $conn->prepare("UPDATE form_structure SET structure_json = :structure_json WHERE id = 1");
    $update->bindParam(':structure_json', $snapshot_json);
    $update->execute();

    echo json_encode(["message" => "Snapshot restored successfully."]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["message" => "Database error: " . $e->getMessage()]);
}
?>
