-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2025 at 12:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `form_builder`
--
CREATE DATABASE IF NOT EXISTS `form_builder`;
USE `form_builder`

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `answer_index` int(11) NOT NULL,
  `response_index` int(11) DEFAULT NULL,
  `main_question_index` int(11) DEFAULT NULL,
  `choice_index` int(11) DEFAULT NULL,
  `text_answer` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `choices`
--

CREATE TABLE `choices` (
  `choice_index` int(11) NOT NULL,
  `main_question_index` int(11) DEFAULT NULL,
  `choice_text` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `choices`
--

INSERT INTO `choices` (`choice_index`, `main_question_index`, `choice_text`) VALUES
(1, 2, 'fsdfsdfdfsdf'),
(4, 8, 'ads'),
(5, 8, 'das');

-- --------------------------------------------------------

--
-- Table structure for table `counselors`
--

CREATE TABLE `counselors` (
  `counselor_index` int(11) NOT NULL,
  `user_index` int(11) NOT NULL,
  `counselor_number` varchar(255) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `calendar_link` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_index` int(11) NOT NULL,
  `dept_code` varchar(255) DEFAULT NULL,
  `dept_title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_index`, `dept_code`, `dept_title`) VALUES
(1, 'CBEAM', 'College of Business, Economics, Accountancy and Management'),
(2, 'CEAS', 'College of Education, Arts and Sciences'),
(3, 'CIHTM', 'College of International Hospitality and Tourism Management'),
(4, 'CITE', 'College of Information Technology and Engineering'),
(5, 'CON', 'College of Nursing'),
(6, 'COL', 'College of Law');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `form_index` int(11) NOT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`form_index`, `form_name`, `description`, `created_at`) VALUES
(1, 'sfdsf', 'fsdf', '2025-04-30 05:28:30'),
(2, 'fsdfsdfs', 'fsdfsdfsdf', '2025-04-30 12:25:24');

-- --------------------------------------------------------

--
-- Table structure for table `grid_answers`
--

CREATE TABLE `grid_answers` (
  `grid_answer_index` int(11) NOT NULL,
  `response_index` int(11) DEFAULT NULL,
  `main_question_index` int(11) DEFAULT NULL,
  `sub_question_index` int(11) DEFAULT NULL,
  `choice_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `main_questions`
--

CREATE TABLE `main_questions` (
  `main_question_index` int(11) NOT NULL,
  `form_index` int(11) DEFAULT NULL,
  `main_question_text` text DEFAULT NULL,
  `type_index` int(11) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `main_questions`
--

INSERT INTO `main_questions` (`main_question_index`, `form_index`, `main_question_text`, `type_index`, `is_required`) VALUES
(2, 2, 'fsdfsfd', 6, 0),
(7, 1, 'fsdfsdfd', 1, 0),
(8, 1, 'nnkjigyh', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_index` int(11) NOT NULL,
  `dept_index` int(11) NOT NULL,
  `program_code` varchar(20) NOT NULL,
  `program_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`program_index`, `dept_index`, `program_code`, `program_name`) VALUES
(1, 1, 'BSA', 'Bachelor of Science in Accountancy'),
(2, 1, 'BSAIS', 'Bachelor of Science in Accounting Information Systems'),
(3, 1, 'BSLM', 'Bachelor of Science in Legal Management'),
(4, 1, 'BSE', 'Bachelor of Science in Entrepreneurship'),
(5, 1, 'BSMT', 'Bachelor of Science in Management Technology'),
(6, 1, 'BSBA-FM', 'Bachelor of Science in Business Administration major in Financial Management'),
(7, 1, 'BSBA-MM', 'Bachelor of Science in Business Administration major in Marketing Management'),
(8, 1, 'CE', 'Certificate in Entrepreneurship'),
(9, 2, 'BEED', 'Bachelor of Elementary Education'),
(10, 2, 'BSED', 'Bachelor of Secondary Education'),
(11, 2, 'AB COM', 'Bachelor of Arts in Communication'),
(12, 2, 'BMMA', 'Bachelor of Multimedia Arts'),
(13, 2, 'BS BIO', 'Bachelor of Science in Biology'),
(14, 2, 'BSFS', 'Bachelor of Science in Forensic Science'),
(15, 2, 'BS MATH', 'Bachelor of Science in Mathematics'),
(16, 2, 'BS PSYCH', 'Bachelor of Science in Psychology'),
(17, 3, 'BSHM', 'Bachelor of Science in Hospitality Management'),
(18, 3, 'BSTM', 'Bachelor of Science in Tourism Management'),
(19, 3, 'CCA', 'Certificate in Culinary Arts'),
(20, 4, 'BS ARCHI', 'Bachelor of Science in Architecture'),
(21, 4, 'BS CpE', 'Bachelor of Science in Computer Engineering'),
(22, 4, 'BSCS', 'Bachelor of Science in Computer Science'),
(23, 4, 'BSEE', 'Bachelor of Science in Electrical Engineering'),
(24, 4, 'BSECE', 'Bachelor of Science in Electronics Engineering'),
(25, 4, 'BSEMC', 'Bachelor of Science in Entertainment and Multimedia Computing'),
(26, 4, 'BSIE', 'Bachelor of Science in Industrial Engineering'),
(27, 4, 'BSIT', 'Bachelor of Science in Information Technology'),
(28, 4, 'ACT', 'Associate in Computer Technology'),
(29, 5, 'BSN', 'Bachelor of Science in Nursing'),
(30, 6, 'JD', 'Juris Doctor');

-- --------------------------------------------------------

--
-- Table structure for table `question_types`
--

CREATE TABLE `question_types` (
  `type_index` int(11) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `question_types`
--

INSERT INTO `question_types` (`type_index`, `type_name`) VALUES
(1, 'short'),
(2, 'paragraph'),
(3, 'multiple'),
(4, 'checkbox'),
(5, 'dropdown'),
(6, 'grid'),
(7, 'date');

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE `responses` (
  `response_index` int(11) NOT NULL,
  `form_index` int(11) DEFAULT NULL,
  `student_index` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `section_index` int(11) NOT NULL,
  `section_name` varchar(50) NOT NULL,
  `program_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`section_index`, `section_name`, `program_id`) VALUES
(1, 'BSA-1A', 1),
(2, 'BSA-1B', 1),
(3, 'BSAIS-1A', 2),
(4, 'BSAIS-1B', 2),
(5, 'BSLM-1A', 3),
(6, 'BSLM-1B', 3),
(7, 'BSE-1A', 4),
(8, 'BSE-1B', 4),
(9, 'BSMT-1A', 5),
(10, 'BSMT-1B', 5),
(11, 'BSBA-FM-1A', 6),
(12, 'BSBA-FM-1B', 6),
(13, 'BSBA-MM-1A', 7),
(14, 'BSBA-MM-1B', 7),
(15, 'CE-1A', 8),
(16, 'CE-1B', 8),
(17, 'BEED-1A', 9),
(18, 'BEED-1B', 9),
(19, 'BSED-1A', 10),
(20, 'BSED-1B', 10),
(21, 'ABCOM-1A', 11),
(22, 'ABCOM-1B', 11),
(23, 'BMMA-1A', 12),
(24, 'BMMA-1B', 12),
(25, 'BSBIO-1A', 13),
(26, 'BSBIO-1B', 13),
(27, 'BSFS-1A', 14),
(28, 'BSFS-1B', 14),
(29, 'BSMATH-1A', 15),
(30, 'BSMATH-1B', 15),
(31, 'BSPSYCH-1A', 16),
(32, 'BSPSYCH-1B', 16),
(33, 'BSHM-1A', 17),
(34, 'BSHM-1B', 17),
(35, 'BSTM-1A', 18),
(36, 'BSTM-1B', 18),
(37, 'CCA-1A', 19),
(38, 'CCA-1B', 19),
(39, 'BSARCHI-1A', 20),
(40, 'BSARCHI-1B', 20),
(41, 'BSCpE-1A', 21),
(42, 'BSCpE-1B', 21),
(43, 'BSCS-1A', 22),
(44, 'BSCS-1B', 22),
(45, 'BSEE-1A', 23),
(46, 'BSEE-1B', 23),
(47, 'BSECE-1A', 24),
(48, 'BSECE-1B', 24),
(49, 'BSEMC-1A', 25),
(50, 'BSEMC-1B', 25),
(51, 'BSIE-1A', 26),
(52, 'BSIE-1B', 26),
(53, 'BSIT-1A', 27),
(54, 'BSIT-1B', 27),
(55, 'ACT-1A', 28),
(56, 'ACT-1B', 28),
(57, 'BSN-1A', 29),
(58, 'BSN-1B', 29),
(59, 'JD-1A', 30),
(60, 'JD-1B', 30);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_index` int(11) NOT NULL,
  `user_index` int(11) NOT NULL,
  `student_number` varchar(255) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `year_level` int(1) NOT NULL,
  `section_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_index`, `user_index`, `student_number`, `last_name`, `first_name`, `year_level`, `section_id`) VALUES
(1, 1, '2023351801', 'Balion', 'Angel Amaya', 2, 20),
(2, 4, '2023350761', 'Del Rosario', 'Renz Andrei', 2, 21),
(3, 5, '2023359771', 'Talens', 'Xyrelle Dominique', 2, 23),
(4, 6, '2023352471', 'Doctolero', 'Lyrus Lei', 2, 37),
(5, 7, '20233621', 'Alonzo', 'Enjey Kashlee', 2, 26),
(6, 8, '2023363891', 'Alonzo', 'Jhenelle', 2, 57),
(7, 9, '2023350511', 'Dela Vega', 'Princess Mihaela', 2, 60),
(8, 10, '2023348471', 'Estrella', 'Juan Benjo', 2, 46),
(9, 11, '2023362901', 'Liwanag', 'Katherine Anne', 2, 3),
(10, 12, '2023362341', 'Paray', 'Jane Allyson', 2, 48),
(11, 13, '2023358411', 'Sahagun', 'Daniel Luis', 2, 12),
(12, 14, '2023352411', 'Tenorio', 'Jhon Paulo', 2, 21);

-- --------------------------------------------------------

--
-- Table structure for table `sub_questions`
--

CREATE TABLE `sub_questions` (
  `sub_question_index` int(11) NOT NULL,
  `main_question_index` int(11) DEFAULT NULL,
  `sub_question_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_questions`
--

INSERT INTO `sub_questions` (`sub_question_index`, `main_question_index`, `sub_question_text`) VALUES
(1, 2, 'fsdfdsf'),
(2, 8, 'dasd');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_index` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_index`, `email`, `password`, `type`, `created_at`) VALUES
(1, 'angel_amaya_balion@dlsl.edu.ph', '$2y$10$.ugAqIwocz1sb1wE4k9p/.OQ.VQfqOiy/8YrMyXk7l1sTDNUe19s6', 'student', '2025-04-30 06:48:52'),
(2, 'amybalion533@gmail.com', '$2y$10$.ugAqIwocz1sb1wE4k9p/.OQ.VQfqOiy/8YrMyXk7l1sTDNUe19s6', 'admin', '2025-04-30 07:34:49'),
(3, 'balionamaya01@gmail.com', '$2y$10$.ugAqIwocz1sb1wE4k9p/.OQ.VQfqOiy/8YrMyXk7l1sTDNUe19s6', 'counselor', '2025-04-30 07:35:57'),
(4, 'renz_andrei_delrosario@dlsl.edu.ph', '$2y$10$ZtzitJGInBQZl.LYAS4cxuS5v31acCrUuuUSLsO1ehjNLXQgF4Iza', 'student', '2025-05-02 02:29:55'),
(5, 'xyrelle_dominique_talens@dlsl.edu.ph', '$2y$10$YEayWrIWlENsw6wqLxI8EuBasWFOds0yK3uLla04ZgjCmo3V4hHa6', 'student', '2025-05-04 08:13:56'),
(6, 'lyrus_lei_doctolero@dlsl.edu.ph', '$2y$10$I0jZ6DYNZU3nzf/qPlq7K.dzNCEdnYFJKF3w48iAeN6rzCagJVQ2C', 'student', '2025-05-04 08:13:56'),
(7, 'enjey_kashlee_alonzo@dlsl.edu.ph', '', 'student', '2025-05-07 12:42:20'),
(8, 'jhenelle_alonzo@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54'),
(9, 'princess_mihaela_delavega@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54'),
(10, 'juan_benjo_estrella@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54'),
(11, 'katherine_anne_liwanag@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54'),
(12, 'jane_allyson_paray@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54'),
(13, 'daniel_luis_sahagun@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54'),
(14, 'jhon_paulo_tenorio@dlsl.edu.ph', '', 'student', '2025-05-07 12:45:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`answer_index`),
  ADD KEY `Response_ID` (`response_index`),
  ADD KEY `Main_Question_ID` (`main_question_index`),
  ADD KEY `Choice_ID` (`choice_index`);

--
-- Indexes for table `choices`
--
ALTER TABLE `choices`
  ADD PRIMARY KEY (`choice_index`),
  ADD KEY `Main_Question_ID` (`main_question_index`);

--
-- Indexes for table `counselors`
--
ALTER TABLE `counselors`
  ADD PRIMARY KEY (`counselor_index`),
  ADD KEY `fk2` (`user_index`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_index`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`form_index`);

--
-- Indexes for table `grid_answers`
--
ALTER TABLE `grid_answers`
  ADD PRIMARY KEY (`grid_answer_index`),
  ADD KEY `Response_id` (`response_index`),
  ADD KEY `Main_Question_ID` (`main_question_index`),
  ADD KEY `Sub_Question_ID` (`sub_question_index`),
  ADD KEY `Choice_ID` (`choice_index`);

--
-- Indexes for table `main_questions`
--
ALTER TABLE `main_questions`
  ADD PRIMARY KEY (`main_question_index`),
  ADD KEY `Form_ID` (`form_index`),
  ADD KEY `QType_ID` (`type_index`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`program_index`),
  ADD UNIQUE KEY `program_code` (`program_code`),
  ADD KEY `dept_index` (`dept_index`);

--
-- Indexes for table `question_types`
--
ALTER TABLE `question_types`
  ADD PRIMARY KEY (`type_index`);

--
-- Indexes for table `responses`
--
ALTER TABLE `responses`
  ADD PRIMARY KEY (`response_index`),
  ADD KEY `Form_ID` (`form_index`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`section_index`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_index`),
  ADD KEY `fk1` (`user_index`),
  ADD KEY `fk_student_section` (`section_id`);

--
-- Indexes for table `sub_questions`
--
ALTER TABLE `sub_questions`
  ADD PRIMARY KEY (`sub_question_index`),
  ADD KEY `Main_Question_ID` (`main_question_index`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_index`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `answer_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `choice_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `counselor_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `form_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grid_answers`
--
ALTER TABLE `grid_answers`
  MODIFY `grid_answer_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_questions`
--
ALTER TABLE `main_questions`
  MODIFY `main_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `question_types`
--
ALTER TABLE `question_types`
  MODIFY `type_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `responses`
--
ALTER TABLE `responses`
  MODIFY `response_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `sub_questions`
--
ALTER TABLE `sub_questions`
  MODIFY `sub_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`response_index`) REFERENCES `responses` (`response_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`),
  ADD CONSTRAINT `answers_ibfk_3` FOREIGN KEY (`choice_index`) REFERENCES `choices` (`choice_index`);

--
-- Constraints for table `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `choices_ibfk_1` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`) ON DELETE CASCADE;

--
-- Constraints for table `counselors`
--
ALTER TABLE `counselors`
  ADD CONSTRAINT `fk2` FOREIGN KEY (`user_index`) REFERENCES `users` (`user_index`) ON DELETE CASCADE;

--
-- Constraints for table `grid_answers`
--
ALTER TABLE `grid_answers`
  ADD CONSTRAINT `grid_answers_ibfk_1` FOREIGN KEY (`response_index`) REFERENCES `responses` (`response_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `grid_answers_ibfk_2` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`),
  ADD CONSTRAINT `grid_answers_ibfk_3` FOREIGN KEY (`sub_question_index`) REFERENCES `sub_questions` (`sub_question_index`),
  ADD CONSTRAINT `grid_answers_ibfk_4` FOREIGN KEY (`choice_index`) REFERENCES `choices` (`choice_index`);

--
-- Constraints for table `main_questions`
--
ALTER TABLE `main_questions`
  ADD CONSTRAINT `main_questions_ibfk_1` FOREIGN KEY (`form_index`) REFERENCES `forms` (`form_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `main_questions_ibfk_2` FOREIGN KEY (`type_index`) REFERENCES `question_types` (`type_index`);

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`dept_index`) REFERENCES `departments` (`dept_index`);

--
-- Constraints for table `responses`
--
ALTER TABLE `responses`
  ADD CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`form_index`) REFERENCES `forms` (`form_index`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_index`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk1` FOREIGN KEY (`user_index`) REFERENCES `users` (`user_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_student_section` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_index`);

--
-- Constraints for table `sub_questions`
--
ALTER TABLE `sub_questions`
  ADD CONSTRAINT `sub_questions_ibfk_1` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;