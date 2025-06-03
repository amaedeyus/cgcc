<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();  // Add this at the very top
require "../../backend/connect.php";  // include the database connection

$counselor_index = $_SESSION['counselor_index'] ?? null;
$student = [];

// 1) Fetch the counselor's data, including an image_path column
if ($counselor_index) {
    $stmt = $conn->prepare("
        SELECT 
            c.*,
            c.image_path   AS counselor_image_path
        FROM counselors c
        LEFT JOIN users     u ON c.user_index = u.user_index
        WHERE c.counselor_index = ?
    ");
    $stmt->bind_param("i", $counselor_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $counselor = $result->fetch_assoc();
    $stmt->close();
}

$fullName  = $_SESSION['full_name'] ?? 'Guest';
// If the counselor row didn't exist or no image_path, fall back to a default:
$imagePath = $counselor['counselor_image_path'] ?? 'assets/default-avatar.png';
$displayName = $fullName;
if (!empty($counselor['credentials'])) {
    $displayName .= ', ' . $counselor['credentials'];
}
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/record.css?v=<?= time() ?>">
    <link rel="icon" type="image/png" href="../Media/cgcc2.png" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
    <title>Report Summary</title>
</head>

<body>
    <header>
        <div class="logo">
            <img src="../Media/cgcc.png" alt="cgcc-logo" class="logo-img">
            College Guidance and Counseling Center
        </div>
    </header>

    <div class="grid-body">
        <div class="left-bg"></div>

        <div class="page-left">
            <div class="profile">
                <div class="profile-picture">
                    <img
                        src="<?= htmlspecialchars($imagePath) ?>"
                        alt="Profile Picture">
                </div>
                <span id="user-name"><?= htmlspecialchars($displayName) ?></span>
                <div class="edit">
                    <a href="counselor-profile-edit.html">✎Edit Profile</a>
                </div>
            </div>
            <div class="sidebar-nav">
                <a href="first-year.php" >➤ First Year</a>
                <a href="second-year.php">➤ Second Year</a>
                <a href="third-year.php">➤ Third Year</a>
                <a href="fourth-year.php">➤ Fourth Year</a>
                <a href="reports.php" class="active">➤ Reports</a>
            </div>

            <div class="logout-wrapper">
                <form method="POST" action="../../backend/logout.php">
                    <button type="submit" class="logout-btn">Log Out</button>
                </form>
            </div>

        </div>

        <div class="page-right">
            <div class="table-container">
                <h2>Report Summary</h2>
                <p>Forms Response</p>

                <div class="top-container">

                    <div class="filters">
                        <select name="forms" id="forms" onchange="updateFilters()">
                            <option value="">Select Forms</option>
                            <?php
                            $currentForms = $_GET['forms'] ?? '';
                            $sql = "SELECT form_index, form_name FROM forms";
                            $result = $conn->query($sql);
                            while ($row = $result->fetch_assoc()) {
                                $selected = ($row['form_name'] === $currentForms) ? 'selected' : '';
                                echo '<option value="' . htmlspecialchars($row['form_name']) . '" ' . $selected . '>' . htmlspecialchars($row['form_name']) . '</option>';
                            }
                            ?>
                        </select>

                        <select name="year" id="year" onchange="updateFilters()">
                            <option value="">Select Year</option>
                            <?php
                            $currentYear = $_GET['year'] ?? '';
                            for ($i = 1; $i <= 4; $i++) {
                                $selected = ($i == $currentYear) ? 'selected' : '';
                                echo "<option value=\"$i\" $selected>Year $i</option>";
                            }
                            ?>
                        </select>

                        <select name="department" id="department" onchange="updateFilters()">
                            <option value="">Select Department</option>
                            <?php
                            $currentDept = $_GET['department'] ?? '';
                            $sql = "SELECT dept_code, dept_title FROM departments";
                            $result = $conn->query($sql);
                            while ($row = $result->fetch_assoc()) {
                                $selected = ($row['dept_code'] === $currentDept) ? 'selected' : '';
                                echo '<option value="' . htmlspecialchars($row['dept_code']) . '" ' . $selected . '>' . htmlspecialchars($row['dept_title']) . '</option>';
                            }
                            ?>
                        </select>

                        <select name="program" id="program" onchange="updateFilters()" disabled>
                            <option value="">Select a department first</option>
                        </select>

                        <select name="section" id="section" onchange="updateFilters()" disabled>
                            <option value="">-- Select Section --</option>
                        </select>
                    </div>
                </div>

                    <?php
                    $totalResponses = 0;
                    if (!empty($_GET['forms'])) {
                        $formName = $_GET['forms'];
                        $year = $_GET['year'] ?? '';
                        $department = $_GET['department'] ?? '';
                        $program = $_GET['program'] ?? '';
                        $section = $_GET['section'] ?? '';

                        // Fetch the corresponding form_index from the 'forms' table
                        $stmt = $conn->prepare("SELECT form_index FROM forms WHERE form_name = ?");
                        $stmt->bind_param("s", $formName);
                        $stmt->execute();
                        $result = $stmt->get_result();
                        $row = $result->fetch_assoc();
                        $formIndex = $row['form_index'] ?? null;

                        if ($formIndex) {
                            $where = "r.form_index = ?";
                            $params = [$formIndex];
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

                            // Simple count query (NO GROUP BY)
                            $sql = "
                                SELECT COUNT(*) AS total
                                FROM responses r
                                LEFT JOIN students s ON r.student_index = s.student_index
                                LEFT JOIN sections sec ON s.section_index = sec.section_index
                                LEFT JOIN programs p ON sec.program_index = p.program_index
                                LEFT JOIN departments d ON p.dept_index = d.dept_index
                                WHERE $where
                            ";
                            $stmt = $conn->prepare($sql);
                            $stmt->bind_param($types, ...$params);
                            $stmt->execute();
                            $result = $stmt->get_result();
                            $row = $result->fetch_assoc();
                            $totalResponses = (isset($row['total']) ? $row['total'] : 0);
                            $stmt->close();
                        }
                    }
                    ?>
                    <?php if ($totalResponses > 0): ?>
                        <canvas id="responseChart" width="400" height="400"></canvas>
                        <p>Total Responses for "<strong><?= htmlspecialchars($_GET['forms'] ?? '') ?></strong>": <strong><?= $totalResponses ?></strong></p>
                    <?php elseif (!empty($_GET['forms'])): ?>
                        <p>No responses found for "<strong><?= htmlspecialchars($_GET['forms'] ?? '') ?></strong>".</p>
                    <?php else: ?>
                        <p>Select a form to view response statistics.</p>
                    <?php endif; ?>
            </div>
        </div>

    </div>
</body>

<script>

    function loadPrograms(deptCode) {
        const programSelect = document.getElementById("program");
        const sectionSelect = document.getElementById("section");

        programSelect.innerHTML = '<option value="">Select a department first</option>';
        sectionSelect.innerHTML = '<option value="">-- Select Section --</option>';

        programSelect.disabled = true;
        sectionSelect.disabled = true;

        if (!deptCode) return;

        const xhr = new XMLHttpRequest();
        xhr.open("GET", "get_programs.php?dept_code=" + deptCode, true);
        xhr.onload = function() {
            if (this.status === 200) {
                programSelect.innerHTML = this.responseText;
                programSelect.disabled = false;
            }
        };
        xhr.send();
    }

    function getYearLevelFromURL() {
        const year = document.getElementById('year').value;
        return year ? parseInt(year) : 1;
    }

    document.getElementById('department').addEventListener('change', function() {
        const deptCode = this.value;
        loadPrograms(deptCode);
    });

    document.getElementById('program').addEventListener('change', function() {
        const programCode = this.value;
        const sectionSelect = document.getElementById('section');

        if (!programCode) {
            sectionSelect.innerHTML = '<option value="">Select Section</option>';
            sectionSelect.disabled = true;
            return;
        }

        const yearLevel = getYearLevelFromURL();

        fetch(`get_sections.php?program_code=${programCode}&year_level=${yearLevel}`)
            .then(response => response.json())
            .then(data => {
                sectionSelect.innerHTML = '<option value="">Select Section</option>';
                data.forEach(section => {
                    sectionSelect.innerHTML += `<option value="${section.section_index}">${section.section_name}</option>`;
                });
                sectionSelect.disabled = false;
            })
            .catch(error => {
                console.error('Error fetching sections:', error);
                sectionSelect.disabled = true;
            });
    });

    function updateFilters() {
        const forms = document.getElementById("forms").value;
        const dept = document.getElementById("department").value;
        const prog = document.getElementById("program").value;
        const sec = document.getElementById("section").value;
        const year = document.getElementById("year").value;

        const url = new URL(window.location.href);
        url.searchParams.set('forms', forms);
        url.searchParams.set('department', dept);
        url.searchParams.set('program', prog);
        url.searchParams.set('section', sec);
        url.searchParams.set('year', year);
        url.searchParams.set('page', 1);

        window.location.href = url;
    }

    document.addEventListener("DOMContentLoaded", function() {
        const deptSelect = document.getElementById("department");
        const progSelect = document.getElementById("program");
        const secSelect = document.getElementById("section");
        const yearSelect = document.getElementById("year");

        const selectedDept = deptSelect.value;
        const selectedProg = "<?php echo isset($_GET['program']) ? htmlspecialchars($_GET['program']) : ''; ?>";
        const selectedSec = "<?php echo isset($_GET['section']) ? (int)$_GET['section'] : ''; ?>";
        const selectedYear = "<?php echo isset($_GET['year']) ? (int)$_GET['year'] : ''; ?>";

        if (selectedDept) {
            loadPrograms(selectedDept);

            const interval = setInterval(() => {
                if (!progSelect.disabled) {
                    clearInterval(interval);
                    if (selectedProg) {
                        progSelect.value = selectedProg;

                        const yearLevel = selectedYear || getYearLevelFromURL();

                        fetch(`get_sections.php?program_code=${selectedProg}&year_level=${yearLevel}`)
                            .then(response => response.json())
                            .then(data => {
                                secSelect.innerHTML = '<option value="">-- Select Section --</option>';
                                data.forEach(section => {
                                    secSelect.innerHTML += `<option value="${section.section_index}">${section.section_name}</option>`;
                                });
                                secSelect.disabled = false;

                                if (selectedSec) {
                                    secSelect.value = selectedSec;
                                }
                            })
                            .catch(error => {
                                console.error('Error fetching sections:', error);
                                secSelect.disabled = true;
                            });
                    }
                }
            }, 100);
        }
    });

    document.addEventListener("DOMContentLoaded", function () {
        const formSelected = "<?= htmlspecialchars($_GET['forms'] ?? '') ?>";
        const deptSelected = "<?= htmlspecialchars($_GET['department'] ?? '') ?>";
        const progSelected = "<?= htmlspecialchars($_GET['program'] ?? '') ?>";
        const secSelected = "<?= htmlspecialchars($_GET['section'] ?? '') ?>";
        const yearSelected = "<?= htmlspecialchars($_GET['year'] ?? '') ?>";

        if (!formSelected) return;

        const params = new URLSearchParams({
            form_name: formSelected,
            department: deptSelected,
            program: progSelected,
            section: secSelected,
            year: yearSelected
        });

        fetch(`get_chart_data.php?${params.toString()}`)
            .then(response => response.json())
            .then(data => {
                const canvas = document.getElementById('responseChart');
                if (!canvas) return; // No chart to draw on
                const ctx = canvas.getContext('2d');
                if (data.labels && data.values) {
                    let chartTitle = 'Response Distribution by Department';
                    if (data.groupedBy === 'program') {
                        chartTitle = 'Response Distribution by Program';
                    } else if (data.groupedBy === 'section') {
                        chartTitle = 'Response Distribution by Section';
                    } else if (data.groupedBy === 'year') {
                        chartTitle = 'Response Distribution by Year';
                    }
                    new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                label: chartTitle,
                                data: data.values,
                                backgroundColor: [
                                    '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'
                                ],
                                hoverOffset: 10
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'right',
                                },
                                title: {
                                    display: true,
                                    text: chartTitle
                                }
                            }
                        }
                    });
                } else {
                    console.error('Invalid data format');
                }
            })
            .catch(error => console.error('Error fetching chart data:', error));
    });
</script>


</html>