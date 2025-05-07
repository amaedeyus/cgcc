<?php
require_once __DIR__ . '/../vendor/autoload.php';

session_start(); // Start the session here

$client = new Google_Client();
$client->setClientId($_ENV['GOOGLE_CLIENT_ID']);
$client->setClientSecret($_ENV['GOOGLE_CLIENT_SECRET']);
$client->setRedirectUri('http://localhost/cgcc-system/backend/auth_callback.php');
$client->addScope('email');
$client->addScope('profile');

// You can keep this reusable in other scripts