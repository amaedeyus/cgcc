    <?php
    // view_response_mapped.php
    header("Content-Type: application/json");
    require_once '../connect.php';

    // Enable error reporting
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    // Check authorization
    session_start();
    if (!isset($_SESSION['user_index'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Unauthorized']);
        exit;
    }

    // Get user type and index
    $userIndex = $_SESSION['user_index'];
    $userType = $_SESSION['user_type'];

    // Get response ID from request
    $responseId = isset($_GET['response_id']) ? (int)$_GET['response_id'] : 0;
    if ($responseId <= 0) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid response ID']);
        exit;
    }

    try {
        // 1. Get the response with student info and snapshot
        $stmt = $conn->prepare("
            SELECT r.*, s.snapshot_data, f.form_name, 
                st.student_number, st.last_name, st.first_name,
                sec.section_name, p.program_name, d.dept_title
            FROM responses r
            JOIN form_snapshots s ON r.snapshot_index = s.snapshot_index
            JOIN forms f ON r.form_index = f.form_index
            JOIN students st ON r.student_index = st.student_index
            LEFT JOIN sections sec ON st.form_section_index = sec.form_section_index
            LEFT JOIN programs p ON sec.program_index = p.program_index
            LEFT JOIN departments d ON p.dept_index = d.dept_index
            WHERE r.response_index = ?
        ");
        $stmt->bind_param("i", $responseId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows === 0) {
            http_response_code(404);
            echo json_encode(['error' => 'Response not found']);
            exit;
        }
        
        $responseData = $result->fetch_assoc();
        $snapshotData = json_decode($responseData['snapshot_data'], true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Failed to decode snapshot data: " . json_last_error_msg());
        }
        
        // Helper function to find choice text by ID in options array
        function findChoiceText($choices, $choiceId) {
            if (!is_array($choices)) return null;
            foreach ($choices as $choice) {
                if (isset($choice['choice_index']) && $choice['choice_index'] == $choiceId) {
                    return $choice['choice_text'];
                }
            }
            return null;
        }
        
        // Helper function to find subquestion text by ID in rows array
        function findSubQuestion($rows, $subQuestionId) {
            if (!is_array($rows)) return null;
            foreach ($rows as $row) {
                if (isset($row['sub_question_index']) && $row['sub_question_index'] == $subQuestionId) {
                    return $row['sub_question_text'];
                }
            }
            return null;
        }
        
        // 2. Get all answers for this response in one query (more efficient)
        $answers = [];
        $stmtAnswers = $conn->prepare("
            SELECT a.*, c.choice_text
            FROM answers a
            LEFT JOIN choices c ON a.choice_index = c.choice_index
            WHERE a.response_index = ?

        ");
        $stmtAnswers->bind_param("i", $responseId);
        $stmtAnswers->execute();
        $answerResult = $stmtAnswers->get_result();
        while ($answer = $answerResult->fetch_assoc()) {
            $answers[] = $answer;
        }
        $stmtAnswers->close();

        // 3. Get all grid answers for this response in one query
        $gridAnswers = [];
        $stmtGrid = $conn->prepare("
            SELECT g.*, c.choice_text, sq.sub_question_text
            FROM grid_answers g
            LEFT JOIN choices c ON g.choice_index = c.choice_index
            LEFT JOIN sub_questions sq ON g.sub_question_index = sq.sub_question_index
            WHERE g.response_index = ?
        ");
        $stmtGrid->bind_param("i", $responseId);
        $stmtGrid->execute();
        $gridResult = $stmtGrid->get_result();
        while ($gridAnswer = $gridResult->fetch_assoc()) {
            $gridAnswers[] = $gridAnswer;
        }
        $stmtGrid->close();
        
        
        // 4. Reconstruct the form with responses by mapping to snapshot
        $formWithResponses = [
            'form_name' => $responseData['form_name'],
            'student' => [
                'student_number' => $responseData['student_number'],
                'name' => $responseData['first_name'] . ' ' . $responseData['last_name'],
                'section' => $responseData['section_name'],
                'program' => $responseData['program_name'],
                'department' => $responseData['dept_title'],
                'submitted_at' => $responseData['created_at']
            ],
            'sections' => []
        ];
        
        foreach ($snapshotData['sections'] as $section) {
            $sectionWithResponses = [
                'title' => $section['title'],
                'description' => $section['description'],
                'behavior' => $section['behavior'] ?? 'same-page',
                'questions' => []
            ];
            
            foreach ($section['questions'] as $question) {
                $questionId = $question['id'];
                $questionType = $question['type'];
                
                $questionWithResponse = [
                    'id' => $questionId,
                    'question' => $question['question'],
                    'type' => $questionType,
                    'required' => $question['required'] ?? false,
                    'response' => null
                ];
                
                // Handle different question types
                if ($questionType === 'grid') {
                    // Filter grid answers for this question
                    $filteredGridAnswers = array_filter($gridAnswers, function($ga) use ($questionId) {
                        return $ga['main_question_index'] == $questionId;
                    });
                    
                    $gridResponse = [];
                    foreach ($filteredGridAnswers as $gridAnswer) {
                        $subQuestionText = findSubQuestion($question['rows'], $gridAnswer['sub_question_index']);
                        if ($subQuestionText === null) {
                            $subQuestionText = $gridAnswer['sub_question_text'] ?? 'Unknown row';
                        }
                        
                        $choiceText = $gridAnswer['choice_text'] ?? 'Unknown choice';
                        $gridResponse[] = [
                            'row' => $subQuestionText,
                            'choice' => $choiceText
                        ];
                    }
                    
                    if (!empty($gridResponse)) {
                        $questionWithResponse['response'] = $gridResponse;
                    }
                    
                } elseif ($questionType === 'checkbox') {
                    // Filter answers for this checkbox question
                    $filteredAnswers = array_filter($answers, function($a) use ($questionId) {
                        return $a['main_question_index'] == $questionId;
                    });
                    
                    $choices = [];
                    foreach ($filteredAnswers as $answer) {
                        if ($answer['choice_index']) {
                            $choiceText = findChoiceText($question['options'], $answer['choice_index']);
                            if ($choiceText === null) {
                                $choiceText = $answer['choice_text'] ?? 'Unknown choice';
                            }
                            $choices[] = $choiceText;
                        } elseif ($answer['text_answer']) {
                            $choices[] = 'Other: ' . $answer['text_answer'];
                        }
                    }
                    
                    if (!empty($choices)) {
                        $questionWithResponse['response'] = $choices;
                    }
                    
                } elseif ($questionType === 'multiple' || $questionType === 'dropdown') {
                    // Find first answer for this question
                    foreach ($answers as $answer) {
                        if ($answer['main_question_index'] == $questionId) {
                            if ($answer['choice_index']) {
                                $choiceText = findChoiceText($question['options'], $answer['choice_index']);
                                if ($choiceText === null) {
                                    $choiceText = $answer['choice_text'] ?? 'Unknown choice';
                                }
                                $questionWithResponse['response'] = $choiceText;
                            } elseif ($answer['text_answer']) {
                                $questionWithResponse['response'] = 'Other: ' . $answer['text_answer'];
                            }
                            break;
                        }
                    }
                    
                } else {
                    // Text, paragraph, date, etc. — get first answer text
                    foreach ($answers as $answer) {
                        if ($answer['main_question_index'] == $questionId && $answer['text_answer']) {
                            $questionWithResponse['response'] = $answer['text_answer'];
                            break;
                        }
                    }
                }
                
                $sectionWithResponses['questions'][] = $questionWithResponse;
            }
            
            $formWithResponses['sections'][] = $sectionWithResponses;
        }
        
        // Return the complete response data
        echo json_encode([
            'success' => true,
            'data' => $formWithResponses
        ]);
        
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode([
            'error' => 'Failed to retrieve response data',
            'message' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ]);
    }