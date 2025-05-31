<?php
// get_sections.php
require "../backend/connect.php";

$program_index = intval($_GET['program_index'] ?? 0);
$year_level = intval($_GET['year_level'] ?? 0);

if ($program_index && $year_level) {
    $stmt = $conn->prepare("
        SELECT section_index, section_name 
        FROM sections 
        WHERE program_index = ? AND year_level = ?
    ");
    $stmt->bind_param("ii", $program_index, $year_level);
    $stmt->execute();
    $result = $stmt->get_result();

    $sections = [];
    while ($row = $result->fetch_assoc()) {
        $sections[] = $row;
    }
    header('Content-Type: application/json');
    echo json_encode($sections);
} else {
    echo json_encode([]);
}
