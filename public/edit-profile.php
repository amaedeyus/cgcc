<?php
session_start();
require "../backend/connect.php";  // Your DB connection

if (!isset($_SESSION['student_index'])) {
    header("Location: login.php");
    exit;
}

$student_index = $_SESSION['student_index'];
$student = [];

// Fetch student info first (without program_index)
if ($student_index) {
    $stmt = $conn->prepare("
        SELECT s.*, u.email
        FROM students s
        LEFT JOIN users u ON s.user_index = u.user_index
        WHERE s.student_index = ?
    ");
    $stmt->bind_param("i", $student_index);
    $stmt->execute();
    $result = $stmt->get_result();
    $student = $result->fetch_assoc();
}

$selected_year_level = $_GET['year_level'] ?? $student['year_level'] ?? 1;

// Now get program_index and year_level from sections table using student's section_index
$program_index = $student['program_index'] ?? null;
$year_level = $student['year_level'] ?? null;

if (!empty($student['section_index'])) {
    $section_index = $student['section_index'];

    $section_stmt = $conn->prepare("
        SELECT program_index, year_level 
        FROM sections 
        WHERE section_index = ?
    ");
    $section_stmt->bind_param("i", $section_index);
    $section_stmt->execute();
    $section_result = $section_stmt->get_result();
    $section_data = $section_result->fetch_assoc();

    if ($section_data) {
        $program_index = $section_data['program_index'];
        $year_level = $section_data['year_level'];
    }
}

$dept_index = null;

if (!empty($program_index)) {
    $dept_stmt = $conn->prepare("SELECT dept_index FROM programs WHERE program_index = ?");
    $dept_stmt->bind_param("i", $program_index);
    $dept_stmt->execute();
    $dept_result = $dept_stmt->get_result();
    $dept_data = $dept_result->fetch_assoc();

    if ($dept_data) {
        $dept_index = $dept_data['dept_index'];
    }
}


$departments = [];

$dept_stmt = $conn->prepare("SELECT dept_index, dept_code FROM departments");
$dept_stmt->execute();
$dept_result = $dept_stmt->get_result();

while ($row = $dept_result->fetch_assoc()) {
    $departments[] = $row;
}


$programs = [];

$program_stmt = $conn->prepare("SELECT program_index, program_name FROM programs");
$program_stmt->execute();
$program_result = $program_stmt->get_result();

while ($row = $program_result->fetch_assoc()) {
    $programs[] = $row;
}


// Fetch sections based on program_index and year_level for the dropdown
$sections = [];

if ($program_index !== null && $selected_year_level !== null) {
    $section_stmt = $conn->prepare("
        SELECT section_index, section_name 
        FROM sections 
        WHERE program_index = ? AND year_level = ?
    ");
    $section_stmt->bind_param("ii", $program_index, $selected_year_level);
    $section_stmt->execute();
    $section_result = $section_stmt->get_result();

    while ($row = $section_result->fetch_assoc()) {
        $sections[] = $row;
    }
}

$guardian = [
    'full_name' => '',
    'contact_number' => ''
];

if (!empty($student['guardian_index'])) {
    $guardian_stmt = $conn->prepare("SELECT full_name, contact_number FROM guardians WHERE guardian_index = ?");
    $guardian_stmt->bind_param("i", $student['guardian_index']);
    $guardian_stmt->execute();
    $guardian_result = $guardian_stmt->get_result();
    $guardian = $guardian_result->fetch_assoc() ?: $guardian;
}





?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" type="image/png" href="cgcc2.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="css/base.css?v=<?= time() ?>" />
    <link rel="stylesheet" href="css/form.css?v=<?= time() ?>" />
    <title>CGCC - Edit Profile</title>
    <style>
        .profile-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 20px auto;
            width: fit-content;
            text-align: center;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ddd;
            background-color: #f5f5f5;
            margin-bottom: 10px;
        }

        .upload-btn {
            padding: 8px 15px;
            background-color: rgb(79, 189, 156);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            width: 150px;
            text-align: center;
        }

        .upload-btn:hover {
            background: rgb(36, 154, 118);
        }

        #profile-upload {
            display: none;
        }
        .profile-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<header>
    <div class="logo">
        <img src="Media/cgcc.png" alt="cgcc-logo" class="logo-img" />
        College Guidance and Counseling Center
    </div>
    <nav class="navigation">
        <a href="../main.html">Home</a>
        <a href="#">Contact</a>
        <a href="#">About Mental Health</a>
        <a href="#">FAQ</a>
    </nav>
</header>

<h1 class="form-title">Edit Profile</h1>
<p class="form-subtitle">Update your profile information</p>

<section class="form-container">
    <form action="../backend/upload-profile.php" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="student_index" value="<?=htmlspecialchars($student['student_index'] ?? '') ?>" />
        <input type="hidden" name="program_index" value="<?=htmlspecialchars($student['program_index'] ?? '') ?>" />
        <input type="hidden" name="dept_index_original" value="<?= htmlspecialchars($dept_index ?? '') ?>" />


        <div class="profile-section">
            <div class="profile-title">Profile Picture</div>
            <img src="<?= !empty($student['image_path']) ? htmlspecialchars($student['image_path']) : 'Media/user.jpg' ?>" 
            alt="Profile Picture" class="profile-picture" id="profile-picture" />
            <input type="file" id="profile-upload" name="profile_image" accept="image/*" />
            <button type="button" class="upload-btn" onclick="document.getElementById('profile-upload').click()">Upload Photo</button>
        </div>

        <label for="student-number">Student Number</label>
        <input readonly type="text" id="student-number" name="student_number" value="<?= htmlspecialchars($student['student_number'] ?? '') ?>" placeholder="Ex. 2023-12345" />

        <label for="first-name">First Name</label>
        <input readonly type="text" id="first-name" name="first_name" value="<?= htmlspecialchars($student['first_name'] ?? '') ?>" placeholder="Ex. John" />

        <label for="last-name">Last Name</label>
        <input readonly type="text" id="last-name" name="last_name" value="<?= htmlspecialchars($student['last_name'] ?? '') ?>" placeholder="Ex. Dela Cerna" />

        <label for="email">Email</label>
        <input readonly type="text" id="email" name="email" value="<?= htmlspecialchars($student['email'] ?? '') ?>" placeholder="Ex. john@example.com" />

        <label for="contact-number">Contact Number</label>
        <input type="text" id="contact-number" name="contact_number" value="<?= htmlspecialchars($student['contact_number'] ?? '') ?>" placeholder="Ex. 09123456789" />

        <label for="guardian-full-name">Guardian</label>
        <input type="text" id="guardian-full-name" name="guardian_full_name" 
        value="<?= htmlspecialchars($guardian['full_name'] ?? '') ?>" placeholder="Guardian Full Name" />

        

        <label for="guardian-index">Guardian Contact No.</label>
        <input type="text" id="guardian-contact-number" name="guardian_contact_number" 
        value="<?= htmlspecialchars($guardian['contact_number'] ?? '') ?>" placeholder="Guardian Contact Number" />
        

        <label>Year Level</label>
        <div class="radio-group">
            
            <?php
for ($y = 1; $y <= 4; $y++) {
    $suffix = match ($y) {
        1 => 'st',
        2 => 'nd',
        3 => 'rd',
        default => 'th',
    };
    $checked = ($selected_year_level == $y) ? 'checked' : '';
    echo "<label>
            <input type='radio' name='year_level' value='$y' $checked> {$y}{$suffix} Year
        </label><br>";
}
?>


        </div>

        <label for="dept_index">Department</label>
<select id="dept_index" name="dept_index">
    <option value="">-- Select Department --</option>
    <?php foreach ($departments as $department): 
        $selected = ($dept_index ?? '') == $department['dept_index'] ? 'selected' : '';
    ?>
        <option value="<?= htmlspecialchars($department['dept_index']) ?>" <?= $selected ?>>
            <?= htmlspecialchars($department['dept_code']) ?>
        </option>
    <?php endforeach; ?>
</select>



        <label for="program_index">Program</label>
<select id="program_index" name="program_index">
    <option value="">-- Select Program --</option>
    <?php foreach ($programs as $program): 
        $selected = ($program_index == $program['program_index']) ? 'selected' : '';
    ?>
        <option value="<?= htmlspecialchars($program['program_index']) ?>" <?= $selected ?>>
            <?= htmlspecialchars($program['program_name']) ?>
        </option>
    <?php endforeach; ?>
</select>

        <label for="section-index">Section</label>
        <select id="section-index" name="section_index">
        <option value="">-- Select Section --</option>
            <?php foreach ($sections as $section): 
                $selected = ($student['section_index'] ?? '') == $section['section_index'] ? 'selected' : '';
            ?>
                <option value="<?= htmlspecialchars($section['section_index']) ?>" <?= $selected ?>>
                    <?= htmlspecialchars($section['section_name']) ?>
                </option>
            <?php endforeach; ?>
        </select>

        <div class="button-container">
            <button type="submit">Save Changes</button>
            <button type="button" onclick="window.location.href='main.php'">Back</button>
        </div>
    </form>
</section>

<script>
    // Preview image when uploaded
    // Update sections dropdown when year level changes
    document.querySelectorAll('input[name="year_level"]').forEach(radio => {
        radio.addEventListener('change', function() {
            const yearLevel = this.value;
            const programIndex = <?= json_encode($program_index) ?>;
            if (!programIndex) return;

            fetch(`student-section.php?program_index=${programIndex}&year_level=${yearLevel}`)
                .then(res => res.json())
                .then(data => {
                    const select = document.getElementById('section-index');
                    select.innerHTML = '<option value="">-- Select Section --</option>';
                    data.forEach(section => {
                        const option = document.createElement('option');
                        option.value = section.section_index;
                        option.textContent = section.section_name;
                        select.appendChild(option);
                    });
                })
                .catch(err => {
                    console.error('Error fetching sections:', err);
                });
        });
    });

    // Preview image when a new file is uploaded
    document.getElementById('profile-upload').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.getElementById('profile-picture').src = event.target.result;
            };
            reader.readAsDataURL(file);
        }
    });


