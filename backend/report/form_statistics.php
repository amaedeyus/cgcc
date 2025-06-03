<?php
// Turn off error display
ini_set('display_errors', 0);
error_reporting(E_ALL);

// Set proper content type for JSON
header('Content-Type: application/json');

require_once '../connect.php';

// Function to handle errors and return JSON response
function handleError($message, $code = 500) {
    http_response_code($code);
    echo json_encode([
        'error' => true,
        'message' => $message
    ]);
    exit;
}

// Check if connection exists
if (!isset($conn)) {
    handleError('Database connection not available');
}

class FormStatistics {
    private $conn;
    private $filters;

    public function __construct($conn, $filters = []) {
        $this->conn = $conn;
        $this->filters = $this->resolveHierarchicalFilters($filters);
    }

    private function resolveHierarchicalFilters($filters) {
        // If section is provided, get its program and department
        if (!empty($filters['section_index'])) {
            $query = "SELECT s.section_index, s.program_index, p.dept_index, s.year_level 
                     FROM sections s
                     JOIN programs p ON s.program_index = p.program_index
                     WHERE s.section_index = ?";
            
            $stmt = $this->conn->prepare($query);
            $stmt->bind_param("i", $filters['section_index']);
            $stmt->execute();
            $result = $stmt->get_result();
            
            if ($row = $result->fetch_assoc()) {
                $filters['program_index'] = $row['program_index'];
                $filters['dept_index'] = $row['dept_index'];
                // If year level is not specified, use the section's year level
                if (empty($filters['year_level'])) {
                    $filters['year_level'] = $row['year_level'];
                }
            }
        }
        // If program is provided, get its department and verify year level
        else if (!empty($filters['program_index'])) {
            $query = "SELECT p.program_index, p.dept_index, 
                            CASE WHEN ? IS NOT NULL THEN 
                                (SELECT COUNT(*) FROM sections s 
                                 WHERE s.program_index = p.program_index 
                                 AND s.year_level = ?) > 0
                            ELSE 1 END as has_year_level
                     FROM programs p 
                     WHERE p.program_index = ?";
            
            $stmt = $this->conn->prepare($query);
            $yearLevel = !empty($filters['year_level']) ? $filters['year_level'] : null;
            $stmt->bind_param("iii", $yearLevel, $yearLevel, $filters['program_index']);
            $stmt->execute();
            $result = $stmt->get_result();
            
            if ($row = $result->fetch_assoc()) {
                $filters['dept_index'] = $row['dept_index'];
                // If the program doesn't have any sections with the specified year level,
                // clear the year level filter
                if ($row['has_year_level'] == 0) {
                    $filters['year_level'] = null;
                }
            }
        }

        return $filters;
    }

    private function buildFilterConditions() {
        $conditions = [];
        $params = [];
        $types = '';

        if (!empty($this->filters['form_index'])) {
            $conditions[] = "f.form_index = ?";
            $params[] = $this->filters['form_index'];
            $types .= 'i';
        }

        return [
            'conditions' => $conditions,
            'params' => $params,
            'types' => $types
        ];
    }

