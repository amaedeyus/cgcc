-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2025 at 11:28 PM
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
-- Database: `cgcc`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblcounselor`
--

CREATE TABLE `tblcounselor` (
  `fld_index` int(100) NOT NULL,
  `fld_counselor_id` varchar(50) DEFAULT NULL,
  `fld_last_name` varchar(50) DEFAULT NULL,
  `fld_first_name` varchar(50) DEFAULT NULL,
  `fld_email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbllogin`
--

CREATE TABLE `tbllogin` (
  `fld_index` int(100) NOT NULL,
  `fld_email` varchar(50) NOT NULL,
  `fld_password` varchar(100) NOT NULL,
  `fld_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbllogin`
--

INSERT INTO `tbllogin` (`fld_index`, `fld_email`, `fld_password`, `fld_type`) VALUES
(2, 'test@gmail.com', '$2y$10$cgIJleBKWcS6nq0OlgEloOjS5hBrMO.spjbeh5OsLJSkqi3p1hE02', 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `tblstudent`
--

CREATE TABLE `tblstudent` (
  `fld_index` int(100) NOT NULL,
  `fld_student_id` int(50) DEFAULT NULL,
  `fld_last_name` varchar(50) DEFAULT NULL,
  `fld_first_name` varchar(50) DEFAULT NULL,
  `fld_email` varchar(50) DEFAULT NULL,
  `fld_year` varchar(50) DEFAULT NULL,
  `fld_program_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblcounselor`
--
ALTER TABLE `tblcounselor`
  ADD PRIMARY KEY (`fld_index`);

--
-- Indexes for table `tbllogin`
--
ALTER TABLE `tbllogin`
  ADD PRIMARY KEY (`fld_index`);

--
-- Indexes for table `tblstudent`
--
ALTER TABLE `tblstudent`
  ADD PRIMARY KEY (`fld_index`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbllogin`
--
ALTER TABLE `tbllogin`
  MODIFY `fld_index` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
