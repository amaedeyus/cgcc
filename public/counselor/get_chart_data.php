<?php
require "../../backend/connect.php";

// Get all filter parameters
$formName = $_GET['form_name'] ?? '';
$department = $_GET['department'] ?? '';
$program = $_GET['program'] ?? '';
$section = $_GET['section'] ?? '';
$year = $_GET['year'] ?? '';
$academic_year = $_GET['academic_year'] ?? '';

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
        // If section is selected, show responded vs not responded
        if (!empty($section)) {
            // Get total students in the section
            $sqlTotal = "SELECT COUNT(*) as total FROM students WHERE section_index = ?";
            $stmt = $conn->prepare($sqlTotal);
            $stmt->bind_param("i", $section);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $totalStudents = $row['total'] ?? 0;
            $stmt->close();

            // Get number of students who responded to the form in this section (with academic year filter if set)
            $sqlResponded = "
                SELECT COUNT(DISTINCT r.student_index) as responded
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN forms f ON r.form_index = f.form_index
                WHERE r.form_index = ? AND s.section_index = ?";
            $types = "ii";
            $params = [$form_index, $section];
            if (!empty($academic_year)) {
                $sqlResponded .= " AND r.academic_year = ? AND f.academic_year = ?";
                $types .= "ss";
                $params[] = $academic_year;
                $params[] = $academic_year;
            }
            $stmt = $conn->prepare($sqlResponded);
            $stmt->bind_param($types, ...$params);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $responded = $row['responded'] ?? 0;
            $stmt->close();

            $notResponded = max(0, $totalStudents - $responded);
            echo json_encode([
                'labels' => ['Responded', 'Not Responded'],
                'values' => [$responded, $notResponded],
                'groupedBy' => 'section_response'
            ]);
            exit;
        }
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
        if (!empty($academic_year)) {
            $where .= " AND r.academic_year = ? AND f.academic_year = ?";
            $params[] = $academic_year;
            $params[] = $academic_year;
            $types .= "ss";
        }

        if (!empty($program)) {
            // Group by section
            $sql = "
                SELECT 
                    sec.section_name AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                LEFT JOIN forms f ON r.form_index = f.form_index
                WHERE $where
                GROUP BY sec.section_name
            ";
            $groupedBy = 'section';
        } else if (!empty($department)) {
            // Group by program
            $sql = "
                SELECT 
                    p.program_name AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                LEFT JOIN forms f ON r.form_index = f.form_index
                WHERE $where
                GROUP BY p.program_name
            ";
            $groupedBy = 'program';
        } else if (!empty($year) && empty($department) && empty($program) && empty($section)) {
            // Group by department (filtered by year)
            $sql = "
                SELECT 
                    d.dept_title AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                LEFT JOIN forms f ON r.form_index = f.form_index
                WHERE $where
                GROUP BY d.dept_title
            ";
            $groupedBy = 'department';
        } else {
            // Only form is selected: group by year
            $sql = "
                SELECT 
                    s.year_level AS label,
                    COUNT(r.response_index) AS count
                FROM responses r
                LEFT JOIN students s ON r.student_index = s.student_index
                LEFT JOIN sections sec ON s.section_index = sec.section_index
                LEFT JOIN programs p ON sec.program_index = p.program_index
                LEFT JOIN departments d ON p.dept_index = d.dept_index
                LEFT JOIN forms f ON r.form_index = f.form_index
                WHERE $where
                GROUP BY s.year_level
            ";
            $groupedBy = 'year';
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
    if ($groupedBy === 'year') {
        $labels[] = "Year " . $item['label'];
    } else {
        $labels[] = $item['label'];
    }
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