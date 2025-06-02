<?php
session_start();
use Google\Service\Oauth2;
require_once __DIR__ . '/../vendor/autoload.php';
    require_once __DIR__ . '/connect.php'; // include your DB connection
    
// Initialize Google Client
$client = new Google_Client();
$client->setAuthConfig(__DIR__ . '/config/secret.json');
$client->addScope("email");
$client->addScope("profile");
$client->setRedirectUri('http://localhost/cgcc/backend/auth_callback.php');

if (!isset($_GET['code'])) {
    $authUrl = $client->createAuthUrl();
    header('Location: ' . filter_var($authUrl, FILTER_SANITIZE_URL));
    exit;
} else {
    $token = $client->fetchAccessTokenWithAuthCode($_GET['code']);
    
    if (!isset($token['error'])) {
        $client->setAccessToken($token);

        // Get user info from Google
        $oauth2 = new Oauth2($client);
        $userInfo = $oauth2->userinfo->get();
        $email = $userInfo->getEmail();

        // Check user in your DB
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

        if ($result && $row = $result->fetch_assoc()) {
            // Save user data to session
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
            } else if ($row['type'] === 'counselor'){
                header("Location: ../public/counselor/first-year.php");
            } else {
                header("Location: ../public/main.php");
            }
        } else {
            // Optional: redirect or show error if user not found in DB
            die("User with email $email not found in system.");
        }

        $stmt->close();
        $conn->close();
        exit;
    } else {
        die('Error fetching access token: ' . htmlspecialchars($token['error']));
    }
}