<?php
// image.php?file=Media/uploads/counselors/counselor_1_1748690178.png

if (!isset($_GET['file'])) {
    http_response_code(404);
    exit('No file specified.');
}

$file = $_GET['file'];

// Sanitize input - allow only expected characters to prevent path traversal
if (preg_match('/^[a-zA-Z0-9\/_\-\.]+$/', $file) !== 1) {
    http_response_code(400);
    exit('Invalid file name.');
}

// Build absolute path to backend public folder
$base_dir = realpath(__DIR__ . '/../backend/public/');
$full_path = realpath($base_dir . '/' . $file);

if ($full_path === false || strpos($full_path, $base_dir) !== 0 || !file_exists($full_path)) {
    http_response_code(404);
    exit('File not found.');
}

$mime = mime_content_type($full_path);
header('Content-Type: ' . $mime);
readfile($full_path);
exit;
