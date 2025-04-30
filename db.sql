-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2025 at 09:51 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
CREATE DATABASE IF NOT EXISTS `form_builder`;
USE `form_builder`;

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

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `Answer_ID` int(11) NOT NULL,
  `Response_ID` int(11) NOT NULL,
  `Main_Question_ID` int(11) NOT NULL,
  `Choice_ID` int(11) DEFAULT NULL,
  `Text_Answer` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `choices`
--

CREATE TABLE `choices` (
  `Choice_ID` int(11) NOT NULL,
  `Main_Question_ID` int(11) NOT NULL,
  `Choice_Text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `choices`
--

INSERT INTO `choices` (`Choice_ID`, `Main_Question_ID`, `Choice_Text`) VALUES
(1, 2, 'fsdfsdfdfsdf');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `Form_ID` int(11) NOT NULL,
  `Form_Name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Time_Created` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`Form_ID`, `Form_Name`, `Description`, `Time_Created`) VALUES
(1, 'sfdsf', 'fsdf', '2025-04-30 05:28:30'),
(2, 'fsdfsdfs', 'fsdfsdfsdf', '2025-04-30 12:25:24');

-- --------------------------------------------------------

--
-- Table structure for table `grid_answer`
--

CREATE TABLE `grid_answer` (
  `Grid_answer_id` int(11) NOT NULL,
  `Response_id` int(11) NOT NULL,
  `Main_Question_ID` int(11) NOT NULL,
  `Sub_Question_ID` int(11) NOT NULL,
  `Choice_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `main_questions`
--

CREATE TABLE `main_questions` (
  `Main_Question_ID` int(11) NOT NULL,
  `Form_ID` int(11) NOT NULL,
  `Main_Question` text NOT NULL,
  `QType_ID` int(11) NOT NULL,
  `Required` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `main_questions`
--

INSERT INTO `main_questions` (`Main_Question_ID`, `Form_ID`, `Main_Question`, `QType_ID`, `Required`) VALUES
(1, 1, 'fsdfsdfd', 1, 0),
(2, 2, 'fsdfsfd', 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `question_type`
--

CREATE TABLE `question_type` (
  `QType_ID` int(11) NOT NULL,
  `Question_Type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `question_type`
--

INSERT INTO `question_type` (`QType_ID`, `Question_Type`) VALUES
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
  `Response_ID` int(11) NOT NULL,
  `Form_ID` int(11) NOT NULL,
  `Student_ID` varchar(50) DEFAULT NULL,
  `Response_Date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_question`
--

CREATE TABLE `sub_question` (
  `Sub_Question_ID` int(11) NOT NULL,
  `Main_Question_ID` int(11) NOT NULL,
  `Sub_Question` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_question`
--

INSERT INTO `sub_question` (`Sub_Question_ID`, `Main_Question_ID`, `Sub_Question`) VALUES
(1, 2, 'fsdfdsf');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `type`, `created_at`) VALUES
(1, 'angel_amaya_balion@dlsl.edu.ph', 'student', '2025-04-30 06:48:52'),
(2, 'amybalion533@gmail.com', 'admin', '2025-04-30 07:34:49'),
(3, 'balionamaya01@gmail.com', 'counselor', '2025-04-30 07:35:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`Answer_ID`),
  ADD KEY `Response_ID` (`Response_ID`),
  ADD KEY `Main_Question_ID` (`Main_Question_ID`),
  ADD KEY `Choice_ID` (`Choice_ID`);

--
-- Indexes for table `choices`
--
ALTER TABLE `choices`
  ADD PRIMARY KEY (`Choice_ID`),
  ADD KEY `Main_Question_ID` (`Main_Question_ID`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`Form_ID`);

--
-- Indexes for table `grid_answer`
--
ALTER TABLE `grid_answer`
  ADD PRIMARY KEY (`Grid_answer_id`),
  ADD KEY `Response_id` (`Response_id`),
  ADD KEY `Main_Question_ID` (`Main_Question_ID`),
  ADD KEY `Sub_Question_ID` (`Sub_Question_ID`),
  ADD KEY `Choice_ID` (`Choice_ID`);

--
-- Indexes for table `main_questions`
--
ALTER TABLE `main_questions`
  ADD PRIMARY KEY (`Main_Question_ID`),
  ADD KEY `Form_ID` (`Form_ID`),
  ADD KEY `QType_ID` (`QType_ID`);

--
-- Indexes for table `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`QType_ID`);

--
-- Indexes for table `responses`
--
ALTER TABLE `responses`
  ADD PRIMARY KEY (`Response_ID`),
  ADD KEY `Form_ID` (`Form_ID`);

--
-- Indexes for table `sub_question`
--
ALTER TABLE `sub_question`
  ADD PRIMARY KEY (`Sub_Question_ID`),
  ADD KEY `Main_Question_ID` (`Main_Question_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `Answer_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `Choice_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `Form_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grid_answer`
--
ALTER TABLE `grid_answer`
  MODIFY `Grid_answer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_questions`
--
ALTER TABLE `main_questions`
  MODIFY `Main_Question_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `question_type`
--
ALTER TABLE `question_type`
  MODIFY `QType_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `responses`
--
ALTER TABLE `responses`
  MODIFY `Response_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_question`
--
ALTER TABLE `sub_question`
  MODIFY `Sub_Question_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`Response_ID`) REFERENCES `responses` (`Response_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`Main_Question_ID`) REFERENCES `main_questions` (`Main_Question_ID`),
  ADD CONSTRAINT `answers_ibfk_3` FOREIGN KEY (`Choice_ID`) REFERENCES `choices` (`Choice_ID`);

--
-- Constraints for table `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `choices_ibfk_1` FOREIGN KEY (`Main_Question_ID`) REFERENCES `main_questions` (`Main_Question_ID`) ON DELETE CASCADE;

--
-- Constraints for table `grid_answer`
--
ALTER TABLE `grid_answer`
  ADD CONSTRAINT `grid_answer_ibfk_1` FOREIGN KEY (`Response_id`) REFERENCES `responses` (`Response_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `grid_answer_ibfk_2` FOREIGN KEY (`Main_Question_ID`) REFERENCES `main_questions` (`Main_Question_ID`),
  ADD CONSTRAINT `grid_answer_ibfk_3` FOREIGN KEY (`Sub_Question_ID`) REFERENCES `sub_question` (`Sub_Question_ID`),
  ADD CONSTRAINT `grid_answer_ibfk_4` FOREIGN KEY (`Choice_ID`) REFERENCES `choices` (`Choice_ID`);

--
-- Constraints for table `main_questions`
--
ALTER TABLE `main_questions`
  ADD CONSTRAINT `main_questions_ibfk_1` FOREIGN KEY (`Form_ID`) REFERENCES `forms` (`Form_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `main_questions_ibfk_2` FOREIGN KEY (`QType_ID`) REFERENCES `question_type` (`QType_ID`);

--
-- Constraints for table `responses`
--
ALTER TABLE `responses`
  ADD CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`Form_ID`) REFERENCES `forms` (`Form_ID`) ON DELETE CASCADE;

--
-- Constraints for table `sub_question`
--
ALTER TABLE `sub_question`
  ADD CONSTRAINT `sub_question_ibfk_1` FOREIGN KEY (`Main_Question_ID`) REFERENCES `main_questions` (`Main_Question_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
