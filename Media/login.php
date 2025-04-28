<?php
session_start();
include('../include/conn.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Sanitize and get user inputs
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // Fetch the user's hashed password from the database
    $sql = "SELECT fld_password, fld_type FROM tbllogin WHERE fld_email = '$email'";
    $result = mysqli_query($conn, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result); 

        // Verify the password using password_verify()
        if (password_verify($password, $row['fld_password'])) {
            // Redirect to main.html after successful login
            header("Location: ../main.html");
            exit;            
        } else {
            echo "Invalid email or password.";
        }
    } else {
        echo "Invalid email or password.";
    }
}
?>