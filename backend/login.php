<?php
session_start();
ob_start();
include('connect.php'); // Include database connection

function showStyledAlert($message, $type = 'danger', $title = 'Error') {
    ob_clean(); // Clear any previous output
    echo '<!DOCTYPE html>
    <html>
    <head>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="../public/css/alert.css">
        <style>
            .alert {
                opacity: 1 !important;
                display: flex !important;
            }
            .alert-content {
                transform: scale(1) !important;
            }
        </style>
    </head>
    <body>
        <div class="alert alert-' . $type . '">
            <div class="alert-content">
                <div class="alert-title">' . htmlspecialchars($title) . '</div>
                <div class="alert-message">' . htmlspecialchars($message) . '</div>
                <button class="alert-button" style="background-color: ' . 
                    ($type === 'success' ? '#316b50' : 
                    ($type === 'warning' ? '#ffc107' : 
                    ($type === 'danger' ? '#dc3545' : '#17a2b8'))) . 
                    '" onclick="window.history.back()">Go Back</button>
            </div>
        </div>
    </body>
    </html>';
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email    = $_POST['email']    ?? null;
    $password = $_POST['password'] ?? null;

    error_log("Login attempt started for email: " . $email);

    if (!$email || !$password) {
        error_log("Login failed: Missing email or password");
        showStyledAlert('Please enter both email and password.', 'danger', 'Login Error');
    }

    // 1) Explicitly alias the counselor's name columns so they don't collide with anything else:
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

    error_log("Executing query for email: " . $email);

    $stmt = $conn->prepare($query);
    if (!$stmt) {
        error_log("Query preparation failed: " . $conn->error);
        showStyledAlert('Database error occurred. Please try again.', 'danger', 'Database Error');
    }

    $stmt->bind_param("s", $email);
    if (!$stmt->execute()) {
        error_log("Query execution failed: " . $stmt->error);
        showStyledAlert('Database error occurred. Please try again.', 'danger', 'Database Error');
    }

    $result = $stmt->get_result();
    error_log("Query returned " . $result->num_rows . " rows");

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        
        // Debug information
        error_log("User found in database:");
        error_log("User index: " . $row['user_index']);
        error_log("User type: " . $row['type']);
        error_log("Student index: " . ($row['student_index'] ?? 'null'));
        error_log("Counselor index: " . ($row['counselor_index'] ?? 'null'));

        $hashed_password = $row['password'];
        error_log("Stored hashed password: " . $hashed_password);
        error_log("Attempting to verify password...");

        if (password_verify($password, $hashed_password)) {
            error_log("Password verification successful");
            
            // Common session data:
            $_SESSION['user_index'] = $row['user_index'];
            $_SESSION['email']      = $row['email'];
            $_SESSION['user_type']  = $row['type'];

            // 2) Based on u.type, pull from the correct alias:
            if ($row['type'] === 'student') {
                if (!$row['student_index']) {
                    error_log("Error: Student type but no student_index found");
                    showStyledAlert('Account error: Student record not found.', 'danger', 'Account Error');
                }
                $_SESSION['student_index'] = $row['student_index'];
                $_SESSION['first_name']    = $row['student_first_name'] ?? 'Student';
                $_SESSION['last_name']     = $row['student_last_name']  ?? '';
                
                error_log("Student session set - Index: " . $_SESSION['student_index']);
            }
            elseif ($row['type'] === 'counselor') {
                if (!$row['counselor_index']) {
                    error_log("Error: Counselor type but no counselor_index found");
                    showStyledAlert('Account error: Counselor record not found.', 'danger', 'Account Error');
                }
                $_SESSION['counselor_index'] = $row['counselor_index'];
                $_SESSION['first_name']      = $row['counselor_first_name'] ?? 'Counselor';
                $_SESSION['last_name']       = $row['counselor_last_name']  ?? '';
                
                error_log("Counselor session set - Index: " . $_SESSION['counselor_index']);
            }
            else { // admin or any other unexpected type
                $_SESSION['first_name'] = 'Admin';
                $_SESSION['last_name']  = '';
                error_log("Admin session set");
            }

            $_SESSION['full_name'] = trim($_SESSION['first_name'] . ' ' . $_SESSION['last_name']);  

            error_log("Final session state: " . print_r($_SESSION, true));

            // 3) Finally, redirect according to type:
            if ($row['type'] === 'admin') {
                error_log("Redirecting to admin page");
                header("Location: ../public/admin/admin-manage-forms.html");
            }
            elseif ($row['type'] === 'counselor'){
                error_log("Redirecting to counselor page");
                header("Location: ../public/counselor/first-year.php");
            }
            else {
                error_log("Redirecting to student page");
                header("Location: ../public/main.php");
            }
            exit();
        }
        else {
            error_log("Password verification failed for email: " . $email);
            error_log("Input password: " . $password);
            showStyledAlert('Invalid email or password.', 'danger', 'Authentication Error');
        }
    }
    else {
        error_log("No user found with email: " . $email);
        showStyledAlert('Invalid email or password.', 'danger', 'Authentication Error');
    }

    $stmt->close();
    $conn->close();
} else {
    // If not POST method, show error
    showStyledAlert('Invalid request method.', 'danger', 'Error');
}
?>