document.getElementById('dept_index').addEventListener('change', function () {
    const deptIndex = this.value;
    const programSelect = document.getElementById('program_index');
    const sectionSelect = document.getElementById('section-index');

    // Clear programs and sections
    programSelect.innerHTML = '<option value="">-- Select Program --</option>';
    sectionSelect.innerHTML = '<option value="">-- Select Section --</option>'; // ✅ Reset Section

    // AJAX request to get programs for selected department
    const xhr = new XMLHttpRequest();
    xhr.open('GET', 'student-program.php?dept_index=' + deptIndex, true);
    xhr.onload = function () {
        if (xhr.status === 200) {
            const programs = JSON.parse(xhr.responseText);
            programSelect.innerHTML = '<option value="">-- Select Program --</option>';
            programs.forEach(function (program) {
                const option = document.createElement('option');
                option.value = program.program_index;
                option.text = program.program_name;
                programSelect.appendChild(option);
            });
        } else {
            programSelect.innerHTML = '<option value="">Error loading programs</option>';
        }
    };
    xhr.send();
});


    

    document.getElementById('program_index').addEventListener('change', function() {
    const programIndex = this.value;
    const yearLevel = document.querySelector('input[name="year_level"]:checked')?.value;

    if (!programIndex || !yearLevel) return;

    fetch(`student-section.php?program_index=${programIndex}&year_level=${yearLevel}`)
        .then(res => res.json())
        .then(data => {
            const select = document.getElementById('section-index');
            select.innerHTML = '<option value="">-- Select Section --</option>';
            data.forEach(section => {
                const option = document.createElement('option');
                option.value = section.section_index;
                option.textContent = section.section_name;
                select.appendChild(option);
            });
        })
        .catch(err => {
            console.error('Error fetching sections:', err);
        });
});

