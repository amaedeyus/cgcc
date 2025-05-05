<?php
session_start();

// Load Composer dependencies
require_once __DIR__ . '/vendor/autoload.php';

use Dotenv\Dotenv;

// Load .env (if needed)
$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Initialize Google Client
$client = new Google_Client();
$client->setAuthConfig(__DIR__ . '/client_secret.json'); // Make sure this file exists here!
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

        // Get user info
        $oauth2 = new Google_Service_Oauth2($client);
        $userInfo = $oauth2->userinfo->get();

        // Save to session
        $_SESSION['user'] = [
            'id' => $userInfo->getId(),
            'name' => $userInfo->getName(),
            'email' => $userInfo->getEmail()
        ];

        header('Location: dashboard.php');
        exit;
    } else {
        die('Error fetching access token: ' . htmlspecialchars($token['error']));
    }
}