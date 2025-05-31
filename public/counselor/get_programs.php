<?php
require("../../backend/connect.php");

if (isset($_GET['dept_code'])) {
    $dept_code = $_GET['dept_code'];

    // Get dept_index using dept_code
    $stmt = $conn->prepare("SELECT dept_index FROM departments WHERE dept_code = ?");
    $stmt->bind_param("s", $dept_code);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        $dept_index = $row['dept_index'];

        // Now get programs using dept_index
        $stmt2 = $conn->prepare("SELECT program_code, program_name FROM programs WHERE dept_index = ?");
        $stmt2->bind_param("i", $dept_index);
        $stmt2->execute();
        $result2 = $stmt2->get_result();

        if ($result2->num_rows > 0) {
            echo '<option value="">Select Program</option>';
            while ($program = $result2->fetch_assoc()) {
                echo '<option value="' . htmlspecialchars($program['program_code']) . '">' . htmlspecialchars($program['program_name']) . '</option>';
            }
        } else {
            echo '<option value="">No programs available</option>';
        }

        $stmt2->close();
    } else {
        echo '<option value="">Select Department</option>';
    }

    $stmt->close();
}
?>
