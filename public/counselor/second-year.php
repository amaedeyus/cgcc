<?php require("../../backend/connect2.php"); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/record.css?v=<?= time() ?>">
    <title>Student Records</title>
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
        <div class="profile-picture"></div>
            <span id="user-name">Counselor</span> <!-- papalitan ng id ni user -->
    </div>
        <div class="sidebar-nav">
            <a href="first-year.php">➤ First Year</a>
            <a href="second-year.php" class="active">➤ Second Year</a>
            <a href="third-year.php">➤ Third Year</a>
            <a href="fourth-year.php">➤ Fourth Year</a>
        </div>

        <div class="logout-wrapper">
            <form method="POST" action="../backend/logout.php">
                <button type="submit" class="logout-btn">Log Out</button>
            </form>
        </div>

</div>

<div class="page-right">
    <div class="table-container">
        <h2>Student Management</h2>
        <p>View Student Records</p>

    <div class="top-container">

        <div class="filters">
            <select name="department" id="department" onchange="updateFilters()">
                <option value="">Select Department</option>
                <?php
                $currentDept = $_GET['department'] ?? '';
                $sql = "SELECT dept_code, dept_title FROM departments";
                $result = $conn->query($sql);
                while ($row = $result->fetch_assoc()) {
                    $selected = ($row['dept_code'] === $currentDept) ? 'selected' : '';
                    echo '<option value="' . htmlspecialchars($row['dept_code']) . '" ' . $selected . '>' . htmlspecialchars($row['dept_code']) . '</option>';
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

    <div class="search-box">
        <form method="GET" id="searchForm">
            <input type="text" name="search" placeholder="Search student..." value="<?= isset($_GET['search']) ? htmlspecialchars($_GET['search']) : '' ?>">
            <input type="hidden" name="department" value="<?= htmlspecialchars($_GET['department'] ?? '') ?>">
            <input type="hidden" name="program" value="<?= htmlspecialchars($_GET['program'] ?? '') ?>">
            <input type="hidden" name="section" value="<?= htmlspecialchars($_GET['section'] ?? '') ?>">
            <button type="submit" class="search-btn">🔍</button>
        </form>
    </div>

    </div>

    <table>
        <thead>
            <tr>
            <th>ID</th>
            <th>Last Name</th>
            <th>First Name</th>
            <th>Year Level</th>
            <th>Section</th>
            <th>Actions</th>
            </tr>
        </thead>
    
    <tbody id="studentTableBody">

        <?php
        $page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
        $limit = 7;
        $offset = ($page - 1) * $limit;


        $where = "WHERE s.year_level = 2";

        $search = $conn->real_escape_string($_GET['search'] ?? '');

        if (!empty($search)) {
            $where .= " AND (
                s.student_number LIKE '%$search%' OR
                s.last_name LIKE '%$search%' OR
                s.first_name LIKE '%$search%' OR
                sec.section_name LIKE '%$search%'
            )";
        }


        if (!empty($_GET['department'])) {
            $dept = $conn->real_escape_string($_GET['department']);
            $where .= " AND d.dept_code = '$dept'";
        }

        if (!empty($_GET['program'])) {
            $prog = $conn->real_escape_string($_GET['program']);
            $where .= " AND p.program_code = '$prog'";
        }

        if (!empty($_GET['section'])) {
            $sec = (int) $_GET['section'];
            $where .= " AND s.section_index = $sec";
        }


        $countSql = "
        SELECT COUNT(*) as total
        FROM students s
        JOIN sections sec ON s.section_index = sec.section_index
        JOIN programs p ON sec.program_index = p.program_index
        JOIN departments d ON p.dept_index = d.dept_index
        $where
        ";
        $countResult = $conn->query($countSql);
        $totalStudents = 0;
        if ($countResult) {
            $row = $countResult->fetch_assoc();
            $totalStudents = (int)$row['total'];
        }

        $totalPages = ceil($totalStudents / $limit);


        $sql = "
        SELECT s.*, sec.section_name
        FROM students s
        JOIN sections sec ON s.section_index = sec.section_index
        JOIN programs p ON sec.program_index = p.program_index
        JOIN departments d ON p.dept_index = d.dept_index
        $where
        ORDER BY s.last_name
        LIMIT $limit OFFSET $offset
        ";

        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['student_number'] . "</td>";
                echo "<td>" . $row['last_name'] . "</td>"; 
                echo "<td>" . $row['first_name'] . "</td>";
                echo "<td>" . $row['year_level'] . "</td>";
                echo "<td>" . $row['section_name'] . "</td>";
                echo "<td class='actions'><a href='view_student.php?id=" . $row['student_index'] . "'>View</a></td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='6' style='text-align: center; color: #bdc3c7;'>No records found</td></tr>";

        }
        ?>

    </tbody>

    <tfoot>
        <tr>
            <td colspan="6" style="text-align: center;">
                <div class="pagination">
                    <?php if ($page > 1): ?>
                        <a href="?page=<?php echo $page - 1; ?>">Previous</a>
                    <?php else: ?>
                        <span class="disabled">Previous</span>
                    <?php endif; ?> 

                    <span>Page <?php echo $page; ?> of <?php echo $totalPages; ?></span>

                    <?php if ($page < $totalPages): ?>
                        <a href="?page=<?php echo $page + 1; ?>">Next</a>
                    <?php else: ?>
                        <span class="disabled">Next</span>
                    <?php endif; ?>
                </div>
            </td>
        </tr>
    </tfoot>

    </table>

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
    xhr.onload = function () {
        if (this.status === 200) {
            programSelect.innerHTML = this.responseText;
            programSelect.disabled = false;
        }
    };
    xhr.send();
}

function getYearLevelFromURL() {
    const pageUrl = window.location.href;

    if (pageUrl.includes("second-year")) return 2;
    if (pageUrl.includes("third-year")) return 3;
    if (pageUrl.includes("fourth-year")) return 4;
    return 1;
}

document.getElementById('program').addEventListener('change', function () {
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
    const dept = document.getElementById("department").value;
    const prog = document.getElementById("program").value;
    const sec = document.getElementById("section").value;

    const url = new URL(window.location.href);
    url.searchParams.set('department', dept);
    url.searchParams.set('program', prog);
    url.searchParams.set('section', sec);
    url.searchParams.set('page', 1);

    window.location.href = url;
}

document.addEventListener("DOMContentLoaded", function () {
    const deptSelect = document.getElementById("department");
    const progSelect = document.getElementById("program");
    const secSelect = document.getElementById("section");

    const selectedDept = deptSelect.value;
    const selectedProg = "<?php echo isset($_GET['program']) ? htmlspecialchars($_GET['program']) : ''; ?>";
    const selectedSec = "<?php echo isset($_GET['section']) ? (int)$_GET['section'] : ''; ?>";

    if (selectedDept) {
        loadPrograms(selectedDept);

        const interval = setInterval(() => {
            if (!progSelect.disabled) {
                clearInterval(interval);
                if (selectedProg) {
                    progSelect.value = selectedProg;

                    const yearLevel = getYearLevelFromURL();

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
</script>

</html>