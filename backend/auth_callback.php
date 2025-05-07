<?php
session_start();
use Google\Service\Oauth2;
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/connect.php'; // include your DB connection

use Dotenv\Dotenv;
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Initialize Google Client
$client = new Google_Client();
$client->setAuthConfig(__DIR__ . '/config/secret.json');
$client->addScope("email");
$client->addScope("profile");
$client->setRedirectUri('http://localhost/cgcc-system/backend/auth_callback.php');

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
        $query = "SELECT * FROM users WHERE email = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result && $row = $result->fetch_assoc()) {
            // Save user data to session
            $_SESSION['user_index'] = $row['user_index'];
            $_SESSION['email'] = $row['email'];
            $_SESSION['user_type'] = $row['type'];

            // Redirect based on user type
            if ($row['type'] === 'admin') {
                header("Location: ../public/admin.html");
            } else if ($row['type'] === 'counselor'){
                header("Location: ../public/student-record.php");
            } else {
                echo $row['user_type'];
                header("Location: ../public/main.html");
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