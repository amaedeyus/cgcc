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
                    <span id="user-name">Counselor</span> <!-- papalitan ng id ni user -->
                        <div class="edit">
                            <a href="#">✎Edit Profile</a>
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
        $sql = "SELECT * FROM students ORDER BY last_name";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['student_index'] . "</td>";
                echo "<td>" . $row['last_name'] . "</td>"; 
                echo "<td>" . $row['first_name'] . "</td>";
                echo "<td>" . $row['year_level'] . "</td>";
                echo "<td><a href='view_student.php?id=" . $row['student_index'] . "'>View</a></td>";
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