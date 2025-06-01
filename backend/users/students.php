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
            g.full_name AS guardian_fullname,
            g.contact_number AS guardian_contact,
            sec.section_name, 
            p.program_code,
            p.program_index,
            d.dept_code
        FROM students s
        LEFT JOIN users u ON s.user_index = u.user_index
        LEFT JOIN guardians g ON s.guardian_index = g.guardian_index
        LEFT JOIN sections sec ON s.section_index = sec.section_index
        LEFT JOIN programs p ON sec.program_index = p.program_index
        LEFT JOIN departments d ON p.dept_index = d.dept_index
        WHERE s.student_index = ?
    ";

    $counselorsSql = "
        SELECT 
            c.counselor_index,
            c.first_name,
            c.last_name,
            c.credentials,
            c.image_path
        FROM counselors c
        JOIN counselor_programs cp ON c.counselor_index = cp.counselor_index
        WHERE cp.program_index = ?
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
        WHERE r.student_index = ? AND r.is_autosave = 0
        ORDER BY r.created_at DESC
    ";

    $countAnswersSql = "
        SELECT COUNT(*) AS answer_count
        FROM responses
        WHERE student_index = ? AND form_index = ? AND is_autosave = 0
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

    // --- Fetch assigned counselors ---
    $counselors = [];
    if (!empty($student['program_index'])) {
        $stmt = $conn->prepare($counselorsSql);
        if (!$stmt) throw new Exception($conn->error);
        $stmt->bind_param("i", $student['program_index']);
        $stmt->execute();
        $counselorsResult = $stmt->get_result();
        $counselors = $counselorsResult->fetch_all(MYSQLI_ASSOC);
    }

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
        
        $stmt->bind_param("ii", $studentId, $responseItem['form_index']);
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
        'student_email' => !empty($student['student_email']) ? $student['student_email'] : strtolower($student['first_name'] . $student['last_name'] . '@dlsl.edu.ph'),
        'contact_number' => $student['contact_number'] ?? '',
        'guardian_fullname' => !empty($student['guardian_fullname']) ? $student['guardian_fullname'] : $student['last_name'] . ', Guardian',
        'guardian_contact' => !empty($student['guardian_contact']) ? $student['guardian_contact'] : '09' . str_pad(rand(0, 999999999), 9, '0', STR_PAD_LEFT),
        'assigned_counselors' => array_map(function($counselor) {
            return [
                'counselor_index' => $counselor['counselor_index'],
                'full_name' => $counselor['first_name'] . ' ' . $counselor['last_name'],
                'credentials' => $counselor['credentials'] ?? '',
                'image_path' => !empty($counselor['image_path']) ? $counselor['image_path'] : '../Media/user.jpg'
            ];
        }, $counselors)
    ];

    $response['responses'] = $responses;

} catch (Exception $e) {
    $response['error'] = $e->getMessage();
}

echo json_encode($response, JSON_PRETTY_PRINT);
$conn->close();
?>