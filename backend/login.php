<?php
session_start();
ob_start();
include('connect.php'); // Include database connection

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email    = $_POST['email']    ?? null;
    $password = $_POST['password'] ?? null;

    if (!$email || !$password) {
        echo "Please enter both email and password.";
        exit();
    }

    // 1) Explicitly alias the counselor’s name columns so they don’t collide with anything else:
    $query = "
        SELECT 
            u.user_index,
            u.email,
            u.password,
            u.type,
            s.student_index,
            s.first_name   AS student_first_name,
            s.last_name    AS student_last_name,
            c.counselor_index,
            c.first_name   AS counselor_first_name,
            c.last_name    AS counselor_last_name
        FROM users u
        LEFT JOIN students   s ON u.user_index = s.user_index
        LEFT JOIN counselors c ON u.user_index = c.user_index
        WHERE u.email = ?
    ";

    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();


        $hashed_password = $row['password'];

        if (password_verify($password, $hashed_password)) {
            // Common session data:
            $_SESSION['user_index'] = $row['user_index'];
            $_SESSION['email']      = $row['email'];
            $_SESSION['user_type']  = $row['type'];

            // 2) Based on u.type, pull from the correct alias:
            if ($row['type'] === 'student') {
                $_SESSION['student_index'] = $row['student_index'];
                $_SESSION['first_name']    = $row['student_first_name'] ?? 'Student';
                $_SESSION['last_name']     = $row['student_last_name']  ?? '';
            }
            elseif ($row['type'] === 'counselor') {
                $_SESSION['counselor_index'] = $row['counselor_index'];
                $_SESSION['first_name']      = $row['counselor_first_name'] ?? 'Counselor';
                $_SESSION['last_name']       = $row['counselor_last_name']  ?? '';
            }
            else { // admin or any other unexpected type
                $_SESSION['first_name'] = 'Admin';
                $_SESSION['last_name']  = '';
            }

            $_SESSION['full_name'] = trim($_SESSION['first_name'] . ' ' . $_SESSION['last_name']);  

            // 3) Finally, redirect according to type:
            if ($row['type'] === 'admin') {
                header("Location: ../public/admin/admin-manage-forms.html");
            }
            elseif ($row['type'] === 'counselor'){
                header("Location: ../public/counselor/first-year.php");
            }
            else {
                header("Location: ../public/main.php");
            }
            exit();
        }
        else {
            echo "Invalid email or password.";
        }
    }
    else {
        echo "Invalid email or password.";
    }

    $stmt->close();
    $conn->close();
}
?>
