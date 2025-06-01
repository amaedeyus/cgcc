<?php
require("../../backend/connect.php");

if (!isset($_GET['id'])) {
    echo "Student ID not provided.";
    exit;
}

$studentId = (int) $_GET['id'];
$sql = "
    SELECT 
        s.*, 
        u.email AS student_email, 
        g.full_name AS guardian_fullname, 
        g.contact_number AS guardian_contact,
        sec.section_name, 
        p.program_code, 
        d.dept_code
    FROM students s
    JOIN users u ON s.user_index = u.user_index
    JOIN guardians g ON s.guardian_index = g.guardian_index
    JOIN sections sec ON s.section_index = sec.section_index
    JOIN programs p ON sec.program_index = p.program_index
    JOIN departments d ON p.dept_index = d.dept_index
    WHERE s.student_index = $studentId
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $student = $result->fetch_assoc();
} else {
    echo "Student not found.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../Media/cgcc2.png">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/base.css?v=<?= time() ?>">
    <link rel="stylesheet" href="../css/view-student.css?v=<?= time() ?>">
    <title>CGCC</title>
</head>
<body>
    <header>
        <div class="logo">
            <img src="../Media/cgcc.png" alt="cgcc-logo" class="logo-img">
            College Guidance and Counseling Center
        </div>
    </header>

    <div class="grid-body">
        <div class="page-left">
            <h1 class="form-title">Student Information</h1>
            
            <div class="profile-section">
                <div class="profile-title">Profile Picture</div>
                <img src="<?= !empty($student['image_path']) ? htmlspecialchars($student['image_path']) : '../Media/user.jpg' ?>" alt="Profile Picture" class="profile-picture" id="profile-picture" />
            </div>

            <div class="form-container">
                <div class="form-columns">
                    <div class="form-group">
                        <label for="student-number">Student Number</label>
                        <input readonly type="text" id="student-number" value="<?= htmlspecialchars($student['student_number']) ?>" />

                        <label for="first-name">First Name</label>
                        <input readonly type="text" id="first-name" value="<?= htmlspecialchars($student['first_name']) ?>" />

                        <label for="last-name">Last Name</label>
                        <input readonly type="text" id="last-name" value="<?= htmlspecialchars($student['last_name']) ?>" />

                        <label for="year-level">Year Level</label>
                        <input readonly type="text" id="year-level" value="<?= htmlspecialchars($student['year_level']) ?>" />

                        <label for="section">Section</label>
                        <input readonly type="text" id="section" value="<?= htmlspecialchars($student['section_name']) ?>" />

                        <label for="department">Department</label>
                        <input readonly type="text" id="department" value="<?= htmlspecialchars($student['dept_code']) ?>" />

                        <label for="program">Program</label>
                        <input readonly type="text" id="program" value="<?= htmlspecialchars($student['program_code']) ?>" />
                    </div>

                    <div class="form-group-one">
                        <label for="email">Email</label>
                        <input readonly type="text" id="email" value="<?= htmlspecialchars($student['student_email']) ?>" />

                        <label for="contact-number">Contact Number</label>
                        <input readonly type="text" id="contact-number" value="<?= htmlspecialchars($student['contact_number']) ?>" />

                        <label for="guardian">Guardian</label>
                        <input readonly type="text" id="guardian" value="<?= htmlspecialchars($student['guardian_fullname']) ?>" />

                        <label for="guardian-contact">Guardian Contact No.</label>
                        <input readonly type="text" id="guardian-contact" value="<?= htmlspecialchars($student['guardian_contact']) ?>" />
                    </div>
                </div>
            </div>

            <button class="back" onclick="javascript:history.back()">Back</button>
        </div>

        <div class="page-right">
            <!-- You can add right panel content here -->
        </div>
    </div>
</body>
</html>
