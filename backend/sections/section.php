<?php
require_once '../connect.php';

// Check if program_index or section_index or year_level is provided
$program_index = isset($_GET['program_index']) ? (int)$_GET['program_index'] : null;
$year_level = isset($_GET['year_level']) ? (int)$_GET['year_level'] : null;
$section_index = isset($_GET['section_index']) ? (int)$_GET['section_index'] : null;

// Base query
$query = "SELECT s.section_index, s.section_name, s.program_index, s.year_level,
                 p.program_code, p.program_name, d.dept_code, d.dept_index
          FROM sections s
          JOIN programs p ON s.program_index = p.program_index
          JOIN departments d ON p.dept_index = d.dept_index
          WHERE 1=1";

$params = [];
$types = "";

// Add section filter if provided
if ($section_index !== null) {
    $query .= " AND s.section_index = ?";
    $params[] = $section_index;
    $types .= "i";
} else {
    // Add program filter if provided (only if section_index is not provided)
    if ($program_index !== null) {
        $query .= " AND s.program_index = ?";
        $params[] = $program_index;
        $types .= "i";
    }

    // Add year level filter if provided (only if section_index is not provided)
    if ($year_level !== null) {
        $query .= " AND s.year_level = ?";
        $params[] = $year_level;
        $types .= "i";
    }
}

// Order by department code, program code, year level, and section name
$query .= " ORDER BY d.dept_code, p.program_code, s.year_level, s.section_name";

// Prepare and execute the query
$stmt = $conn->prepare($query);

if (!empty($params)) {
    $stmt->bind_param($types, ...$params);
}

$stmt->execute();
$result = $stmt->get_result();

if (!$result) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch sections']);
    exit;
}

$sections = [];
while ($row = $result->fetch_assoc()) {
    $sections[] = [
        'section_index' => $row['section_index'],
        'section_name' => $row['section_name'],
        'program_index' => $row['program_index'],
        'year_level' => $row['year_level'],
        'program_code' => $row['program_code'],
        'program_name' => $row['program_name'],
        'dept_code' => $row['dept_code'],
        'dept_index' => $row['dept_index']
    ];
}

// Output as JSON
header('Content-Type: application/json');
echo json_encode($sections);
?> 