document.querySelector("form").addEventListener("submit", function (e) {
        // Get input values
        const contactNumber = document.getElementById("contact-number").value.trim();
        const guardianName = document.getElementById("guardian-full-name").value.trim();
        const guardianNumber = document.getElementById("guardian-contact-number").value.trim();
        const dept = document.getElementById("dept_index").value;
        const program = document.getElementById("program_index").value;
        const section = document.getElementById("section-index").value;
        const yearLevelChecked = document.querySelector('input[name="year_level"]:checked');

        // Check for empty fields
        if (!contactNumber || !guardianName || !guardianNumber || !dept || !program || !section || !yearLevelChecked) {
            alert("Please fill out all fields before saving changes.");
            e.preventDefault(); // Prevent form submission
            return;
        }

        // Validate contact numbers (should be exactly 11 digits and numeric)
        const contactRegex = /^\d{11}$/;
        if (!contactRegex.test(contactNumber)) {
            alert("Student contact number must be exactly 11 digits.");
            e.preventDefault();
            return;
        }

        if (!contactRegex.test(guardianNumber)) {
            alert("Guardian contact number must be exactly 11 digits.");
            e.preventDefault();
            return;
        }

        // Validate guardian full name (should not contain any digits)
        const nameRegex = /^[^\d]+$/;
        if (!nameRegex.test(guardianName)) {
            alert("Guardian name must not contain any numbers.");
            e.preventDefault();
            return;
        }
    });

</script>


</body>
</html>
