<?php
session_start();
ob_start();
include('connect.php'); // Include database connection

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'] ?? null;
    $password = $_POST['password'] ?? null;

    if (!$email || !$password) {
        echo "Please enter both email and password.";
        exit();
    }

    // Modified query to get user, student, and counselor data
    $query = "
        SELECT 
            users.*, 
            students.student_index,
            students.first_name AS student_first_name,
            students.last_name AS student_last_name,
            counselors.counselor_index,
            counselors.first_name AS counselor_first_name,
            counselors.last_name AS counselor_last_name
        FROM users 
        LEFT JOIN students ON users.user_index = students.user_index 
        LEFT JOIN counselors ON users.user_index = counselors.user_index 
        WHERE users.email = ?
    ";

    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashed_password = $row['password'];

        if (password_verify($password, $hashed_password)) {
            // Set common session variables
            $_SESSION['user_index'] = $row['user_index'];
            $_SESSION['email'] = $row['email'];
            $_SESSION['user_type'] = $row['type'];

            // Set user-specific session variables based on type
            if ($row['type'] === 'student') {
                $_SESSION['student_index'] = $row['student_index'];
                $_SESSION['first_name'] = $row['student_first_name'] ?? 'Student';
                $_SESSION['last_name'] = $row['student_last_name'] ?? '';
            } 
            elseif ($row['type'] === 'counselor') {
                $_SESSION['counselor_index'] = $row['counselor_index'];
                $_SESSION['first_name'] = $row['counselor_first_name'] ?? 'Counselor';
                $_SESSION['last_name'] = $row['counselor_last_name'] ?? '';
            } 
            else { // Admin
                $_SESSION['first_name'] = 'Admin';
                $_SESSION['last_name'] = '';
            }

            $_SESSION['full_name'] = trim($_SESSION['first_name'] . ' ' . $_SESSION['last_name']);

            // Redirect based on user type
            if ($row['type'] === 'admin') {
                header("Location: ../public/admin/admin-manage-forms.html");
            } 
            elseif ($row['type'] === 'counselor'){
                header("Location: ../public/counselor/student-record.php");
            } 
            else {
                header("Location: ../public/main.php");
            }
            exit();
        } else {
            echo "Invalid email or password.";
        }
    } else {
        echo "Invalid email or password.";
    }

    $stmt->close();
    $conn->close();
}
?>