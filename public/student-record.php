<?php require("../backend/connect2.php"); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/record.css">
    <title>Student Records</title>
</head>
<body>
<header>
    <div class="logo">
        <img src="cgcc.png" alt="cgcc-logo" class="logo-img">
        College Guidance and Counseling Center
    </div>
    <nav class="navigation">
        <a href="../main.html">Home</a>
        <a href="#">Contact</a>
        <a href="#">About Mental Health</a>
        <a href="#">FAQ</a>
    </nav>
</header>

<div class="grid-body">

    <div class="left-bg"></div>
            <div class="page-left">
                <div class="profile">
                    <div class="profile-picture"></div>
                    <span id="user-name"></span> <!-- papalitan ng id ni user -->
                        <div class="edit">
                            <a href="#">✎Edit Profile</a>
                        </div>
                </div>
                <div class="sidebar-nav">
                    <a onclick="goToPage()">➤ Counseling Schedule</a>
                    <div class="dropdown" onclick="toggleDropdown('Forms')">➤ Forms</div>
                        <div id="Forms" class="dropdown-content">
                            <a href="../student-profile-form.html">Student Information</a>
                            <a href="#">General Mental Health Screening</a>
                            <a href="#">Counseling Concerns & Exit Interview</a>
                            <a href="#">Counseling Evaluation</a>
                            <a href="#">Exit Interview</a>
                        </div>
                </div>
            </div>


    <div class="table-container">
    <table>
        <tr>
            <td colspan="7"><b>Student Records</b></td>
        </tr>
        <tr>
            <th>Student Number</th>
            <th>Last Name</th>
            <th>First Name</th>
            <th>Year Level</th>
            <th>Actions</th>
        </tr>

        <?php
        $sql = "SELECT * FROM student ORDER BY student_id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['student_id'] . "</td>";
                echo "<td>" . $row['last_name'] . "</td>"; 
                echo "<td>" . $row['first_name'] . "</td>";
                echo "<td>" . $row['year_level'] . "</td>";
                echo "<td><a href='edit_student.php?id=" . $row['student_id'] . "'>Edit</a> | <a href='delete_student.php?id=" . $row['student_id'] . "'>Delete</a></td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='7'>No records found</td></tr>";
        }
        ?>

    </table>
</div>
</body>
</html>