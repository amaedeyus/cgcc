<?php
session_start();
require("../backend/connect.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $student_id = $_POST['student_index'] ?? null;
    $year_level = $_POST['year_level'] ?? null;
    $program_index = $_POST['program_index'] ?? null;  // still unused, keep or remove as needed
    $section_index = $_POST['section_index'] ?? null;
    $contact_number = $_POST['contact_number'] ?? null;

    $guardian_full_name = $_POST['guardian_full_name'] ?? null;
    $guardian_contact_number = $_POST['guardian_contact_number'] ?? null;

    if (!$student_id) {
        echo "Student ID is missing or empty.";
        exit;
    }

    $updateImage = false;
    $relative_path = null;

    if (isset($_FILES['profile_image']) && $_FILES['profile_image']['error'] === 0) {
        $upload_dir = __DIR__ . '/../../public/Media/uploads/';
        $filename = uniqid() . "-" . basename($_FILES["profile_image"]["name"]);
        $target_path = $upload_dir . $filename;
        $relative_path = '/Media/uploads/' . $filename;

        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0755, true);
        }

        if (move_uploaded_file($_FILES["profile_image"]["tmp_name"], $target_path)) {
            $updateImage = true;
        } else {
            echo "Failed to upload image.";
            exit;
        }
    }

    if ($updateImage) {
        $stmt = $conn->prepare("
            UPDATE students 
            SET year_level = ?, section_index = ?, contact_number = ?, image_path = ?
            WHERE student_index = ?
        ");
        $stmt->bind_param("iissi", $year_level, $section_index, $contact_number, $relative_path, $student_id);
    } else {
        $stmt = $conn->prepare("
            UPDATE students 
            SET year_level = ?, section_index = ?, contact_number = ?
            WHERE student_index = ?
        ");
        $stmt->bind_param("iisi", $year_level, $section_index, $contact_number, $student_id);
    }

    if (!$stmt) {
        echo "Prepare failed: (" . $conn->errno . ") " . $conn->error;
        exit;
    }

    $stmt->execute();
    $stmt->close();

    // Update guardian info if provided
    if ($guardian_full_name && $guardian_contact_number) {
        // Fetch guardian_index for this student
        $stmt_g = $conn->prepare("SELECT guardian_index FROM students WHERE student_index = ?");
        if (!$stmt_g) {
            echo "Prepare failed for guardian_index: (" . $conn->errno . ") " . $conn->error;
            exit;
        }
        $stmt_g->bind_param("i", $student_id);
        $stmt_g->execute();

        $stmt_g->bind_result($guardian_index);
        if (!$stmt_g->fetch()) {
            $guardian_index = null;
        }
        $stmt_g->close();

        if ($guardian_index) {
            // Update existing guardian
            $update_stmt = $conn->prepare("UPDATE guardians SET full_name=?, contact_number=? WHERE guardian_index=?");
            $update_stmt->bind_param("ssi", $guardian_full_name, $guardian_contact_number, $guardian_index);
            $update_stmt->execute();
            $update_stmt->close();
        } else {
            // Insert new guardian
            $insert_stmt = $conn->prepare("INSERT INTO guardians (full_name, contact_number) VALUES (?, ?)");
            $insert_stmt->bind_param("ss", $guardian_full_name, $guardian_contact_number);
            $insert_stmt->execute();
            $new_guardian_index = $conn->insert_id;
            $insert_stmt->close();

            // Update student record with new guardian_index
            $update_student_stmt = $conn->prepare("UPDATE students SET guardian_index = ? WHERE student_index = ?");
            $update_student_stmt->bind_param("ii", $new_guardian_index, $student_id);
            $update_student_stmt->execute();
            $update_student_stmt->close();
        }
    }

    echo "<script>
        alert('Profile Saved!');
        window.location.href = '../public/edit-profile.php';
        </script>";
    exit;
} else {
    echo "Invalid request method.";
}
?>
