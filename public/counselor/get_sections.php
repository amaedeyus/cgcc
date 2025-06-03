<?php
require("../../backend/connect.php");

if (isset($_GET['program_code'])) {
    $program_code = $_GET['program_code'];
    $year_level = isset($_GET['year_level']) ? intval($_GET['year_level']) : null;

    // Get the program_index from the code
    $stmt = $conn->prepare("SELECT program_index FROM programs WHERE program_code = ?");
    $stmt->bind_param("s", $program_code);
    $stmt->execute();
    $result = $stmt->get_result();
    $program = $result->fetch_assoc();

    if ($program) {
        $program_index = $program['program_index'];

        if ($year_level) {
            // Filter sections by both program_index and year_level via student records
            $stmt = $conn->prepare("
                SELECT DISTINCT s.section_index, sec.section_name 
                FROM students s
                JOIN sections sec ON s.section_index = sec.section_index
                WHERE sec.program_index = ? AND s.year_level = ?
            ");
            $stmt->bind_param("ii", $program_index, $year_level);
        } else {
            // Get all sections for the program (regardless of year)
            $stmt = $conn->prepare("
                SELECT DISTINCT sec.section_index, sec.section_name
                FROM sections sec
                WHERE sec.program_index = ?
            ");
            $stmt->bind_param("i", $program_index);
        }
        $stmt->execute();
        $result = $stmt->get_result();

        $sections = [];
        while ($row = $result->fetch_assoc()) {
            $sections[] = $row;
        }

        echo json_encode($sections);
    } else {
        echo json_encode([]);
    }
} else {
    echo json_encode([]);
}
?>
