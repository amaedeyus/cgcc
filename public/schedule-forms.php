<?php
session_start();
require "../backend/connect.php";

$student_index = $_SESSION['student_index'] ?? null;
$student = [];
$counselor = [];
$allRequiredFormsCompleted = false;

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

    // Step 3: Check if all required forms are completed
    $stmt3 = $conn->prepare("
        SELECT 
            f.form_index,
            f.form_name,
            CASE WHEN fr.response_index IS NOT NULL THEN 1 ELSE 0 END as has_responded
        FROM forms f
        LEFT JOIN form_responses fr ON f.form_index = fr.form_index 
            AND fr.student_index = ?
        WHERE f.is_required = 1 AND f.is_active = 1
    ");
    $stmt3->bind_param("i", $student_index);
    $stmt3->execute();
    $res3 = $stmt3->get_result();
    
    $requiredForms = [];
    $completedForms = [];
    while ($form = $res3->fetch_assoc()) {
        $requiredForms[] = $form;
        if ($form['has_responded']) {
            $completedForms[] = $form['form_index'];
        }
    }
    
    $allRequiredFormsCompleted = count($requiredForms) === count($completedForms);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="Media/cgcc2.png">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/form-validation.css">
    <title>CGCC - Schedule Forms</title>
    <style>
        .content-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }
        .counselor-panel {
            background-color: rgb(237, 253, 243);
            border-radius: 20px;
            box-shadow: 0 3px 10px rgba(0, 71, 0, 0.2);
            padding: 30px;
            text-align: center;
            margin-bottom: 30px;
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
        .form-list {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .form-list li {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .form-title {
            color: #2c3e50;
            font-weight: 500;
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
        }
        .status-completed {
            background-color: #4CAF50;
            color: white;
        }
        .status-pending {
            background-color: #ff9800;
            color: white;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }
        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }
        .alert-warning {
            background-color: #fff3e0;
            color: #ef6c00;
            border: 1px solid #ffcc80;
        }
        .alert-danger {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ef9a9a;
        }
        .btn-primary {
            display: inline-block;
            padding: 10px 20px;
            background-color: rgb(79, 189, 156);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: rgb(36, 154, 118);
        }
        .back {
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
        .back:hover {
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

    <div class="content-container">
        <?php if ($allRequiredFormsCompleted && !empty($counselor)): ?>
            <div class="counselor-panel">
                <img src="image.php?file=<?= urlencode($counselor['image_path']) ?>" alt="Counselor Photo" class="counselor-photo">
                <h2><?= htmlspecialchars($counselor['first_name'] . ' ' . $counselor['last_name'] . (!empty($counselor['credentials']) ? ', ' . $counselor['credentials'] : '')) ?></h2>
                <p><strong>Email:</strong> <a href="mailto:<?= htmlspecialchars($counselor['email']) ?>"><?= htmlspecialchars($counselor['email']) ?></a></p>
                <?php if (!empty($counselor['calendar_link'])): ?>
                    <p><a href="<?= htmlspecialchars($counselor['calendar_link']) ?>" target="_blank" class="calendar-link">📅 Schedule an Appointment</a></p>
                <?php endif; ?>
            </div>
        <?php else: ?>
            <div class="notice">
                <h1>Appointment Requirements</h1>
                <div id="forms-container">
                    <?php if (empty($requiredForms)): ?>
                        <div class="alert alert-success">
                            No forms required at this time. You may proceed with scheduling.
                        </div>
                        <a href="schedule.html" class="btn-primary">Schedule Appointment</a>
                    <?php else: ?>
                        <p>You need to complete the following forms before scheduling an appointment:</p>
                        <ul class="form-list">
                            <?php foreach ($requiredForms as $form): ?>
                                <li class="<?= $form['has_responded'] ? 'form-completed' : '' ?>">
                                    <a href="student_form.html?id=<?= $form['form_index'] ?>" class="form-title">
                                        <?= htmlspecialchars($form['form_name']) ?>
                                    </a>
                                    <span class="status-badge <?= $form['has_responded'] ? 'status-completed' : 'status-pending' ?>">
                                        <?= $form['has_responded'] ? 'Done' : 'Pending' ?>
                                    </span>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                        
                        <?php if ($allRequiredFormsCompleted): ?>
                            <div class="alert alert-success">
                                All required forms completed! You may now schedule an appointment.
                            </div>
                            <a href="schedule.html" class="btn-primary">Schedule Appointment</a>
                        <?php else: ?>
                            <div class="alert alert-warning">
                                Please complete all required forms before scheduling.
                            </div>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
            </div>
        <?php endif; ?>
    </div>

    <button class="back" onclick="window.location.href='main.php'">Back</button>
</body>
</html> 