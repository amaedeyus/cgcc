<?php
require "../../backend/connect.php";

// Get all filter parameters
$formName = $_GET['form_name'] ?? '';
$department = $_GET['department'] ?? '';
$program = $_GET['program'] ?? '';
$section = $_GET['section'] ?? '';
$year = $_GET['year'] ?? '';

$data = [];
if (!empty($formName)) {
    // Get the corresponding form_index
    $stmt = $conn->prepare("SELECT form_index FROM forms WHERE form_name = ?");
    $stmt->bind_param("s", $formName);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $form_index = $row['form_index'] ?? null;

    if ($form_index) {
        // Build the WHERE clause and parameters dynamically
        $where = "r.form_index = ?";
        $params = [$form_index];
        $types = "i";

        if (!empty($department)) {
            $where .= " AND d.dept_code = ?";
            $params[] = $department;
            $types .= "s";
        }
        if (!empty($program)) {
            $where .= " AND p.program_code = ?";
            $params[] = $program;
            $types .= "s";
        }
        if (!empty($section)) {
            $where .= " AND s.section_index = ?";
            $params[] = $section;
            $types .= "s";
        }
        if (!empty($year)) {
            $where .= " AND s.year_level = ?";
            $params[] = $year;
            $types .= "s";
        }

        // If program is selected, group by section; else if department, group by program; else, group by department
        if (!empty($program)) {
            $sql = "
                SELECT 
                    sec.section_name AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                WHERE $where
                GROUP BY sec.section_name
            ";
            $groupedBy = 'section';
        } else if (!empty($department)) {
            $sql = "
                SELECT 
                    p.program_name AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                WHERE $where
                GROUP BY p.program_name
            ";
            $groupedBy = 'program';
        } else {
            $sql = "
                SELECT 
                    d.dept_title AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                WHERE $where
                GROUP BY d.dept_title
            ";
            $groupedBy = 'department';
        }

        $stmt = $conn->prepare($sql);
        $stmt->bind_param($types, ...$params);
        $stmt->execute();
        $result = $stmt->get_result();
        
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        $stmt->close();
    }
}

$labels = [];
$values = [];

foreach ($data as $item) {
    $labels[] = $item['label'];
    $values[] = $item['count'];
}

if (!isset($form_index)) {
    echo json_encode(['error' => 'Form index not found']);
    exit;
}

if (!$data) {
    echo json_encode(['error' => 'No data found']);
    exit;
}

echo json_encode([
    'labels' => $labels,
    'values' => $values,
    'groupedBy' => $groupedBy
]);