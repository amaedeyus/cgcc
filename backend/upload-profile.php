<?php
session_start();
require("../backend/connect2.php"); // include your DB connection

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $student_id = $_POST['student_index'] ?? null;
    $year_level = $_POST['year_level'] ?? null;
    $program_index = $_POST['program_index'] ?? null;
    $section_index = $_POST['section_index'] ?? null;
    

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
        $relative_path = '/../../public/Media/uploads/' . $filename;

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

    
    $contact_number = $_POST['contact_number'] ?? null;


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
        $stmt->bind_param("sisi", $year_level, $section_index, $contact_number, $student_id);
}


    if (!$stmt) {
        echo "Prepare failed: (" . $conn->errno . ") " . $conn->error;
        exit;
    }

    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        echo "<script>
        alert('Profile Saved!');
        window.location.href = '../public/edit-profile.php';
        </script>";
        exit;
    } else {
        echo "<script>
        alert('Profile Saved!');
        window.location.href = '../public/edit-profile.php';
        </script>";
        exit;
    }

    $stmt->close();
} else {
    echo "Invalid request method.";
}

$guardian_first_name = $_POST['guardian_first_name'];
$guardian_last_name = $_POST['guardian_last_name'];
$guardian_contact_number = $_POST['guardian_contact_number'];

// Fetch guardian_index for this student
$stmt = $conn->prepare("SELECT guardian_index FROM students WHERE student_index = ?");
$stmt->bind_param("i", $student_index);
$stmt->execute();
$result = $stmt->get_result();
$guardian_index = $result->fetch_assoc()['guardian_index'] ?? null;

if ($guardian_index) {
    // Update existing guardian
    $update_stmt = $conn->prepare("UPDATE guardians SET first_name=?, last_name=?, contact_number=? WHERE guardian_index=?");
    $update_stmt->bind_param("sssi", $guardian_first_name, $guardian_last_name, $guardian_contact_number, $guardian_index);
    $update_stmt->execute();
} else {
    // Insert new guardian
    $insert_stmt = $conn->prepare("INSERT INTO guardians (first_name, last_name, contact_number) VALUES (?, ?, ?)");
    $insert_stmt->bind_param("sss", $guardian_first_name, $guardian_last_name, $guardian_contact_number);
    $insert_stmt->execute();
    $new_guardian_index = $conn->insert_id;

    // Update student record with new guardian_index
    $update_student_stmt = $conn->prepare("UPDATE students SET guardian_index = ? WHERE student_index = ?");
    $update_student_stmt->bind_param("ii", $new_guardian_index, $student_index);
    $update_student_stmt->execute();
}
?>