    public function getFormStatistics() {
        $statistics = [];
        $debug = ['errors' => [], 'queries' => []];

        // Add debug information about filters
        $debug['filters'] = $this->filters;

        // Build filter conditions
        $filterData = $this->buildFilterConditions();
        $filterConditions = !empty($filterData['conditions']) ? 
            implode(" AND ", $filterData['conditions']) : "f.is_active = '1'";

        // Get forms based on filters
        $formsQuery = "SELECT DISTINCT f.form_index, f.form_name 
                      FROM forms f 
                      WHERE $filterConditions";
        
        $stmt = $this->conn->prepare($formsQuery);
        if (!$stmt) {
            $debug['errors'][] = "Error preparing forms query: " . $this->conn->error;
            return ['statistics' => [], 'debug' => $debug];
        }

        if (!empty($filterData['params'])) {
            $stmt->bind_param($filterData['types'], ...$filterData['params']);
        }
        
        $stmt->execute();
        $formsResult = $stmt->get_result();

        if ($formsResult->num_rows === 0) {
            $debug['queries'][] = "No forms found matching the filters";
            return ['statistics' => [], 'debug' => $debug];
        }

        while ($form = $formsResult->fetch_assoc()) {
            $formStats = [
                'form_index' => $form['form_index'],
                'form_name' => $form['form_name'],
                'total_submissions' => 0,
                'questions' => []
            ];

            // Build student filter conditions
            $studentConditions = [];
            $studentParams = [];
            $studentTypes = '';

            // Add year level filter first
            if (!empty($this->filters['year_level'])) {
                $studentConditions[] = "s.year_level = ?";
                $studentParams[] = $this->filters['year_level'];
                $studentTypes .= 'i';
            }

            // Add department filter if provided
            if (!empty($this->filters['dept_index'])) {
                $studentConditions[] = "d.dept_index = ?";
                $studentParams[] = $this->filters['dept_index'];
                $studentTypes .= 'i';
            }

            // Add program filter if provided
            if (!empty($this->filters['program_index'])) {
                $studentConditions[] = "p.program_index = ?";
                $studentParams[] = $this->filters['program_index'];
                $studentTypes .= 'i';
            }

            // Add section filter if provided
            if (!empty($this->filters['section_index'])) {
                $studentConditions[] = "s.section_index = ?";
                $studentParams[] = $this->filters['section_index'];
                $studentTypes .= 'i';
            }

            if (!empty($this->filters['academic_year'])) {
                $studentConditions[] = "r.academic_year = ?";
                $studentParams[] = $this->filters['academic_year'];
                $studentTypes .= 's';
            }

            $studentFilterSQL = !empty($studentConditions) ? 
                "AND " . implode(" AND ", $studentConditions) : "";

            // Get total submissions for this form (only valid responses)
            $submissionsQuery = "SELECT COUNT(DISTINCT r.response_index) as total 
                               FROM responses r
                               JOIN students st ON r.student_index = st.student_index
                               JOIN sections s ON st.section_index = s.section_index
                               JOIN programs p ON s.program_index = p.program_index
                               JOIN departments d ON p.dept_index = d.dept_index
                               WHERE r.form_index = ? 
                               AND r.is_autosave = 0
                               $studentFilterSQL";

            $stmt = $this->conn->prepare($submissionsQuery);
            if (!$stmt) {
                $debug['errors'][] = "Error preparing submissions query: " . $this->conn->error;
                continue;
            }

            // Bind parameters for filters
            $params = [$form['form_index']];
            $types = 'i';
            if (!empty($studentParams)) {
                $params = array_merge($params, $studentParams);
                $types .= $studentTypes;
            }
            
            $stmt->bind_param($types, ...$params);
            $stmt->execute();
            $submissionsResult = $stmt->get_result();
            $formStats['total_submissions'] = $submissionsResult->fetch_assoc()['total'];

            // Get all questions for this form with their choices
            $questionsQuery = "SELECT 
                                mq.main_question_index,
                                mq.main_question_text,
                                qt.type_name,
                                COALESCE(fs.section_title, CONCAT('Section ', COALESCE(mq.form_section_index, 0))) as section_title,
                                COALESCE(fs.section_order, 9999) as section_order,
                                mq.form_section_index,
                                CASE 
                                    WHEN qt.type_name = 'checkbox' THEN NULL
                                    ELSE COUNT(DISTINCT a.answer_index)
                                END as total_answers,
                                CASE 
                                    WHEN qt.type_name = 'grid' THEN 
                                        (SELECT GROUP_CONCAT(DISTINCT CONCAT(sub_question_index, ':', sub_question_text) ORDER BY sub_question_index)
                                         FROM sub_questions 
                                         WHERE main_question_index = mq.main_question_index)
                                    ELSE NULL 
                                END as grid_rows,
                                qt.type_index
                            FROM main_questions mq
                            LEFT JOIN question_types qt ON mq.type_index = qt.type_index
                            LEFT JOIN form_sections fs ON mq.form_section_index = fs.form_section_index
                            LEFT JOIN answers a ON mq.main_question_index = a.main_question_index
                            LEFT JOIN responses r ON a.response_index = r.response_index
                            LEFT JOIN students st ON r.student_index = st.student_index
                            LEFT JOIN sections s ON st.section_index = s.section_index
                            LEFT JOIN programs p ON s.program_index = p.program_index
                            LEFT JOIN departments d ON p.dept_index = d.dept_index
                            WHERE mq.form_index = ?
                            AND mq.type_index IN (3, 4, 5, 6)
                            GROUP BY mq.main_question_index
                            ORDER BY section_order, mq.main_question_index";

            $stmt = $this->conn->prepare($questionsQuery);
            if (!$stmt) {
                $debug['errors'][] = "Error preparing questions query: " . $this->conn->error;
                continue;
            }

            $stmt->bind_param("i", $form['form_index']);
            $stmt->execute();
            $questionsResult = $stmt->get_result();

            while ($question = $questionsResult->fetch_assoc()) {
                if ($question['type_name'] === 'grid') {
                    // For grid questions, create a separate question for each row
                    $gridRows = explode(',', $question['grid_rows']);
                    $processedGridRows = [];
                    foreach ($gridRows as $row) {
                        list($index, $text) = explode(':', $row, 2);
                        $processedGridRows[(int)$index] = $text;
                    }

                    foreach ($processedGridRows as $rowIndex => $rowText) {
                        // Calculate the base divisor for percentage for grid rows (total submissions)
                        $divisor = $formStats['total_submissions'] > 0 ? $formStats['total_submissions'] : 1;

                        $choicesQuery = "SELECT 
                                            c.choice_text,
                                            COUNT(DISTINCT ga.response_index) as selection_count,
                                            COALESCE(ROUND((COUNT(DISTINCT ga.response_index) / CAST(? AS DECIMAL(10,2))) * 100, 2), 0.00) as selection_percentage
                                        FROM choices c
                                        LEFT JOIN grid_answers ga ON c.choice_index = ga.choice_index
                                        LEFT JOIN responses r ON ga.response_index = r.response_index
                                        LEFT JOIN students st ON r.student_index = st.student_index
                                        LEFT JOIN sections s ON st.section_index = s.section_index
                                        LEFT JOIN programs p ON s.program_index = p.program_index
                                        LEFT JOIN departments d ON p.dept_index = d.dept_index
                                        WHERE c.main_question_index = ?
                                        AND ga.sub_question_index = ?
                                        AND (r.is_autosave = 0 OR r.is_autosave IS NULL)
                                        $studentFilterSQL
                                        GROUP BY c.choice_text
                                        ORDER BY selection_count DESC";

                        $stmt = $this->conn->prepare($choicesQuery);
                        if (!$stmt) {
                            $debug['errors'][] = "Error preparing choices query for grid row: " . $this->conn->error;
                            continue;
                        }

                        // Add divisor, question index, and row index to params for percentage calculation
                        $params = [
                            $divisor, // Use calculated divisor
                            $question['main_question_index'],
                            $rowIndex
                        ];
                        $types = 'dii'; // Divisor is double, indices are integers
                        if (!empty($studentParams)) {
                            $params = array_merge($params, $studentParams);
                            $types .= $studentTypes;
                        }

                        $stmt->bind_param($types, ...$params);
                        $stmt->execute();
                        $choicesResult = $stmt->get_result();

                        $choices = [];
                        while ($choice = $choicesResult->fetch_assoc()) {
                            $choices[] = [
                                'choice_text' => $choice['choice_text'],
                                'selection_count' => (int)$choice['selection_count'],
                                'selection_percentage' => (float)$choice['selection_percentage']
                            ];
                        }

                        $formStats['questions'][] = [
                            'question_index' => $question['main_question_index'] . '_' . $rowIndex,
                            'question_text' => $rowText,
                            'type' => 'grid_row',
                            'section' => $question['section_title'],
                            'section_order' => (int)$question['section_order'],
                            'total_answers' => array_sum(array_column($choices, 'selection_count')), // Sum of selections for this row
                            'choices' => $choices
                        ];
                    }
                } else {
                    // For regular questions (multiple, checkbox, etc.)
                    $totalAnswersForQuestion = $question['total_answers'];

                    // Determine the correct divisor based on question type
                    $divisor = 1; // Default to 1 to avoid division by zero if no relevant answers
                    if ($question['type_name'] === 'checkbox') {
                         // For checkbox, percentage is based on total submissions
                         $divisor = $formStats['total_submissions'] > 0 ? $formStats['total_submissions'] : 1;
                     } else if ($totalAnswersForQuestion !== NULL && $totalAnswersForQuestion > 0) {
                         // For other types (like multiple), percentage is based on total answers for the question
                         $divisor = $totalAnswersForQuestion;
                     }

                     $choicesQuery = "SELECT 
                                         c.choice_text,
                                         COUNT(DISTINCT r.response_index) as selection_count,
                                         COALESCE(ROUND((COUNT(DISTINCT r.response_index) / CAST(? AS DECIMAL(10,2))) * 100, 2), 0.00) as selection_percentage
                                     FROM choices c
                                     LEFT JOIN answers a ON c.choice_index = a.choice_index
                                     LEFT JOIN responses r ON a.response_index = r.response_index
                                     LEFT JOIN students st ON r.student_index = st.student_index
                                     LEFT JOIN sections s ON st.section_index = s.section_index
                                     LEFT JOIN programs p ON s.program_index = p.program_index
                                     LEFT JOIN departments d ON p.dept_index = d.dept_index
                                     WHERE c.main_question_index = ?
                                     AND r.form_index = ?
                                     AND (r.is_autosave = 0 OR r.is_autosave IS NULL)
                                     $studentFilterSQL
                                     GROUP BY c.choice_text
                                     ORDER BY selection_count DESC";

                    // Log the query and parameters for debugging
                    error_log("Choices Query: " . $choicesQuery);
                    error_log("Query Parameters: " . json_encode([
                        'divisor' => $divisor,
                        'question_index' => $question['main_question_index'],
                        'form_index' => $form['form_index'],
                        'student_params' => $studentParams,
                        'student_types' => $studentTypes,
                        'student_filter_sql' => $studentFilterSQL
                    ]));

                    $stmt = $this->conn->prepare($choicesQuery);
                    if (!$stmt) {
                        $debug['errors'][] = "Error preparing choices query for regular question: " . $this->conn->error;
                        continue;
                    }

                    // Add divisor, question index, and form index to params
                    $params = [
                        $divisor,
                        $question['main_question_index'],
                        $form['form_index']
                    ];
                    $types = 'dii';
                    if (!empty($studentParams)) {
                        $params = array_merge($params, $studentParams);
                        $types .= $studentTypes;
                    }

                    $stmt->bind_param($types, ...$params);
                    $stmt->execute();
                    $choicesResult = $stmt->get_result();

                    // Log the results for debugging
                    $choices = [];
                    while ($choice = $choicesResult->fetch_assoc()) {
                        error_log("Choice Result: " . json_encode($choice));
                        $choices[] = [
                            'choice_text' => $choice['choice_text'],
                            'selection_count' => (int)$choice['selection_count'],
                            'selection_percentage' => (float)$choice['selection_percentage']
                        ];
                    }

                    $formStats['questions'][] = [
                        'question_index' => $question['main_question_index'],
                        'question_text' => $question['main_question_text'],
                        'type' => $question['type_name'],
                        'section' => $question['section_title'],
                        'section_order' => $question['section_order'],
                        'total_answers' => $totalAnswersForQuestion, // Use calculated value from SQL
                        'choices' => $choices
                    ];
                }
            }

            $statistics[] = $formStats;
        }

        return ['statistics' => $statistics, 'debug' => $debug];
    }
}

// Get filter parameters from request
$filters = [
    'form_index' => !empty($_GET['form_index']) ? (int)$_GET['form_index'] : null,
    'dept_index' => !empty($_GET['dept_index']) ? (int)$_GET['dept_index'] : null,
    'program_index' => !empty($_GET['program_index']) ? (int)$_GET['program_index'] : null,
    'section_index' => !empty($_GET['section_index']) ? (int)$_GET['section_index'] : null,
    'academic_year' => !empty($_GET['academic_year']) ? $_GET['academic_year'] : null,
    'year_level' => !empty($_GET['year_level']) ? (int)$_GET['year_level'] : null
];

// Log received parameters for debugging
error_log("Received parameters: " . json_encode([
    'filters' => $filters,
    'raw_get' => $_GET
]));

// Initialize statistics generator with existing connection and filters
$statsGenerator = new FormStatistics($conn, $filters);
$result = $statsGenerator->getFormStatistics();

// Output as JSON
echo json_encode($result, JSON_PRETTY_PRINT);
?> 