<?php
require("../backend/connect2.php");

if (isset($_GET['program_code'])) {
    $program_code = $_GET['program_code'];

    // Get the program_index from the code
    $stmt = $conn->prepare("SELECT program_index FROM programs WHERE program_code = ?");
    $stmt->bind_param("s", $program_code);
    $stmt->execute();
    $result = $stmt->get_result();
    $program = $result->fetch_assoc();

    if ($program) {
        $program_index = $program['program_index'];

        $stmt = $conn->prepare("SELECT section_index, section_name FROM sections WHERE program_index = ?");
        $stmt->bind_param("i", $program_index);
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
