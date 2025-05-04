<?php
session_start();
include('connect.php'); // Include database connection

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve email and password from form input
    $email = $_POST['email'] ?? null;
    $password = $_POST['password'] ?? null;

    if (!$email || !$password) {
        $error = "Please enter both email and password.";
    } else {
        // Prepare query to fetch user data
        $query = "SELECT * FROM users WHERE email = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $hashed_password = $row['password'];

            // Verify hashed password
            if (password_verify($password, $hashed_password)) {
                // Set session variables
                $_SESSION['user_index'] = $row['user_index'];
                $_SESSION['email'] = $row['email'];
                $_SESSION['user_type'] = $row['user_type'];

                // Redirect users based on role
                if ($row['user_type'] == 'admin') {
                    //header("Location: admin-dashboard.php");
                } else {
                    header("Location: ../public/main.html");
                }
                exit();
            } else {
                $error = "Invalid email or password.";
            }
        } else {
            $error = "Invalid email or password.";
        }

        $stmt->close();
    }

    $conn->close();
}
?>
