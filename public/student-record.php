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
        <img src="Media/cgcc.png" alt="cgcc-logo" class="logo-img">
        College Guidance and Counseling Center
    </div>
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

<div class="page-right">
    <div class="table-container">
  <h2>Student Management</h2>
  <p>Add, edit, and manage student records</p>
  <button class="btn-success" onclick="location.href='add_student.php'">+ Add New Student</button>
  <div class="search-box">
                    <input type="text" placeholder="Search programs..." id="searchInput">
                    <button class="search-btn">🔍</button>
                </div>

  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Last Name</th>
        <th>First Name</th>
        <th>Year Level</th>
        <th>Section</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody id="studentTableBody">
      <?php
        $sql = "SELECT * FROM students ORDER BY last_name";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['student_number'] . "</td>";
                echo "<td>" . $row['last_name'] . "</td>"; 
                echo "<td>" . $row['first_name'] . "</td>";
                echo "<td>" . $row['year_level'] . "</td>";
                echo "<td>" . $row['section_index'] . "</td>";
                echo "<td class='actions'><a href='view_student.php?id=" . $row['student_index'] . "'>View</a></td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='5'>No records found</td></tr>";
        }
        $conn->close();
      ?>
    </tbody>
  </table>
</div>
    </div>
</body>
</html>