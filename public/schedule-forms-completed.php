<?php
session_start();
require "../backend/connect.php";

$student_index = $_SESSION['student_index'] ?? null;
$student = [];
$counselor = [];

if ($student_index) {
    // Step 1: Get student info (to access section_index)
    $stmt = $conn->prepare("SELECT * FROM students WHERE student_index = ?");
    $stmt->bind_param("i", $student_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $student = $result->fetch_assoc();

    // Step 2: Get counselor info through section → program → counselor → user
    if (!empty($student['section_index'])) {
        $stmt2 = $conn->prepare("
            SELECT 
                c.first_name, c.last_name, c.image_path, c.credentials, c.calendar_link,
                u.email
            FROM sections s
            JOIN programs p ON s.program_index = p.program_index
            JOIN counselors c ON p.counselor_index = c.counselor_index
            JOIN users u ON c.user_index = u.user_index
            WHERE s.section_index = ?
        ");
        $stmt2->bind_param("i", $student['section_index']);
        $stmt2->execute();
        $res2 = $stmt2->get_result();
        $counselor = $res2->fetch_assoc();
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
    <style>
        .counselor-panel {
    margin: 50px auto;
    padding: 30px;
    max-width: 600px;
    background-color: rgb(237, 253, 243); /* match form container */
    border-radius: 20px;
    box-shadow: 0 3px 10px rgba(0, 71, 0, 0.2); /* match form shadow */
    text-align: center;
    font-family: 'Poppins', sans-serif;
    color: rgb(41, 51, 41);
}

.counselor-photo {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 15px;
    border: 3px solid #316b50;
}

.counselor-panel h2 {
    color: #0c3b25;
    font-size: 1.8em;
    margin-bottom: 10px;
}

.counselor-panel p {
    font-size: 1em;
    margin: 6px 0;
    color: #5b5b5b;
}

.calendar-link {
    display: inline-block;
    margin-top: 15px;
    padding: 10px 20px;
    background-color: rgb(79, 189, 156);
    color: white;
    border-radius: 30px;
    text-decoration: none;
    font-weight: 500;
    transition: background-color 0.3s ease;
}

.calendar-link:hover {
    background-color: rgb(36, 154, 118);
}

.back{
    position: fixed;
    bottom: 20px;
    right: 20px;
    padding: 8px 15px;
    background-color: rgb(79, 189, 156);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-family: 'Poppins', sans-serif;
    width: 100px;
    text-align: center;
}

.back:hover{
    background: rgb(36, 154, 118);
}

    </style>
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

    <?php if (!empty($counselor)): ?>
<div class="counselor-panel">
    <img src="image.php?file=<?= urlencode($counselor['image_path']) ?>" alt="Counselor Photo" class="counselor-photo">


    <h2><?= htmlspecialchars($counselor['first_name'] . ' ' . $counselor['last_name']) ?></h2>
    <p><strong>Credentials:</strong> <?= htmlspecialchars($counselor['credentials']) ?></p>
    <p><strong>Email:</strong> <a href="mailto:<?= htmlspecialchars($counselor['email']) ?>"><?= htmlspecialchars($counselor['email']) ?></a></p>
    <?php if (!empty($counselor['calendar_link'])): ?>
    <p><a href="<?= htmlspecialchars($counselor['calendar_link']) ?>" target="_blank" class="calendar-link">📅 Schedule an Appointment</a></p>
    <?php endif; ?>
</div>
<?php else: ?>
<div class="counselor-panel">
    <h2>No Assigned Counselor</h2>
    <p>Your program currently has no counselor assigned. Please contact the CGCC office.</p>
</div>
<?php endif; ?>

<button class="back" onclick="window.location.href='main.php'">Back</button>

</body>
</html>
