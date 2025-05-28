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

    // Query to get user and student name
  // Modify your query to left join:
    $query = "
        SELECT users.*, students.first_name, students.last_name 
        FROM users 
        LEFT JOIN students ON users.user_index = students.user_index 
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

            // Temporarily add this debug code:
            echo "Stored hash: ".$hashed_password."<br>";
            echo "Input password: ".$password."<br>";
            echo "Verification: ".(password_verify($password, $hashed_password) ? 'true' : 'false');
            // Set session variables
            $_SESSION['user_index'] = $row['user_index'];
            $_SESSION['email'] = $row['email'];
            $_SESSION['user_type'] = $row['type'];

            // Name values
            $firstName = $row['first_name'] ?? 'User';
            $lastName = $row['last_name'] ?? '';

            $_SESSION['first_name'] = $firstName;
            $_SESSION['last_name'] = $lastName;
            $_SESSION['full_name'] = trim($firstName . ' ' . $lastName);

            // Redirect based on user type
            if ($row['type'] === 'admin') {
                header("Location: ../public/admin/admin-manage-forms.html");
            } else if ($row['type'] === 'counselor'){
                header("Location: ../public/counselor/student-record.php");
            } else {
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
