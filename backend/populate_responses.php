<?php
require_once 'connect.php';

// Set error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Academic year to populate
$academicYear = '2023-2024';

// Function to generate random text based on subtype
function generateRandomText($subtype) {
    switch ($subtype) {
        case 'email':
            return 'test' . rand(1, 999) . '@example.com';
        case 'phone':
            return '09' . str_pad(rand(1, 99999999), 9, '0', STR_PAD_LEFT);
        case 'number':
            return (string)rand(1, 100);
        case 'text':
        default:
            $words = ['good', 'excellent', 'satisfactory', 'needs improvement', 'very good'];
            return $words[array_rand($words)];
    }
}

try {
    // Start transaction
    $conn->begin_transaction();

    // Get all students with user_index = null
    $studentQuery = "SELECT s.student_index, s.section_index 
                    FROM students s 
                    WHERE s.user_index IS NULL";
    $studentResult = $conn->query($studentQuery);
    
    if (!$studentResult) {
        throw new Exception("Error fetching students: " . $conn->error);
    }

    // Get all active forms for the academic year
    $formQuery = "SELECT f.form_index, f.form_name 
                 FROM forms f 
                 WHERE f.is_active = 1 
                 AND f.academic_year = ?";
    $formStmt = $conn->prepare($formQuery);
    $formStmt->bind_param("s", $academicYear);
    $formStmt->execute();
    $formResult = $formStmt->get_result();

    // Get active snapshot for each form
    $snapshotQuery = "SELECT snapshot_index 
                     FROM form_snapshots 
                     WHERE form_index = ? 
                     AND is_active = 1 
                     ORDER BY created_at DESC 
                     LIMIT 1";
    $snapshotStmt = $conn->prepare($snapshotQuery);

    // Process each student
    while ($student = $studentResult->fetch_assoc()) {
        $studentIndex = $student['student_index'];
        
        // Process each form for this student
        $formResult->data_seek(0); // Reset form result pointer
        while ($form = $formResult->fetch_assoc()) {
            $formIndex = $form['form_index'];
            
            // Get active snapshot for this form
            $snapshotStmt->bind_param("i", $formIndex);
            $snapshotStmt->execute();
            $snapshotResult = $snapshotStmt->get_result();
            $snapshotIndex = $snapshotResult->fetch_assoc()['snapshot_index'];

            // Create response
            $responseQuery = "INSERT INTO responses 
                            (form_index, student_index, created_at, updated_at, 
                             snapshot_index, is_autosave, academic_year) 
                            VALUES (?, ?, NOW(), NOW(), ?, 0, ?)";
            $responseStmt = $conn->prepare($responseQuery);
            $responseStmt->bind_param("iiis", $formIndex, $studentIndex, $snapshotIndex, $academicYear);
            $responseStmt->execute();
            $responseIndex = $conn->insert_id;

            // Get all questions for this form
            $questionQuery = "SELECT mq.main_question_index, mq.type_index, mq.subtype, qt.type_name 
                            FROM main_questions mq 
                            JOIN question_types qt ON mq.type_index = qt.type_index 
                            WHERE mq.form_index = ?";
            $questionStmt = $conn->prepare($questionQuery);
            $questionStmt->bind_param("i", $formIndex);
            $questionStmt->execute();
            $questionResult = $questionStmt->get_result();

            // Process each question
            while ($question = $questionResult->fetch_assoc()) {
                $mainQuestionIndex = $question['main_question_index'];
                $typeName = $question['type_name'];
                $subtype = $question['subtype'];

                // Skip display type questions as they don't need answers
                if ($typeName === 'display') {
                    continue;
                }

                switch ($typeName) {
                    case 'grid':
                        // Handle grid questions
                        $subQuestionQuery = "SELECT sub_question_index 
                                           FROM sub_questions 
                                           WHERE main_question_index = ?";
                        $subQuestionStmt = $conn->prepare($subQuestionQuery);
                        $subQuestionStmt->bind_param("i", $mainQuestionIndex);
                        $subQuestionStmt->execute();
                        $subQuestionResult = $subQuestionStmt->get_result();

                        while ($subQuestion = $subQuestionResult->fetch_assoc()) {
                            // Get random choice for this grid cell
                            $choiceQuery = "SELECT choice_index 
                                          FROM choices 
                                          WHERE main_question_index = ? 
                                          ORDER BY RAND() 
                                          LIMIT 1";
                            $choiceStmt = $conn->prepare($choiceQuery);
                            $choiceStmt->bind_param("i", $mainQuestionIndex);
                            $choiceStmt->execute();
                            $choiceResult = $choiceStmt->get_result();
                            $choice = $choiceResult->fetch_assoc();

                            if ($choice) {
                                // Insert grid answer
                                $gridAnswerQuery = "INSERT INTO grid_answers 
                                                  (response_index, main_question_index, 
                                                   sub_question_index, choice_index) 
                                                  VALUES (?, ?, ?, ?)";
                                $gridAnswerStmt = $conn->prepare($gridAnswerQuery);
                                $gridAnswerStmt->bind_param("iiii", 
                                    $responseIndex, 
                                    $mainQuestionIndex, 
                                    $subQuestion['sub_question_index'], 
                                    $choice['choice_index']
                                );
                                $gridAnswerStmt->execute();
                            }
                        }
                        break;

                    case 'checkbox':
                        // For checkbox, select multiple random choices
                        $choiceQuery = "SELECT choice_index 
                                      FROM choices 
                                      WHERE main_question_index = ? 
                                      ORDER BY RAND() 
                                      LIMIT " . rand(1, 3); // Select 1-3 random choices
                        $choiceStmt = $conn->prepare($choiceQuery);
                        $choiceStmt->bind_param("i", $mainQuestionIndex);
                        $choiceStmt->execute();
                        $choiceResult = $choiceStmt->get_result();

                        while ($choice = $choiceResult->fetch_assoc()) {
                            $answerQuery = "INSERT INTO answers 
                                          (response_index, main_question_index, 
                                           choice_index, text_answer) 
                                          VALUES (?, ?, ?, NULL)";
                            $answerStmt = $conn->prepare($answerQuery);
                            $answerStmt->bind_param("iii", 
                                $responseIndex, 
                                $mainQuestionIndex, 
                                $choice['choice_index']
                            );
                            $answerStmt->execute();
                        }
                        break;

                    case 'multiple':
                    case 'dropdown':
                        // For multiple choice and dropdown, select one random choice
                        $choiceQuery = "SELECT choice_index 
                                      FROM choices 
                                      WHERE main_question_index = ? 
                                      ORDER BY RAND() 
                                      LIMIT 1";
                        $choiceStmt = $conn->prepare($choiceQuery);
                        $choiceStmt->bind_param("i", $mainQuestionIndex);
                        $choiceStmt->execute();
                        $choiceResult = $choiceStmt->get_result();
                        $choice = $choiceResult->fetch_assoc();

                        if ($choice) {
                            $answerQuery = "INSERT INTO answers 
                                          (response_index, main_question_index, 
                                           choice_index, text_answer) 
                                          VALUES (?, ?, ?, NULL)";
                            $answerStmt = $conn->prepare($answerQuery);
                            $answerStmt->bind_param("iii", 
                                $responseIndex, 
                                $mainQuestionIndex, 
                                $choice['choice_index']
                            );
                            $answerStmt->execute();
                        }
                        break;

                    case 'short':
                    case 'paragraph':
                    case 'date':
                        // For text input questions, generate appropriate text based on subtype
                        $textAnswer = '';
                        if ($typeName === 'date') {
                            // Generate a random date within the last year
                            $timestamp = time() - rand(0, 365 * 24 * 60 * 60);
                            $textAnswer = date('Y-m-d', $timestamp);
                        } else {
                            $textAnswer = generateRandomText($subtype);
                        }

                        $answerQuery = "INSERT INTO answers 
                                      (response_index, main_question_index, 
                                       choice_index, text_answer) 
                                      VALUES (?, ?, NULL, ?)";
                        $answerStmt = $conn->prepare($answerQuery);
                        $answerStmt->bind_param("iis", 
                            $responseIndex, 
                            $mainQuestionIndex, 
                            $textAnswer
                        );
                        $answerStmt->execute();
                        break;
                }
            }
        }
    }

    // Commit transaction
    $conn->commit();
    echo "Successfully populated responses for academic year $academicYear\n";

} catch (Exception $e) {
    // Rollback transaction on error
    $conn->rollback();
    echo "Error: " . $e->getMessage() . "\n";
}

// Close connection
$conn->close();
?> 