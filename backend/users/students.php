<?php
header('Content-Type: application/json');
require("../../backend/connect.php");

$response = ['error' => null, 'student' => null, 'responses' => []];

try {
    if (!isset($_GET['id'])) {
        throw new Exception('Student ID not provided');
    }

    $studentId = (int) $_GET['id'];

    // --- Use LEFT JOINs to avoid filtering out valid students ---
    $studentSql = "
        SELECT 
            s.*, 
            u.email AS student_email, 
            CONCAT(g.first_name, ' ', g.last_name) AS guardian_fullname, 
            g.contact_number AS guardian_contact,
            sec.section_name, 
            p.program_code, 
            d.dept_code
        FROM students s
        LEFT JOIN users u ON s.user_index = u.user_index
        LEFT JOIN guardians g ON s.guardian_index = g.guardian_index
        LEFT JOIN sections sec ON s.section_index = sec.section_index
        LEFT JOIN programs p ON sec.program_index = p.program_index
        LEFT JOIN departments d ON p.dept_index = d.dept_index
        WHERE s.student_index = ?
    ";

    $responsesSql = "
        SELECT 
            r.response_index,
            r.form_index,
            f.form_name,
            r.created_at,
            r.academic_year
        FROM responses r
        JOIN forms f ON r.form_index = f.form_index
        WHERE r.student_index = ?
        ORDER BY r.created_at DESC
    ";

    $countAnswersSql = "
        SELECT COUNT(*) AS answer_count
        FROM responses
        WHERE student_index = ? AND form_index = ?
    ";
    // --- Fetch student info ---
    $stmt = $conn->prepare($studentSql);
    if (!$stmt) throw new Exception($conn->error);
    $stmt->bind_param("i", $studentId);
    $stmt->execute();
    $studentResult = $stmt->get_result();

    if ($studentResult->num_rows === 0) {
        throw new Exception('Student not found');
    }

    $student = $studentResult->fetch_assoc();

    // --- Fetch responses ---
    $stmt = $conn->prepare($responsesSql);
    if (!$stmt) throw new Exception($conn->error);
    $stmt->bind_param("i", $studentId);
    $stmt->execute();
    $responsesResult = $stmt->get_result();
    $responses = $responsesResult->fetch_all(MYSQLI_ASSOC);

    foreach ($responses as &$responseItem) {
        $stmt = $conn->prepare($countAnswersSql);
        if (!$stmt) throw new Exception($conn->error);
        
        $stmt->bind_param("ii", $studentId, $responseItem['form_index']); // FIXED
        $stmt->execute();
        $countResult = $stmt->get_result();
        $count = $countResult->fetch_assoc();
        $responseItem['answer_count'] = (int) $count['answer_count'];
    }

    // --- Format student info ---
    $response['student'] = [
        'image_path' => !empty($student['image_path']) ? $student['image_path'] : '../Media/user.jpg',
        'student_number' => $student['student_number'] ?? '',
        'first_name' => $student['first_name'] ?? '',
        'last_name' => $student['last_name'] ?? '',
        'year_level' => $student['year_level'] ?? '',
        'section_name' => $student['section_name'] ?? '',
        'dept_code' => $student['dept_code'] ?? '',
        'program_code' => $student['program_code'] ?? '',
        'student_email' => $student['student_email'] ?? '',
        'contact_number' => $student['contact_number'] ?? '',
        'guardian_fullname' => $student['guardian_fullname'] ?? '',
        'guardian_contact' => $student['guardian_contact'] ?? ''
    ];

    $response['responses'] = $responses;

} catch (Exception $e) {
    $response['error'] = $e->getMessage();
}

echo json_encode($response, JSON_PRETTY_PRINT);
$conn->close();
?> 
