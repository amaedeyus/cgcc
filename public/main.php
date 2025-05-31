<?php
session_start();

require "../backend/connect.php";  // include the database connection

$student_index = $_SESSION['student_index'] ?? null;
$student = [];

if ($student_index) {
    $stmt = $conn->prepare("
        SELECT s.*, u.email 
        FROM students s
        LEFT JOIN users u ON s.user_index = u.user_index
        WHERE s.student_index = ?
    ");
    $stmt->bind_param("i", $student_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $student = $result->fetch_assoc();
}

$fullName = isset($_SESSION['full_name']) ? $_SESSION['full_name'] : 'Guest';
$firstName = isset($_SESSION['first_name']) ? $_SESSION['first_name'] : 'Guest';

// Fetch all active forms
$formsQuery = "
    SELECT f.form_index, f.form_name, f.is_required, 
           (SELECT COUNT(*) FROM responses r 
            WHERE r.form_index = f.form_index AND r.student_index = ?) as has_responded
    FROM forms f
    WHERE f.is_active = '1'
    ORDER BY f.is_required DESC, f.form_name ASC
";
$formsStmt = $conn->prepare($formsQuery);
$formsStmt->bind_param("i", $student_index);
$formsStmt->execute();
$formsResult = $formsStmt->get_result();

$counselingForms = [];
$otherForms = [];

while ($form = $formsResult->fetch_assoc()) {
    if ($form['is_required']) {
        $counselingForms[] = $form;
    } else {
        $otherForms[] = $form;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="cgcc2.png">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/base.css?v=<?= time() ?>">
    <link rel="stylesheet" href="css/main-page.css?v=<?= time() ?>">
    <title>CGCC</title>

</head>
<body>

    <header>
        <div class="logo">
            <img src="Media/cgcc.png" alt="cgcc-logo" class="logo-img">
            College Guidance and Counseling Center
        </div>
        <nav class="navigation">
            <a href="main.php">Home</a>
            <a href="contact.html">Contact</a>
            <a href="about-mental-health.html">About Mental Health</a>
            <a href="faq.html">FAQ</a>
        </nav>
    </header>

    <div class="grid-body">

        <div class="left-bg"></div>
        <div class="page-left">
            <div class="profile">
                <div class="profile-picture"><img src="<?= htmlspecialchars($student['image_path'] ?? 'default-profile.png') ?>"></div>
                <span id="user-name"><?= htmlspecialchars($fullName)?></span>
                    <div class="edit">
                        <a href="edit-profile.php">✎Edit Profile</a>
                    </div>
            </div>
            <div class="sidebar-nav">
                <a onclick="goToPage()">➤ Counseling Schedule</a>
                    <!-- Counseling Forms Dropdown -->
                    <?php if (!empty($counselingForms)): ?>
                        <div class="dropdown" onclick="toggleDropdown('CounselingForms')">➤ Counseling Forms (Required)</div>
                        <div id="CounselingForms" class="dropdown-content">
                            <?php foreach ($counselingForms as $form): ?>
                                <a href="student_form.html?id=<?= $form['form_index'] ?>" 
                                class="form-item <?= $form['has_responded'] ? 'completed' : '' ?>">
                                    <?= htmlspecialchars($form['form_name']) ?>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                    
                    <!-- Other Forms Dropdown -->
                    <?php if (!empty($otherForms)): ?>
                        <div class="dropdown" onclick="toggleDropdown('OtherForms')">➤ Other Forms</div>
                        <div id="OtherForms" class="dropdown-content">
                            <?php foreach ($otherForms as $form): ?>
                                <a href="student_form.html?id=<?= $form['form_index'] ?>" 
                                class="form-item <?= $form['has_responded'] ? 'completed' : '' ?>">
                                    <?= htmlspecialchars($form['form_name']) ?>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
            </div>

            <div class="logout-wrapper">
                <form method="POST" action="../backend/logout.php">
                    <button type="submit" class="logout-btn">Log Out</button>
                </form>
            </div>
            
        </div>

        <div class="page-right">
            <div class="greetings">
                <div class="h1">
                    Hello, <span id="user-name"><?= htmlspecialchars($firstName)?></span>! Welcome to the College Guidance and Counseling Center!
                </div>
                    <div class="subh1">
                        You Share, We Listen, We Care
                    </div>
                </div>
            <div class="info">
                <p>Welcome to the College Guidance and Counseling Center's online platform — your space to book appointments, access support services, 
                and submit forms with ease.</p>

                <p>Rooted in the spirit of faith, zeal for service, and communion in mission, the center is dedicated to facilitating students' academic, 
                social-emotional, and career growth. This platform serves as a bridge to comprehensive, ethical, and evidence-based guidance services 
                that promote mental well-being and help you reach your fullest potential.</p>
            </div>
            <div class="schedule">
                <button class="button-class" onclick="">
                Schedule a Counseling Appointment
                </button>
            </div>
            <div class="update">
                <button class="button-class" onclick="">
                    Edit Profile Information
                </button>
            </div>
        </div>

    </div>

<script>
function toggleDropdown(id){
    const content = document.getElementById(id);
    content.style.display = content.style.display === "block" ? "none" : "block";
}

function goToPage(){
    const condition = true;
    if (condition){
        window.location.href = "../schedule-forms-uncompleted.html";
    } else{
        window.location.href = "../schedule-forms-uncompleted.html";
    }
}
</script>

</body>
</html>