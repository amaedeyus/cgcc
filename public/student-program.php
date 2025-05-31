<?php
require "../backend/connect.php";  // Adjust path if needed

header('Content-Type: application/json');

if (!isset($_GET['dept_index'])) {
    echo json_encode([]);
    exit;
}

$dept_index = intval($_GET['dept_index']);

$stmt = $conn->prepare("SELECT program_index, program_name FROM programs WHERE dept_index = ?");
$stmt->bind_param("i", $dept_index);
$stmt->execute();
$result = $stmt->get_result();

$programs = [];
while ($row = $result->fetch_assoc()) {
    $programs[] = $row;
}

echo json_encode($programs);
?>
