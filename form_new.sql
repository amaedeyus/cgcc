-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2025 at 08:51 AM
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
-- Database: `form_new`
--

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

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`answer_index`, `response_index`, `main_question_index`, `choice_index`, `text_answer`) VALUES
(984, 36, 827, NULL, 'assdasdsdasd'),
(985, 37, 844, 4746, NULL),
(986, 37, 846, NULL, '');

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
(4636, 822, 'Not at all'),
(4637, 822, 'Rare, less than a day or two'),
(4638, 822, 'Several days'),
(4639, 822, 'Most of the days in the past 2 weeks'),
(4640, 822, 'Almost everyday'),
(4641, 823, 'Yes'),
(4642, 823, 'No'),
(4643, 824, 'Yes'),
(4644, 824, 'No'),
(4645, 825, 'Very Low'),
(4646, 825, 'Low'),
(4647, 825, 'Moderate'),
(4648, 825, 'High'),
(4649, 825, 'Very High'),
(4650, 826, 'Yes'),
(4651, 826, 'No'),
(4745, 844, 'Ms. Jane Aira Ramilo'),
(4746, 844, 'Ms. Nery Dumol'),
(4747, 844, 'Ms. Geraldine Flores'),
(4748, 844, 'Ms. Lot Prospero'),
(4749, 844, 'Ms. Olive Diokno'),
(4750, 844, 'Ms. Mercy Malabanan'),
(4751, 844, 'Ms. Edchell Adajar'),
(4752, 844, 'Ms. Kristine Mendoza'),
(4753, 845, '4 - Strongly Agree'),
(4754, 845, '3 - Agree'),
(4755, 845, '2 - Disagree'),
(4756, 845, '1 - Strongly Agree'),
(4810, 896, 'Male'),
(4811, 896, 'Female'),
(4812, 897, 'Female'),
(4813, 897, 'Male'),
(4814, 897, 'Transgender'),
(4815, 897, 'Gender neutral'),
(4816, 897, 'Non-binary'),
(4817, 897, 'Agender'),
(4818, 897, 'Pangender'),
(4819, 897, 'Genderqueer'),
(4820, 897, 'Two-spirit'),
(4821, 897, 'Third gender'),
(4822, 897, 'Prefer to self-describe'),
(4823, 897, 'Prefer not to say'),
(4824, 897, 'A gender not listed'),
(4825, 898, 'Single'),
(4826, 898, 'Married WIHT child/children'),
(4827, 898, 'Married WITHOUT child/children'),
(4828, 898, 'Living with Partner WITH child/children'),
(4829, 898, 'Living with Partner WITHOUT child/children'),
(4830, 898, 'Single Parent'),
(4831, 899, 'No'),
(4832, 899, 'Yes'),
(4833, 900, 'Father only'),
(4834, 900, 'Mother only'),
(4835, 900, 'Both parents'),
(4836, 900, 'No. I do not have an OFW parent'),
(4837, 911, 'Married and living together'),
(4838, 911, 'Permanently separated'),
(4839, 911, 'Marriage annulled'),
(4840, 911, 'Legally separated'),
(4841, 911, 'Father w/ another partner'),
(4842, 911, 'Mother w/ another partner'),
(4843, 911, 'Temporarily separated'),
(4844, 911, 'Father is deceased'),
(4845, 911, 'Mother is deceased'),
(4846, 911, 'Other'),
(4847, 915, 'Own House (with parents)'),
(4848, 915, 'Own house (without parents/guardian)'),
(4849, 915, 'Renting with parents/relatives (boarding house, dormitory, apartment)'),
(4850, 915, 'Renting Alone (boarding house, dormitory, apartment)'),
(4851, 915, 'Living with relatives'),
(4852, 915, 'Other'),
(4853, 916, 'No'),
(4854, 916, 'Yes'),
(4855, 917, 'No Scholarship'),
(4856, 917, 'Academic Scholarship'),
(4857, 917, 'Clerical Assistant'),
(4858, 917, 'Brother Gregory Refuerzo Scholarship Grants Program (c/o Lasallian Partners)'),
(4859, 917, 'Miguel Febres Cordero Scholarship (FEBRES)'),
(4860, 917, 'PD577'),
(4861, 917, 'Br. Henry Virgil Scholarship (ATHLETES)'),
(4862, 917, 'Privately Funded Scholarship'),
(4955, 936, 'Yes'),
(4956, 937, 'Adjusting to change'),
(4957, 937, 'Experiencing Bullying/Discrimination'),
(4958, 937, 'Struggling with Relationship Problems'),
(4959, 937, 'Issues with self-image'),
(4960, 937, 'Concerns about sexuality/gender identity'),
(4961, 937, 'Finding it difficult to express one\'s thoughts/feelings'),
(4962, 937, 'Struggling in getting along with others/making friends'),
(4963, 937, 'Spiritual/Religious issues'),
(4964, 937, 'Lack of decision making skills'),
(4965, 937, 'Lack of social support'),
(4966, 937, 'Lacking of self-confidence'),
(4967, 937, 'Lacks effective communication skills'),
(4968, 937, 'Need to develop leadership skills'),
(4969, 937, 'Need to have better self-concept'),
(4970, 937, 'Experiencing harassment'),
(4971, 937, 'Trust issue'),
(4972, 937, 'Feeling very strong emotions'),
(4973, 937, 'No social/emotional concern'),
(4974, 938, 'Absence of father/mother'),
(4975, 938, 'Dealing with a loss'),
(4976, 938, 'Feeling of being unloved'),
(4977, 938, 'Financial difficulties'),
(4978, 938, 'Struggling with parents’ marital conflicts/separationz'),
(4979, 938, 'Health of a family member'),
(4980, 938, 'Home environment is not conducive to study'),
(4981, 938, 'Homesickness/Living away from home'),
(4982, 938, 'Lacking parents\' appreciation'),
(4983, 938, 'Not getting along well with a family member/relative'),
(4984, 938, 'Feeling pressured by high expectations from parents/family'),
(4985, 938, 'Feeling invalidated by family members'),
(4986, 938, 'Concerned about the health of a family member'),
(4987, 938, 'Too many responsibilities at home'),
(4988, 938, 'No Family/Home Concern'),
(4989, 939, 'Struggling with addiction (substance use, internet, gaming, gambling, shopping)'),
(4990, 939, 'Difficulty in managing emotions'),
(4991, 939, 'Feeling burned out'),
(4992, 939, 'Feeling tired/fatigued most of the time (physically/emotionally)'),
(4993, 939, 'Having a physical illness that needs medical attention'),
(4994, 939, 'Racing thoughts'),
(4995, 939, 'Overthinking / Anxiety'),
(4996, 939, 'Having panic attacks'),
(4997, 939, 'Experiencing stress'),
(4998, 939, 'Difficulty coping with stress'),
(4999, 939, 'Deep feelings of sadness'),
(5000, 939, 'Self-harm behavior (cutting, scratching, burning, etc.)'),
(5001, 939, 'Erratic sleeping patterns'),
(5002, 939, 'Suicidal thoughts'),
(5003, 939, 'Suicide attempt'),
(5004, 939, 'Difficulty concentrating/being more forgetful'),
(5005, 939, 'Avoiding people, situations, or responsibilities'),
(5006, 939, 'Unable to enjoy/loss of interest in activities'),
(5007, 939, 'Feeling empty/Not feeling anything'),
(5008, 939, 'Increased irritability'),
(5009, 939, 'Crying spells'),
(5010, 939, 'Changes in appetite (eating more or less)'),
(5011, 939, 'No Mental/Physical Health Concerns'),
(5012, 940, 'Difficulty in adjusting to learning modality'),
(5013, 940, 'Difficulty in meeting academic requirements'),
(5014, 940, 'Difficulty working independently'),
(5015, 940, 'Difficulty working in a group/pair'),
(5016, 940, 'Dissatisfaction with academic performance/grades'),
(5017, 940, 'Lacking effective study habits (note-taking, time management)'),
(5018, 940, 'Difficulty overcoming distractions'),
(5019, 940, 'Lacking motivation'),
(5020, 940, 'Struggling with procrastination'),
(5021, 940, 'Struggling to balance academics with extracurricular/non-academic activities'),
(5022, 940, 'Test anxiety'),
(5023, 940, 'No Academic concern'),
(5024, 941, 'Favoritism/ unfair treatment'),
(5025, 941, 'Inadequate background knowledge about the subjects'),
(5026, 941, 'Unavailable most of the time'),
(5027, 941, 'Difficult to reach or communicate with'),
(5028, 941, 'Unethical/unprofessional behavior'),
(5029, 941, 'Does not provide timely feedback'),
(5030, 941, 'No Professor issues/concerns'),
(5031, 942, 'Uncertainty about career choice/ wanting to shift to another program'),
(5032, 942, 'Career choice is limited by financial resources'),
(5033, 942, 'Unaware of strengths, abilities, or interests'),
(5034, 942, 'Feeling lost and overwhelmed about making a career decision'),
(5035, 942, 'Feeling pressured by peers/family to succeed'),
(5036, 942, 'Need help with career planning'),
(5037, 942, 'Dissatisfied with the present college program'),
(5038, 942, 'Anxious about the future/world of work'),
(5039, 942, 'No Career concern'),
(5040, 943, 'Yes'),
(5041, 943, 'No'),
(5042, 945, 'I Certify'),
(5043, 946, 'Agree'),
(5044, 946, 'Disagree'),
(5045, 949, 'I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.'),
(5046, 949, 'I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.'),
(5047, 952, 'Very Good'),
(5048, 952, 'Good'),
(5049, 952, 'Poor'),
(5050, 952, 'Very Poor'),
(5051, 953, 'Very Satisfied'),
(5052, 953, 'Satisfied'),
(5053, 953, 'Dissatisfied'),
(5054, 953, 'Not Satisfied'),
(5055, 953, 'N/A'),
(5056, 955, 'Very Good'),
(5057, 955, 'Good'),
(5058, 955, 'Poor'),
(5059, 955, 'Very Poor'),
(5060, 956, 'Continue with graduate studies in the same field'),
(5061, 956, 'Continue with graduate studies in a different field'),
(5062, 956, 'Continue with higher education in another field'),
(5063, 956, 'Review for Licensure Examination'),
(5064, 956, 'Look for a job'),
(5065, 956, 'I already have a job and will immediately start working'),
(5066, 956, 'Involve myself with volunteer activities'),
(5067, 956, 'Help manage our family business'),
(5068, 956, 'Work on an online job'),
(5069, 956, 'Stay unemployed and rest for a while'),
(5070, 956, 'Other'),
(5071, 957, 'Feels unprepared for job application process (job interview, creating a resume, visiting companies, etc.)'),
(5072, 957, 'Feels not ready for the world of work'),
(5073, 957, 'Anxious about competition in job hunting'),
(5074, 957, 'Pressure to provide/give back for the family'),
(5075, 957, 'Expectations from family, society to succeed'),
(5076, 957, 'Concerns about adjusting to change (workplace environment, new people, work responsibilities, leaving DLSL)'),
(5077, 957, 'Other'),
(5078, 958, 'Strongly Recommended'),
(5079, 958, 'Recommended'),
(5080, 958, 'NOT Recommended'),
(5081, 958, 'Strongly NOT Recommended De La Salle Lipa as an academic institution	 To enroll my college program in De La Salle Lipa.	 To enroll in other college programs in De La Salle Lipa');

-- --------------------------------------------------------

--
-- Table structure for table `counselors`
--

CREATE TABLE `counselors` (
  `counselor_index` int(11) NOT NULL,
  `user_index` int(11) DEFAULT NULL,
  `counselor_number` varchar(255) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `calendar_link` varchar(200) NOT NULL,
  `status` enum('active','inactive','deleted','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counselors`
--

INSERT INTO `counselors` (`counselor_index`, `user_index`, `counselor_number`, `last_name`, `first_name`, `calendar_link`, `status`) VALUES
(1, 40, 'CG0001', 'Balion', 'Angel Amaya', 'https://calendar.app.google/DVooLDaj5wBZ9Jnj7', 'active'),
(2, 41, 'CG0002', 'cruz', 'juan', 'https://calendly.com/juan-dela-cruz', 'active'),
(3, 42, 'CG0003', 'santos', 'maria', 'https://calendly.com/maria-santos', 'active'),
(4, 43, 'CG0004', 'lim', 'antonio', 'https://calendly.com/antonio-lim', 'active'),
(5, 44, 'CG0005', 'reyes', 'sofia', 'https://calendly.com/sofia-reyes', 'active'),
(6, 45, 'CG0006', 'gonzales', 'carlos', 'https://calendly.com/carlos-gonzales', 'active'),
(7, 46, 'CG0007', 'ramirez', 'lucia', 'https://calendly.com/lucia-ramirez', 'active'),
(8, 47, 'CG0008', 'tan', 'fernando', 'https://calendly.com/fernando-tan', 'active'),
(9, 48, 'CG0009', 'garcia', 'isabela', 'https://calendly.com/isabela-garcia', 'active');

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
  `created_at` datetime DEFAULT NULL,
  `is_active` enum('0','1','-1') NOT NULL DEFAULT '0',
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `academic_year` varchar(9) NOT NULL DEFAULT '2024-2025'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`form_index`, `form_name`, `description`, `created_at`, `is_active`, `is_required`, `academic_year`) VALUES
(1, 'Client Consent and Concern From', 'This form would only take 15- 20 minutes of your time.\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.', '2025-04-30 05:28:30', '1', 1, '2024-2025'),
(6, 'dfgdg', 'dfgdf', NULL, '-1', 0, '2024-2025'),
(7, 'sdfsdfdf', 'sfdfsdf', NULL, '-1', 0, '2024-2025'),
(8, 'Counseling Service Evaluation Form', 'COUNSELING SERVICE EVALUATION\n\nIn order for us to continuously evaluate and improve our counseling services, we would like to get feedback from you on your experience in your counseling session.', NULL, '1', 0, '2024-2025'),
(9, 'General Mental Health Screening', 'This form intends to determine your current mental health status based on your experience in the past two (2) weeks. This information would allow your counselor to better assist you with your concerns.\n\n*DSM-5-TR Self-Rated Level 1 Cross-Cutting Symptom Measure, American Psychiatric Association', NULL, '1', 1, '2024-2025'),
(10, 'Student Individual Inventory', 'This form would only take 15- 20 minutes of your time.\n\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.', NULL, '1', 1, '2024-2025'),
(11, 'EXIT INTERVIEW FORM', 'This form is designed for graduating students to evaluate various aspects of their academic and campus experience. It collects feedback on: Academic Quality (courses, faculty, resources), Campus Life (facilities, extracurriculars, support services), Career Preparation (internships, counseling, skill development), and Overall Satisfaction. Responses help the institution improve programs and services for future students.', NULL, '1', 0, '2024-2025');

-- --------------------------------------------------------

--
-- Table structure for table `form_sections`
--

CREATE TABLE `form_sections` (
  `form_section_index` int(11) NOT NULL,
  `form_index` int(11) NOT NULL,
  `section_title` varchar(255) NOT NULL,
  `section_description` text DEFAULT NULL,
  `section_order` int(11) NOT NULL,
  `behavior` enum('same-page','next-page') DEFAULT 'same-page'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_sections`
--

INSERT INTO `form_sections` (`form_section_index`, `form_index`, `section_title`, `section_description`, `section_order`, `behavior`) VALUES
(226, 6, 'Untitled Section', '', 0, 'same-page'),
(238, 7, 'Untitled Section', 'sfdsdfsdfsdf', 1, 'same-page'),
(271, 9, 'DATA PRIVACY NOTICE', 'All data indicated in this evaluation form are to be kept confidential in compliance with the Republic Act 10173 otherwise known as Data Privacy Act of 2012 and shall only be used for the purpose of assessing the students\'  general mental health. This form shall only be accessed by guidance counselors. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information.', 1, 'same-page'),
(277, 8, 'DATA PRIVACY NOTICE', 'All data indicated in this evaluation form are to be kept confidential in compliance with the Republic Act 10173 otherwise known as Data Privacy Act of 2012 and shall only be used for the purpose of evaluating the student experience in counseling. This form shall only be accessed by guidance counselors. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information.', 1, 'same-page'),
(278, 8, 'Counseling Services Evaluation', '', 2, 'next-page'),
(284, 10, 'College Guidance and Counseling Center - Student Individual Inventory 2024-2025', '', 1, 'same-page'),
(285, 10, 'Personal Information', '', 2, 'same-page'),
(286, 10, 'College Varsity', '', 3, 'next-page'),
(287, 10, 'Family and Home', '', 4, 'same-page'),
(288, 10, 'College Guidance and Counseling Center', '', 5, 'next-page'),
(294, 1, 'Consent', 'This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).', 1, 'same-page'),
(295, 1, 'DETAILED CONCERNS', 'The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.', 2, 'same-page'),
(296, 1, 'CLIENT CONSENT FORM', 'This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains informalion about the counseling service and the agreement between the counselor and the student.\n\nAPPOINTMENT\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\n\nCOUNSELING and ASSESSMENT\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor’s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\n\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\n\nRISKS\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\n\nCOUNSELOR CONTACT INFORMATION\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.', 3, 'next-page'),
(297, 1, 'CONFIDENTIALITY and RELEASE of INFORMATION', 'Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\n\nThe exceptions to confidentiality include:\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and/or potential victims.\n\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\n\nWe are required to release your records if they are subpoenaed by a court of law.\n\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\n\nIf you provide us with a request to release your records\n\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\n\nIf you are a child/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.', 4, 'same-page'),
(298, 1, 'USE of CLIENT INFORMATION on OUTCOME RESEARCH', '', 5, 'same-page'),
(299, 11, 'EXIT INTERVIEW FORM', '', 0, 'same-page');

-- --------------------------------------------------------

--
-- Table structure for table `form_snapshots`
--

CREATE TABLE `form_snapshots` (
  `snapshot_index` int(11) NOT NULL,
  `snapshot_data` longtext DEFAULT NULL,
  `form_index` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_snapshots`
--

INSERT INTO `form_snapshots` (`snapshot_index`, `snapshot_data`, `form_index`, `created_at`, `is_active`) VALUES
(56, '{\"form_index\":10,\"form_name\":\"Student Individual Inventory\",\"description\":\"\",\"sections\":[{\"id\":279,\"title\":\"College Guidance and Counseling Center - Student Individual Inventory 2024-2025\",\"description\":\"\",\"order\":0,\"behavior\":\"same-page\",\"questions\":[848]},{\"id\":280,\"title\":\"Personal Information\",\"description\":\"\",\"order\":1,\"behavior\":\"same-page\",\"questions\":[849,850,851,852,853,854,855,856,857,858,859,860,861,862]},{\"id\":281,\"title\":\"College Varsity\",\"description\":\"\",\"order\":2,\"behavior\":\"next-page\",\"questions\":[863]},{\"id\":282,\"title\":\"Family and Home\",\"description\":\"\",\"order\":3,\"behavior\":\"same-page\",\"questions\":[864,865,866,867,868,869,870,871,872,873,874,875,876,877,878,879,880]},{\"id\":283,\"title\":\"College Guidance and Counseling Center\",\"description\":\"\",\"order\":4,\"behavior\":\"next-page\",\"questions\":[881,882,883]}],\"questions\":[{\"id\":848,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"display\",\"subtype\":null,\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":279},{\"id\":849,\"question\":\"Nickname\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":850,\"question\":\"Last school attended during SHS                              \\n2nd Year - 5th Year College students, Put N\\/A\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":851,\"question\":\"Birthday\",\"type\":\"date\",\"subtype\":null,\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":852,\"question\":\"Age\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":853,\"question\":\"Nationality\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":854,\"question\":\"Personal Mobile Number\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":855,\"question\":\"Home Landline Phone Number (Area Code & Phone Number)\",\"type\":\"short\",\"subtype\":\"\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":856,\"question\":\"COMPLETE PERMANENT ADDRESS (House Number, Block No., Lot No., Street, Subdivision, Barangay, City\\/Municipality, Province)\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":857,\"question\":\"COMPLETE \\\"PRESENT ADDRESS\\\" (if living in apartment, dormitory etc.) Put N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":858,\"question\":\"Name of Landlord\\/Landlady \\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":859,\"question\":\"Religion\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":280},{\"id\":860,\"question\":\"Sex at birth\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4757,\"choice_text\":\"Male\"},{\"choice_index\":4758,\"choice_text\":\"Female\"}],\"rows\":[],\"form_section_index\":280},{\"id\":861,\"question\":\"To which gender identity do you most identify?\",\"type\":\"dropdown\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4759,\"choice_text\":\"Female\"},{\"choice_index\":4760,\"choice_text\":\"Male\"},{\"choice_index\":4761,\"choice_text\":\"Transgender\"},{\"choice_index\":4762,\"choice_text\":\"Gender neutral\"},{\"choice_index\":4763,\"choice_text\":\"Non-binary\"},{\"choice_index\":4764,\"choice_text\":\"Agender\"},{\"choice_index\":4765,\"choice_text\":\"Pangender\"},{\"choice_index\":4766,\"choice_text\":\"Genderqueer\"},{\"choice_index\":4767,\"choice_text\":\"Two-spirit\"},{\"choice_index\":4768,\"choice_text\":\"Third gender\"},{\"choice_index\":4769,\"choice_text\":\"Prefer to self-describe\"},{\"choice_index\":4770,\"choice_text\":\"Prefer not to say\"},{\"choice_index\":4771,\"choice_text\":\"A gender not listed\"}],\"rows\":[],\"form_section_index\":280},{\"id\":862,\"question\":\"Current Status\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4772,\"choice_text\":\"Single\"},{\"choice_index\":4773,\"choice_text\":\"Married WIHT child\\/children\"},{\"choice_index\":4774,\"choice_text\":\"Married WITHOUT child\\/children\"},{\"choice_index\":4775,\"choice_text\":\"Living with Partner WITH child\\/children\"},{\"choice_index\":4776,\"choice_text\":\"Living with Partner WITHOUT child\\/children\"},{\"choice_index\":4777,\"choice_text\":\"Single Parent\"}],\"rows\":[],\"form_section_index\":280},{\"id\":863,\"question\":\"Are you a college student varsity?\",\"type\":\"dropdown\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4778,\"choice_text\":\"No\"},{\"choice_index\":4779,\"choice_text\":\"Yes\"}],\"rows\":[],\"form_section_index\":281},{\"id\":864,\"question\":\"Are your parents working abroad?\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4780,\"choice_text\":\"Father only\"},{\"choice_index\":4781,\"choice_text\":\"Mother only\"},{\"choice_index\":4782,\"choice_text\":\"Both parents\"},{\"choice_index\":4783,\"choice_text\":\"No. I do not have an OFW parent\"}],\"rows\":[],\"form_section_index\":282},{\"id\":865,\"question\":\"Father\'s Complete Name (Last Name, First Name M.I)\\nWrite \\\"D\\\" if deceased and \\\"NI\\\" if no information\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":866,\"question\":\"Occupation\\/Business of Father\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":867,\"question\":\"Father\'s Cellphone Number\",\"type\":\"short\",\"subtype\":\"\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":868,\"question\":\"Father\'s email address\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":869,\"question\":\"If father is OFW (what country)\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":870,\"question\":\"Mother\'s Complete Name (Last Name, First Name M.I.)\\nWrite \\\"D\\\" if deceased and \\\"NI\\\" if no information\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":871,\"question\":\"Occupation\\/Business of Mother\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":872,\"question\":\"Mother\'s Cellphone Number\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":873,\"question\":\"Mother\'s email address\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":874,\"question\":\"If mother is OFW (what country)\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":875,\"question\":\"Parents are?\\nThis portion will be treated with utmost confidentiality, please answer with all honesty\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4784,\"choice_text\":\"Married and living together\"},{\"choice_index\":4785,\"choice_text\":\"Permanently separated\"},{\"choice_index\":4786,\"choice_text\":\"Marriage annulled\"},{\"choice_index\":4787,\"choice_text\":\"Legally separated\"},{\"choice_index\":4788,\"choice_text\":\"Father w\\/ another partner\"},{\"choice_index\":4789,\"choice_text\":\"Mother w\\/ another partner\"},{\"choice_index\":4790,\"choice_text\":\"Temporarily separated\"},{\"choice_index\":4791,\"choice_text\":\"Father is deceased\"},{\"choice_index\":4792,\"choice_text\":\"Mother is deceased\"},{\"choice_index\":4793,\"choice_text\":\"Other\"}],\"rows\":[],\"form_section_index\":282},{\"id\":876,\"question\":\"Guardian\'s Name\\nContact person other than parents. Put N\\/A if not applicable.\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":877,\"question\":\"Relationship to Guardian (e.g. uncle, aunt, grandmother, family friend, etc.)\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":878,\"question\":\"Guardian\'s Contact Number\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":282},{\"id\":879,\"question\":\"Living arrangement\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4794,\"choice_text\":\"Own House (with parents)\"},{\"choice_index\":4795,\"choice_text\":\"Own house (without parents\\/guardian)\"},{\"choice_index\":4796,\"choice_text\":\"Renting with parents\\/relatives (boarding house, dormitory, apartment)\"},{\"choice_index\":4797,\"choice_text\":\"Renting Alone (boarding house, dormitory, apartment)\"},{\"choice_index\":4798,\"choice_text\":\"Living with relatives\"},{\"choice_index\":4799,\"choice_text\":\"Other\"}],\"rows\":[],\"form_section_index\":282},{\"id\":880,\"question\":\"Have you received therapy, counseling, or mental health treatment in the past?\",\"type\":\"dropdown\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4800,\"choice_text\":\"No\"},{\"choice_index\":4801,\"choice_text\":\"Yes\"}],\"rows\":[],\"form_section_index\":282},{\"id\":881,\"question\":\"Scholarship Category\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4802,\"choice_text\":\"No Scholarship\"},{\"choice_index\":4803,\"choice_text\":\"Academic Scholarship\"},{\"choice_index\":4804,\"choice_text\":\"Clerical Assistant\"},{\"choice_index\":4805,\"choice_text\":\"Brother Gregory Refuerzo Scholarship Grants Program (c\\/o Lasallian Partners)\"},{\"choice_index\":4806,\"choice_text\":\"Miguel Febres Cordero Scholarship (FEBRES)\"},{\"choice_index\":4807,\"choice_text\":\"PD577\"},{\"choice_index\":4808,\"choice_text\":\"Br. Henry Virgil Scholarship (ATHLETES)\"},{\"choice_index\":4809,\"choice_text\":\"Privately Funded Scholarship\"}],\"rows\":[],\"form_section_index\":283},{\"id\":882,\"question\":\"Other persons who financially support you\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":283},{\"id\":883,\"question\":\"Hobbies\\/interests\",\"type\":\"short\",\"subtype\":\"\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":283}],\"timestamp\":\"2025-05-31T06:42:17+02:00\"}', 10, '2025-05-31 04:42:17', 0),
(57, '{\"form_index\":10,\"form_name\":\"Student Individual Inventory\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"id\":284,\"title\":\"College Guidance and Counseling Center - Student Individual Inventory 2024-2025\",\"description\":\"\",\"order\":1,\"behavior\":\"same-page\",\"questions\":[884]},{\"id\":285,\"title\":\"Personal Information\",\"description\":\"\",\"order\":2,\"behavior\":\"same-page\",\"questions\":[885,886,887,888,889,890,891,892,893,894,895,896,897,898]},{\"id\":286,\"title\":\"College Varsity\",\"description\":\"\",\"order\":3,\"behavior\":\"next-page\",\"questions\":[899]},{\"id\":287,\"title\":\"Family and Home\",\"description\":\"\",\"order\":4,\"behavior\":\"same-page\",\"questions\":[900,901,902,903,904,905,906,907,908,909,910,911,912,913,914,915,916]},{\"id\":288,\"title\":\"College Guidance and Counseling Center\",\"description\":\"\",\"order\":5,\"behavior\":\"next-page\",\"questions\":[917,918,919]}],\"questions\":[{\"id\":884,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"display\",\"subtype\":null,\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":284},{\"id\":885,\"question\":\"Nickname\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":886,\"question\":\"Last school attended during SHS                              \\n2nd Year - 5th Year College students, Put N\\/A\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":887,\"question\":\"Birthday\",\"type\":\"date\",\"subtype\":null,\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":888,\"question\":\"Age\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":889,\"question\":\"Nationality\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":890,\"question\":\"Personal Mobile Number\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":891,\"question\":\"Home Landline Phone Number (Area Code & Phone Number)\",\"type\":\"short\",\"subtype\":\"text\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":892,\"question\":\"COMPLETE PERMANENT ADDRESS (House Number, Block No., Lot No., Street, Subdivision, Barangay, City\\/Municipality, Province)\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":893,\"question\":\"COMPLETE \\\"PRESENT ADDRESS\\\" (if living in apartment, dormitory etc.) Put N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":894,\"question\":\"Name of Landlord\\/Landlady \\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":895,\"question\":\"Religion\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":285},{\"id\":896,\"question\":\"Sex at birth\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4810,\"choice_text\":\"Male\"},{\"choice_index\":4811,\"choice_text\":\"Female\"}],\"rows\":[],\"form_section_index\":285},{\"id\":897,\"question\":\"To which gender identity do you most identify?\",\"type\":\"dropdown\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4812,\"choice_text\":\"Female\"},{\"choice_index\":4813,\"choice_text\":\"Male\"},{\"choice_index\":4814,\"choice_text\":\"Transgender\"},{\"choice_index\":4815,\"choice_text\":\"Gender neutral\"},{\"choice_index\":4816,\"choice_text\":\"Non-binary\"},{\"choice_index\":4817,\"choice_text\":\"Agender\"},{\"choice_index\":4818,\"choice_text\":\"Pangender\"},{\"choice_index\":4819,\"choice_text\":\"Genderqueer\"},{\"choice_index\":4820,\"choice_text\":\"Two-spirit\"},{\"choice_index\":4821,\"choice_text\":\"Third gender\"},{\"choice_index\":4822,\"choice_text\":\"Prefer to self-describe\"},{\"choice_index\":4823,\"choice_text\":\"Prefer not to say\"},{\"choice_index\":4824,\"choice_text\":\"A gender not listed\"}],\"rows\":[],\"form_section_index\":285},{\"id\":898,\"question\":\"Current Status\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4825,\"choice_text\":\"Single\"},{\"choice_index\":4826,\"choice_text\":\"Married WIHT child\\/children\"},{\"choice_index\":4827,\"choice_text\":\"Married WITHOUT child\\/children\"},{\"choice_index\":4828,\"choice_text\":\"Living with Partner WITH child\\/children\"},{\"choice_index\":4829,\"choice_text\":\"Living with Partner WITHOUT child\\/children\"},{\"choice_index\":4830,\"choice_text\":\"Single Parent\"}],\"rows\":[],\"form_section_index\":285},{\"id\":899,\"question\":\"Are you a college student varsity?\",\"type\":\"dropdown\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4831,\"choice_text\":\"No\"},{\"choice_index\":4832,\"choice_text\":\"Yes\"}],\"rows\":[],\"form_section_index\":286},{\"id\":900,\"question\":\"Are your parents working abroad?\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4833,\"choice_text\":\"Father only\"},{\"choice_index\":4834,\"choice_text\":\"Mother only\"},{\"choice_index\":4835,\"choice_text\":\"Both parents\"},{\"choice_index\":4836,\"choice_text\":\"No. I do not have an OFW parent\"}],\"rows\":[],\"form_section_index\":287},{\"id\":901,\"question\":\"Father\'s Complete Name (Last Name, First Name M.I)\\nWrite \\\"D\\\" if deceased and \\\"NI\\\" if no information\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":902,\"question\":\"Occupation\\/Business of Father\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":903,\"question\":\"Father\'s Cellphone Number\",\"type\":\"short\",\"subtype\":\"text\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":904,\"question\":\"Father\'s email address\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":905,\"question\":\"If father is OFW (what country)\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":906,\"question\":\"Mother\'s Complete Name (Last Name, First Name M.I.)\\nWrite \\\"D\\\" if deceased and \\\"NI\\\" if no information\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":907,\"question\":\"Occupation\\/Business of Mother\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":908,\"question\":\"Mother\'s Cellphone Number\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":909,\"question\":\"Mother\'s email address\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":910,\"question\":\"If mother is OFW (what country)\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":911,\"question\":\"Parents are?\\nThis portion will be treated with utmost confidentiality, please answer with all honesty\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4837,\"choice_text\":\"Married and living together\"},{\"choice_index\":4838,\"choice_text\":\"Permanently separated\"},{\"choice_index\":4839,\"choice_text\":\"Marriage annulled\"},{\"choice_index\":4840,\"choice_text\":\"Legally separated\"},{\"choice_index\":4841,\"choice_text\":\"Father w\\/ another partner\"},{\"choice_index\":4842,\"choice_text\":\"Mother w\\/ another partner\"},{\"choice_index\":4843,\"choice_text\":\"Temporarily separated\"},{\"choice_index\":4844,\"choice_text\":\"Father is deceased\"},{\"choice_index\":4845,\"choice_text\":\"Mother is deceased\"},{\"choice_index\":4846,\"choice_text\":\"Other\"}],\"rows\":[],\"form_section_index\":287},{\"id\":912,\"question\":\"Guardian\'s Name\\nContact person other than parents. Put N\\/A if not applicable.\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":913,\"question\":\"Relationship to Guardian (e.g. uncle, aunt, grandmother, family friend, etc.)\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":914,\"question\":\"Guardian\'s Contact Number\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":287},{\"id\":915,\"question\":\"Living arrangement\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4847,\"choice_text\":\"Own House (with parents)\"},{\"choice_index\":4848,\"choice_text\":\"Own house (without parents\\/guardian)\"},{\"choice_index\":4849,\"choice_text\":\"Renting with parents\\/relatives (boarding house, dormitory, apartment)\"},{\"choice_index\":4850,\"choice_text\":\"Renting Alone (boarding house, dormitory, apartment)\"},{\"choice_index\":4851,\"choice_text\":\"Living with relatives\"},{\"choice_index\":4852,\"choice_text\":\"Other\"}],\"rows\":[],\"form_section_index\":287},{\"id\":916,\"question\":\"Have you received therapy, counseling, or mental health treatment in the past?\",\"type\":\"dropdown\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4853,\"choice_text\":\"No\"},{\"choice_index\":4854,\"choice_text\":\"Yes\"}],\"rows\":[],\"form_section_index\":287},{\"id\":917,\"question\":\"Scholarship Category\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4855,\"choice_text\":\"No Scholarship\"},{\"choice_index\":4856,\"choice_text\":\"Academic Scholarship\"},{\"choice_index\":4857,\"choice_text\":\"Clerical Assistant\"},{\"choice_index\":4858,\"choice_text\":\"Brother Gregory Refuerzo Scholarship Grants Program (c\\/o Lasallian Partners)\"},{\"choice_index\":4859,\"choice_text\":\"Miguel Febres Cordero Scholarship (FEBRES)\"},{\"choice_index\":4860,\"choice_text\":\"PD577\"},{\"choice_index\":4861,\"choice_text\":\"Br. Henry Virgil Scholarship (ATHLETES)\"},{\"choice_index\":4862,\"choice_text\":\"Privately Funded Scholarship\"}],\"rows\":[],\"form_section_index\":288},{\"id\":918,\"question\":\"Other persons who financially support you\\nPut N\\/A if not applicable\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":288},{\"id\":919,\"question\":\"Hobbies\\/interests\",\"type\":\"short\",\"subtype\":\"text\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":288}],\"timestamp\":\"2025-05-31T07:07:05+02:00\"}', 10, '2025-05-31 05:07:05', 1),
(58, '{\"form_index\":1,\"form_name\":\"Client Consent and Concern From\",\"description\":\"This form would only take 15- 20 minutes of your time.\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"id\":289,\"title\":\"Consent\",\"description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"order\":1,\"behavior\":\"same-page\",\"questions\":[920]},{\"id\":290,\"title\":\"DETAILED CONCERNS\",\"description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"order\":2,\"behavior\":\"same-page\",\"questions\":[921,922,923,924,925,926,927,928,929]},{\"id\":291,\"title\":\"CLIENT CONSENT FORM\",\"description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains informalion about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"order\":3,\"behavior\":\"next-page\",\"questions\":[]},{\"id\":292,\"title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"order\":4,\"behavior\":\"same-page\",\"questions\":[930,931,932]},{\"id\":293,\"title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"description\":\"\",\"order\":5,\"behavior\":\"same-page\",\"questions\":[933,934,935]}],\"questions\":[{\"id\":920,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4863,\"choice_text\":\"Yes\"}],\"rows\":[],\"form_section_index\":289},{\"id\":921,\"question\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4864,\"choice_text\":\"Adjusting to change\"},{\"choice_index\":4865,\"choice_text\":\"Experiencing Bullying\\/Discrimination\"},{\"choice_index\":4866,\"choice_text\":\"Struggling with Relationship Problems\"},{\"choice_index\":4867,\"choice_text\":\"Issues with self-image\"},{\"choice_index\":4868,\"choice_text\":\"Concerns about sexuality\\/gender identity\"},{\"choice_index\":4869,\"choice_text\":\"Finding it difficult to express one\'s thoughts\\/feelings\"},{\"choice_index\":4870,\"choice_text\":\"Struggling in getting along with others\\/making friends\"},{\"choice_index\":4871,\"choice_text\":\"Spiritual\\/Religious issues\"},{\"choice_index\":4872,\"choice_text\":\"Lack of decision making skills\"},{\"choice_index\":4873,\"choice_text\":\"Lack of social support\"},{\"choice_index\":4874,\"choice_text\":\"Lacking of self-confidence\"},{\"choice_index\":4875,\"choice_text\":\"Lacks effective communication skills\"},{\"choice_index\":4876,\"choice_text\":\"Need to develop leadership skills\"},{\"choice_index\":4877,\"choice_text\":\"Need to have better self-concept\"},{\"choice_index\":4878,\"choice_text\":\"Experiencing harassment\"},{\"choice_index\":4879,\"choice_text\":\"Trust issue\"},{\"choice_index\":4880,\"choice_text\":\"Feeling very strong emotions\"},{\"choice_index\":4881,\"choice_text\":\"No social\\/emotional concern\"}],\"rows\":[],\"form_section_index\":290},{\"id\":922,\"question\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4882,\"choice_text\":\"Absence of father\\/mother\"},{\"choice_index\":4883,\"choice_text\":\"Dealing with a loss\"},{\"choice_index\":4884,\"choice_text\":\"Feeling of being unloved\"},{\"choice_index\":4885,\"choice_text\":\"Financial difficulties\"},{\"choice_index\":4886,\"choice_text\":\"Struggling with parents\\u2019 marital conflicts\\/separationz\"},{\"choice_index\":4887,\"choice_text\":\"Health of a family member\"},{\"choice_index\":4888,\"choice_text\":\"Home environment is not conducive to study\"},{\"choice_index\":4889,\"choice_text\":\"Homesickness\\/Living away from home\"},{\"choice_index\":4890,\"choice_text\":\"Lacking parents\' appreciation\"},{\"choice_index\":4891,\"choice_text\":\"Not getting along well with a family member\\/relative\"},{\"choice_index\":4892,\"choice_text\":\"Feeling pressured by high expectations from parents\\/family\"},{\"choice_index\":4893,\"choice_text\":\"Feeling invalidated by family members\"},{\"choice_index\":4894,\"choice_text\":\"Concerned about the health of a family member\"},{\"choice_index\":4895,\"choice_text\":\"Too many responsibilities at home\"},{\"choice_index\":4896,\"choice_text\":\"No Family\\/Home Concern\"}],\"rows\":[],\"form_section_index\":290},{\"id\":923,\"question\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4897,\"choice_text\":\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\"},{\"choice_index\":4898,\"choice_text\":\"Difficulty in managing emotions\"},{\"choice_index\":4899,\"choice_text\":\"Feeling burned out\"},{\"choice_index\":4900,\"choice_text\":\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\"},{\"choice_index\":4901,\"choice_text\":\"Having a physical illness that needs medical attention\"},{\"choice_index\":4902,\"choice_text\":\"Racing thoughts\"},{\"choice_index\":4903,\"choice_text\":\"Overthinking \\/ Anxiety\"},{\"choice_index\":4904,\"choice_text\":\"Having panic attacks\"},{\"choice_index\":4905,\"choice_text\":\"Experiencing stress\"},{\"choice_index\":4906,\"choice_text\":\"Difficulty coping with stress\"},{\"choice_index\":4907,\"choice_text\":\"Deep feelings of sadness\"},{\"choice_index\":4908,\"choice_text\":\"Self-harm behavior (cutting, scratching, burning, etc.)\"},{\"choice_index\":4909,\"choice_text\":\"Erratic sleeping patterns\"},{\"choice_index\":4910,\"choice_text\":\"Suicidal thoughts\"},{\"choice_index\":4911,\"choice_text\":\"Suicide attempt\"},{\"choice_index\":4912,\"choice_text\":\"Difficulty concentrating\\/being more forgetful\"},{\"choice_index\":4913,\"choice_text\":\"Avoiding people, situations, or responsibilities\"},{\"choice_index\":4914,\"choice_text\":\"Unable to enjoy\\/loss of interest in activities\"},{\"choice_index\":4915,\"choice_text\":\"Feeling empty\\/Not feeling anything\"},{\"choice_index\":4916,\"choice_text\":\"Increased irritability\"},{\"choice_index\":4917,\"choice_text\":\"Crying spells\"},{\"choice_index\":4918,\"choice_text\":\"Changes in appetite (eating more or less)\"},{\"choice_index\":4919,\"choice_text\":\"No Mental\\/Physical Health Concerns\"}],\"rows\":[],\"form_section_index\":290},{\"id\":924,\"question\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4920,\"choice_text\":\"Difficulty in adjusting to learning modality\"},{\"choice_index\":4921,\"choice_text\":\"Difficulty in meeting academic requirements\"},{\"choice_index\":4922,\"choice_text\":\"Difficulty working independently\"},{\"choice_index\":4923,\"choice_text\":\"Difficulty working in a group\\/pair\"},{\"choice_index\":4924,\"choice_text\":\"Dissatisfaction with academic performance\\/grades\"},{\"choice_index\":4925,\"choice_text\":\"Lacking effective study habits (note-taking, time management)\"},{\"choice_index\":4926,\"choice_text\":\"Difficulty overcoming distractions\"},{\"choice_index\":4927,\"choice_text\":\"Lacking motivation\"},{\"choice_index\":4928,\"choice_text\":\"Struggling with procrastination\"},{\"choice_index\":4929,\"choice_text\":\"Struggling to balance academics with extracurricular\\/non-academic activities\"},{\"choice_index\":4930,\"choice_text\":\"Test anxiety\"},{\"choice_index\":4931,\"choice_text\":\"No Academic concern\"}],\"rows\":[],\"form_section_index\":290},{\"id\":925,\"question\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4932,\"choice_text\":\"Favoritism\\/ unfair treatment\"},{\"choice_index\":4933,\"choice_text\":\"Inadequate background knowledge about the subjects\"},{\"choice_index\":4934,\"choice_text\":\"Unavailable most of the time\"},{\"choice_index\":4935,\"choice_text\":\"Difficult to reach or communicate with\"},{\"choice_index\":4936,\"choice_text\":\"Unethical\\/unprofessional behavior\"},{\"choice_index\":4937,\"choice_text\":\"Does not provide timely feedback\"},{\"choice_index\":4938,\"choice_text\":\"No Professor issues\\/concerns\"}],\"rows\":[],\"form_section_index\":290},{\"id\":926,\"question\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4939,\"choice_text\":\"Uncertainty about career choice\\/ wanting to shift to another program\"},{\"choice_index\":4940,\"choice_text\":\"Career choice is limited by financial resources\"},{\"choice_index\":4941,\"choice_text\":\"Unaware of strengths, abilities, or interests\"},{\"choice_index\":4942,\"choice_text\":\"Feeling lost and overwhelmed about making a career decision\"},{\"choice_index\":4943,\"choice_text\":\"Feeling pressured by peers\\/family to succeed\"},{\"choice_index\":4944,\"choice_text\":\"Need help with career planning\"},{\"choice_index\":4945,\"choice_text\":\"Dissatisfied with the present college program\"},{\"choice_index\":4946,\"choice_text\":\"Anxious about the future\\/world of work\"},{\"choice_index\":4947,\"choice_text\":\"No Career concern\"}],\"rows\":[],\"form_section_index\":290},{\"id\":927,\"question\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4948,\"choice_text\":\"Yes\"},{\"choice_index\":4949,\"choice_text\":\"No\"}],\"rows\":[],\"form_section_index\":290},{\"id\":928,\"question\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":290},{\"id\":929,\"question\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4950,\"choice_text\":\"I Certify\"}],\"rows\":[],\"form_section_index\":290},{\"id\":930,\"question\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4951,\"choice_text\":\"Agree\"},{\"choice_index\":4952,\"choice_text\":\"Disagree\"}],\"rows\":[],\"form_section_index\":292},{\"id\":931,\"question\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":292},{\"id\":932,\"question\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":292},{\"id\":933,\"question\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4953,\"choice_text\":\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\"},{\"choice_index\":4954,\"choice_text\":\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"}],\"rows\":[],\"form_section_index\":293},{\"id\":934,\"question\":\"Counseling Guidelines\\nPlease review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide\\nBy accomplishing this form you understand and agree to the guidelines set by CGCC.\",\"type\":\"display\",\"subtype\":null,\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":293},{\"id\":935,\"question\":\"This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"short\",\"subtype\":\"text\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":293}],\"timestamp\":\"2025-05-31T07:19:26+02:00\"}', 1, '2025-05-31 05:19:26', 0);
INSERT INTO `form_snapshots` (`snapshot_index`, `snapshot_data`, `form_index`, `created_at`, `is_active`) VALUES
(59, '{\"form_index\":1,\"form_name\":\"Client Consent and Concern From\",\"description\":\"This form would only take 15- 20 minutes of your time.\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"id\":294,\"title\":\"Consent\",\"description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"order\":1,\"behavior\":\"same-page\",\"questions\":[936]},{\"id\":295,\"title\":\"DETAILED CONCERNS\",\"description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"order\":2,\"behavior\":\"same-page\",\"questions\":[937,938,939,940,941,942,943,944,945]},{\"id\":296,\"title\":\"CLIENT CONSENT FORM\",\"description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains informalion about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"order\":3,\"behavior\":\"next-page\",\"questions\":[]},{\"id\":297,\"title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"order\":4,\"behavior\":\"same-page\",\"questions\":[946,947,948]},{\"id\":298,\"title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"description\":\"\",\"order\":5,\"behavior\":\"same-page\",\"questions\":[949,950,951]}],\"questions\":[{\"id\":936,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4955,\"choice_text\":\"Yes\"}],\"rows\":[],\"form_section_index\":294},{\"id\":937,\"question\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4956,\"choice_text\":\"Adjusting to change\"},{\"choice_index\":4957,\"choice_text\":\"Experiencing Bullying\\/Discrimination\"},{\"choice_index\":4958,\"choice_text\":\"Struggling with Relationship Problems\"},{\"choice_index\":4959,\"choice_text\":\"Issues with self-image\"},{\"choice_index\":4960,\"choice_text\":\"Concerns about sexuality\\/gender identity\"},{\"choice_index\":4961,\"choice_text\":\"Finding it difficult to express one\'s thoughts\\/feelings\"},{\"choice_index\":4962,\"choice_text\":\"Struggling in getting along with others\\/making friends\"},{\"choice_index\":4963,\"choice_text\":\"Spiritual\\/Religious issues\"},{\"choice_index\":4964,\"choice_text\":\"Lack of decision making skills\"},{\"choice_index\":4965,\"choice_text\":\"Lack of social support\"},{\"choice_index\":4966,\"choice_text\":\"Lacking of self-confidence\"},{\"choice_index\":4967,\"choice_text\":\"Lacks effective communication skills\"},{\"choice_index\":4968,\"choice_text\":\"Need to develop leadership skills\"},{\"choice_index\":4969,\"choice_text\":\"Need to have better self-concept\"},{\"choice_index\":4970,\"choice_text\":\"Experiencing harassment\"},{\"choice_index\":4971,\"choice_text\":\"Trust issue\"},{\"choice_index\":4972,\"choice_text\":\"Feeling very strong emotions\"},{\"choice_index\":4973,\"choice_text\":\"No social\\/emotional concern\"}],\"rows\":[],\"form_section_index\":295},{\"id\":938,\"question\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4974,\"choice_text\":\"Absence of father\\/mother\"},{\"choice_index\":4975,\"choice_text\":\"Dealing with a loss\"},{\"choice_index\":4976,\"choice_text\":\"Feeling of being unloved\"},{\"choice_index\":4977,\"choice_text\":\"Financial difficulties\"},{\"choice_index\":4978,\"choice_text\":\"Struggling with parents\\u2019 marital conflicts\\/separationz\"},{\"choice_index\":4979,\"choice_text\":\"Health of a family member\"},{\"choice_index\":4980,\"choice_text\":\"Home environment is not conducive to study\"},{\"choice_index\":4981,\"choice_text\":\"Homesickness\\/Living away from home\"},{\"choice_index\":4982,\"choice_text\":\"Lacking parents\' appreciation\"},{\"choice_index\":4983,\"choice_text\":\"Not getting along well with a family member\\/relative\"},{\"choice_index\":4984,\"choice_text\":\"Feeling pressured by high expectations from parents\\/family\"},{\"choice_index\":4985,\"choice_text\":\"Feeling invalidated by family members\"},{\"choice_index\":4986,\"choice_text\":\"Concerned about the health of a family member\"},{\"choice_index\":4987,\"choice_text\":\"Too many responsibilities at home\"},{\"choice_index\":4988,\"choice_text\":\"No Family\\/Home Concern\"}],\"rows\":[],\"form_section_index\":295},{\"id\":939,\"question\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":4989,\"choice_text\":\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\"},{\"choice_index\":4990,\"choice_text\":\"Difficulty in managing emotions\"},{\"choice_index\":4991,\"choice_text\":\"Feeling burned out\"},{\"choice_index\":4992,\"choice_text\":\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\"},{\"choice_index\":4993,\"choice_text\":\"Having a physical illness that needs medical attention\"},{\"choice_index\":4994,\"choice_text\":\"Racing thoughts\"},{\"choice_index\":4995,\"choice_text\":\"Overthinking \\/ Anxiety\"},{\"choice_index\":4996,\"choice_text\":\"Having panic attacks\"},{\"choice_index\":4997,\"choice_text\":\"Experiencing stress\"},{\"choice_index\":4998,\"choice_text\":\"Difficulty coping with stress\"},{\"choice_index\":4999,\"choice_text\":\"Deep feelings of sadness\"},{\"choice_index\":5000,\"choice_text\":\"Self-harm behavior (cutting, scratching, burning, etc.)\"},{\"choice_index\":5001,\"choice_text\":\"Erratic sleeping patterns\"},{\"choice_index\":5002,\"choice_text\":\"Suicidal thoughts\"},{\"choice_index\":5003,\"choice_text\":\"Suicide attempt\"},{\"choice_index\":5004,\"choice_text\":\"Difficulty concentrating\\/being more forgetful\"},{\"choice_index\":5005,\"choice_text\":\"Avoiding people, situations, or responsibilities\"},{\"choice_index\":5006,\"choice_text\":\"Unable to enjoy\\/loss of interest in activities\"},{\"choice_index\":5007,\"choice_text\":\"Feeling empty\\/Not feeling anything\"},{\"choice_index\":5008,\"choice_text\":\"Increased irritability\"},{\"choice_index\":5009,\"choice_text\":\"Crying spells\"},{\"choice_index\":5010,\"choice_text\":\"Changes in appetite (eating more or less)\"},{\"choice_index\":5011,\"choice_text\":\"No Mental\\/Physical Health Concerns\"}],\"rows\":[],\"form_section_index\":295},{\"id\":940,\"question\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5012,\"choice_text\":\"Difficulty in adjusting to learning modality\"},{\"choice_index\":5013,\"choice_text\":\"Difficulty in meeting academic requirements\"},{\"choice_index\":5014,\"choice_text\":\"Difficulty working independently\"},{\"choice_index\":5015,\"choice_text\":\"Difficulty working in a group\\/pair\"},{\"choice_index\":5016,\"choice_text\":\"Dissatisfaction with academic performance\\/grades\"},{\"choice_index\":5017,\"choice_text\":\"Lacking effective study habits (note-taking, time management)\"},{\"choice_index\":5018,\"choice_text\":\"Difficulty overcoming distractions\"},{\"choice_index\":5019,\"choice_text\":\"Lacking motivation\"},{\"choice_index\":5020,\"choice_text\":\"Struggling with procrastination\"},{\"choice_index\":5021,\"choice_text\":\"Struggling to balance academics with extracurricular\\/non-academic activities\"},{\"choice_index\":5022,\"choice_text\":\"Test anxiety\"},{\"choice_index\":5023,\"choice_text\":\"No Academic concern\"}],\"rows\":[],\"form_section_index\":295},{\"id\":941,\"question\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5024,\"choice_text\":\"Favoritism\\/ unfair treatment\"},{\"choice_index\":5025,\"choice_text\":\"Inadequate background knowledge about the subjects\"},{\"choice_index\":5026,\"choice_text\":\"Unavailable most of the time\"},{\"choice_index\":5027,\"choice_text\":\"Difficult to reach or communicate with\"},{\"choice_index\":5028,\"choice_text\":\"Unethical\\/unprofessional behavior\"},{\"choice_index\":5029,\"choice_text\":\"Does not provide timely feedback\"},{\"choice_index\":5030,\"choice_text\":\"No Professor issues\\/concerns\"}],\"rows\":[],\"form_section_index\":295},{\"id\":942,\"question\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5031,\"choice_text\":\"Uncertainty about career choice\\/ wanting to shift to another program\"},{\"choice_index\":5032,\"choice_text\":\"Career choice is limited by financial resources\"},{\"choice_index\":5033,\"choice_text\":\"Unaware of strengths, abilities, or interests\"},{\"choice_index\":5034,\"choice_text\":\"Feeling lost and overwhelmed about making a career decision\"},{\"choice_index\":5035,\"choice_text\":\"Feeling pressured by peers\\/family to succeed\"},{\"choice_index\":5036,\"choice_text\":\"Need help with career planning\"},{\"choice_index\":5037,\"choice_text\":\"Dissatisfied with the present college program\"},{\"choice_index\":5038,\"choice_text\":\"Anxious about the future\\/world of work\"},{\"choice_index\":5039,\"choice_text\":\"No Career concern\"}],\"rows\":[],\"form_section_index\":295},{\"id\":943,\"question\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5040,\"choice_text\":\"Yes\"},{\"choice_index\":5041,\"choice_text\":\"No\"}],\"rows\":[],\"form_section_index\":295},{\"id\":944,\"question\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":295},{\"id\":945,\"question\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5042,\"choice_text\":\"I Certify\"}],\"rows\":[],\"form_section_index\":295},{\"id\":946,\"question\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5043,\"choice_text\":\"Agree\"},{\"choice_index\":5044,\"choice_text\":\"Disagree\"}],\"rows\":[],\"form_section_index\":297},{\"id\":947,\"question\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":297},{\"id\":948,\"question\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"subtype\":\"text\",\"required\":true,\"options\":[],\"rows\":[],\"form_section_index\":297},{\"id\":949,\"question\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5045,\"choice_text\":\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\"},{\"choice_index\":5046,\"choice_text\":\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"}],\"rows\":[],\"form_section_index\":298},{\"id\":950,\"question\":\"Counseling Guidelines\\nPlease review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide\\nBy accomplishing this form you understand and agree to the guidelines set by CGCC.\",\"type\":\"display\",\"subtype\":null,\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":298},{\"id\":951,\"question\":\"This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"display\",\"subtype\":null,\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":298}],\"timestamp\":\"2025-05-31T07:19:39+02:00\"}', 1, '2025-05-31 05:19:39', 1),
(60, '{\"form_index\":11,\"form_name\":\"EXIT INTERVIEW FORM\",\"description\":\"\",\"academic_year\":\"2024-2025\",\"sections\":[{\"id\":299,\"title\":\"EXIT INTERVIEW FORM\",\"description\":\"\",\"order\":0,\"behavior\":\"same-page\",\"questions\":[952,953,954,955,956,957,958,959]}],\"questions\":[{\"id\":952,\"question\":\"How would you evaluate the overall quality of your college experience at De La Salle Lipa?\",\"type\":\"multiple\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5047,\"choice_text\":\"Very Good\"},{\"choice_index\":5048,\"choice_text\":\"Good\"},{\"choice_index\":5049,\"choice_text\":\"Poor\"},{\"choice_index\":5050,\"choice_text\":\"Very Poor\"}],\"rows\":[],\"form_section_index\":299},{\"id\":953,\"question\":\"How satisfied are you with the following aspects that De La Salle Lipa has provided?\",\"type\":\"grid\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5051,\"choice_text\":\"Very Satisfied\"},{\"choice_index\":5052,\"choice_text\":\"Satisfied\"},{\"choice_index\":5053,\"choice_text\":\"Dissatisfied\"},{\"choice_index\":5054,\"choice_text\":\"Not Satisfied\"},{\"choice_index\":5055,\"choice_text\":\"N\\/A\"}],\"rows\":[{\"sub_question_index\":99,\"sub_question_text\":\"Teachers\"},{\"sub_question_index\":100,\"sub_question_text\":\"Curriculum\"},{\"sub_question_index\":101,\"sub_question_text\":\"Quality of academic advising\"},{\"sub_question_index\":102,\"sub_question_text\":\"Quality of teaching modules\"},{\"sub_question_index\":103,\"sub_question_text\":\"Quality of practice\\/OJT opportunities (e.g. facilitating access to internships))\"},{\"sub_question_index\":104,\"sub_question_text\":\"Overall usefulness of De La Salle Lipa’s website\"},{\"sub_question_index\":105,\"sub_question_text\":\"Quality of library resources and services\"},{\"sub_question_index\":106,\"sub_question_text\":\"Quality of enrollment process and services\"},{\"sub_question_index\":107,\"sub_question_text\":\"Quality of payment process\"},{\"sub_question_index\":108,\"sub_question_text\":\"Viewing of grades\"},{\"sub_question_index\":109,\"sub_question_text\":\"Quality of services in acquiring copy of student records (e.g. copy of grades etc.)\"},{\"sub_question_index\":110,\"sub_question_text\":\"Overall value of the education with respect to tuition fee\"},{\"sub_question_index\":111,\"sub_question_text\":\"Quality of online academic-related engagements with students\"},{\"sub_question_index\":112,\"sub_question_text\":\"Quality of activities of student organizations\"},{\"sub_question_index\":113,\"sub_question_text\":\"Quality of student government plans and programs\"},{\"sub_question_index\":114,\"sub_question_text\":\"Campus safety and security services\"},{\"sub_question_index\":115,\"sub_question_text\":\"Student Formation and Discipline Office services\"},{\"sub_question_index\":116,\"sub_question_text\":\"Institutional Lasallian Formation Office (ILFO) services\"},{\"sub_question_index\":117,\"sub_question_text\":\"Lasallian Assistance Management Program (LAMP) services\"},{\"sub_question_index\":118,\"sub_question_text\":\"Quality of Institutional Health Services (Clinic)\"},{\"sub_question_index\":119,\"sub_question_text\":\"College Guidance and Counseling Center services\"},{\"sub_question_index\":99,\"sub_question_text\":\"Teachers\"},{\"sub_question_index\":100,\"sub_question_text\":\"Curriculum\"},{\"sub_question_index\":101,\"sub_question_text\":\"Quality of academic advising\"},{\"sub_question_index\":102,\"sub_question_text\":\"Quality of teaching modules\"},{\"sub_question_index\":103,\"sub_question_text\":\"Quality of practice\\/OJT opportunities (e.g. facilitating access to internships))\"},{\"sub_question_index\":104,\"sub_question_text\":\"Overall usefulness of De La Salle Lipa’s website\"},{\"sub_question_index\":105,\"sub_question_text\":\"Quality of library resources and services\"},{\"sub_question_index\":106,\"sub_question_text\":\"Quality of enrollment process and services\"},{\"sub_question_index\":107,\"sub_question_text\":\"Quality of payment process\"},{\"sub_question_index\":108,\"sub_question_text\":\"Viewing of grades\"},{\"sub_question_index\":109,\"sub_question_text\":\"Quality of services in acquiring copy of student records (e.g. copy of grades etc.)\"},{\"sub_question_index\":110,\"sub_question_text\":\"Overall value of the education with respect to tuition fee\"},{\"sub_question_index\":111,\"sub_question_text\":\"Quality of online academic-related engagements with students\"},{\"sub_question_index\":112,\"sub_question_text\":\"Quality of activities of student organizations\"},{\"sub_question_index\":113,\"sub_question_text\":\"Quality of student government plans and programs\"},{\"sub_question_index\":114,\"sub_question_text\":\"Campus safety and security services\"},{\"sub_question_index\":115,\"sub_question_text\":\"Student Formation and Discipline Office services\"},{\"sub_question_index\":116,\"sub_question_text\":\"Institutional Lasallian Formation Office (ILFO) services\"},{\"sub_question_index\":117,\"sub_question_text\":\"Lasallian Assistance Management Program (LAMP) services\"},{\"sub_question_index\":118,\"sub_question_text\":\"Quality of Institutional Health Services (Clinic)\"},{\"sub_question_index\":119,\"sub_question_text\":\"College Guidance and Counseling Center services\"},{\"sub_question_index\":99,\"sub_question_text\":\"Teachers\"},{\"sub_question_index\":100,\"sub_question_text\":\"Curriculum\"},{\"sub_question_index\":101,\"sub_question_text\":\"Quality of academic advising\"},{\"sub_question_index\":102,\"sub_question_text\":\"Quality of teaching modules\"},{\"sub_question_index\":103,\"sub_question_text\":\"Quality of practice\\/OJT opportunities (e.g. facilitating access to internships))\"},{\"sub_question_index\":104,\"sub_question_text\":\"Overall usefulness of De La Salle Lipa’s website\"},{\"sub_question_index\":105,\"sub_question_text\":\"Quality of library resources and services\"},{\"sub_question_index\":106,\"sub_question_text\":\"Quality of enrollment process and services\"},{\"sub_question_index\":107,\"sub_question_text\":\"Quality of payment process\"},{\"sub_question_index\":108,\"sub_question_text\":\"Viewing of grades\"},{\"sub_question_index\":109,\"sub_question_text\":\"Quality of services in acquiring copy of student records (e.g. copy of grades etc.)\"},{\"sub_question_index\":110,\"sub_question_text\":\"Overall value of the education with respect to tuition fee\"},{\"sub_question_index\":111,\"sub_question_text\":\"Quality of online academic-related engagements with students\"},{\"sub_question_index\":112,\"sub_question_text\":\"Quality of activities of student organizations\"},{\"sub_question_index\":113,\"sub_question_text\":\"Quality of student government plans and programs\"},{\"sub_question_index\":114,\"sub_question_text\":\"Campus safety and security services\"},{\"sub_question_index\":115,\"sub_question_text\":\"Student Formation and Discipline Office services\"},{\"sub_question_index\":116,\"sub_question_text\":\"Institutional Lasallian Formation Office (ILFO) services\"},{\"sub_question_index\":117,\"sub_question_text\":\"Lasallian Assistance Management Program (LAMP) services\"},{\"sub_question_index\":118,\"sub_question_text\":\"Quality of Institutional Health Services (Clinic)\"},{\"sub_question_index\":119,\"sub_question_text\":\"College Guidance and Counseling Center services\"},{\"sub_question_index\":99,\"sub_question_text\":\"Teachers\"},{\"sub_question_index\":100,\"sub_question_text\":\"Curriculum\"},{\"sub_question_index\":101,\"sub_question_text\":\"Quality of academic advising\"},{\"sub_question_index\":102,\"sub_question_text\":\"Quality of teaching modules\"},{\"sub_question_index\":103,\"sub_question_text\":\"Quality of practice\\/OJT opportunities (e.g. facilitating access to internships))\"},{\"sub_question_index\":104,\"sub_question_text\":\"Overall usefulness of De La Salle Lipa’s website\"},{\"sub_question_index\":105,\"sub_question_text\":\"Quality of library resources and services\"},{\"sub_question_index\":106,\"sub_question_text\":\"Quality of enrollment process and services\"},{\"sub_question_index\":107,\"sub_question_text\":\"Quality of payment process\"},{\"sub_question_index\":108,\"sub_question_text\":\"Viewing of grades\"},{\"sub_question_index\":109,\"sub_question_text\":\"Quality of services in acquiring copy of student records (e.g. copy of grades etc.)\"},{\"sub_question_index\":110,\"sub_question_text\":\"Overall value of the education with respect to tuition fee\"},{\"sub_question_index\":111,\"sub_question_text\":\"Quality of online academic-related engagements with students\"},{\"sub_question_index\":112,\"sub_question_text\":\"Quality of activities of student organizations\"},{\"sub_question_index\":113,\"sub_question_text\":\"Quality of student government plans and programs\"},{\"sub_question_index\":114,\"sub_question_text\":\"Campus safety and security services\"},{\"sub_question_index\":115,\"sub_question_text\":\"Student Formation and Discipline Office services\"},{\"sub_question_index\":116,\"sub_question_text\":\"Institutional Lasallian Formation Office (ILFO) services\"},{\"sub_question_index\":117,\"sub_question_text\":\"Lasallian Assistance Management Program (LAMP) services\"},{\"sub_question_index\":118,\"sub_question_text\":\"Quality of Institutional Health Services (Clinic)\"},{\"sub_question_index\":119,\"sub_question_text\":\"College Guidance and Counseling Center services\"},{\"sub_question_index\":99,\"sub_question_text\":\"Teachers\"},{\"sub_question_index\":100,\"sub_question_text\":\"Curriculum\"},{\"sub_question_index\":101,\"sub_question_text\":\"Quality of academic advising\"},{\"sub_question_index\":102,\"sub_question_text\":\"Quality of teaching modules\"},{\"sub_question_index\":103,\"sub_question_text\":\"Quality of practice\\/OJT opportunities (e.g. facilitating access to internships))\"},{\"sub_question_index\":104,\"sub_question_text\":\"Overall usefulness of De La Salle Lipa’s website\"},{\"sub_question_index\":105,\"sub_question_text\":\"Quality of library resources and services\"},{\"sub_question_index\":106,\"sub_question_text\":\"Quality of enrollment process and services\"},{\"sub_question_index\":107,\"sub_question_text\":\"Quality of payment process\"},{\"sub_question_index\":108,\"sub_question_text\":\"Viewing of grades\"},{\"sub_question_index\":109,\"sub_question_text\":\"Quality of services in acquiring copy of student records (e.g. copy of grades etc.)\"},{\"sub_question_index\":110,\"sub_question_text\":\"Overall value of the education with respect to tuition fee\"},{\"sub_question_index\":111,\"sub_question_text\":\"Quality of online academic-related engagements with students\"},{\"sub_question_index\":112,\"sub_question_text\":\"Quality of activities of student organizations\"},{\"sub_question_index\":113,\"sub_question_text\":\"Quality of student government plans and programs\"},{\"sub_question_index\":114,\"sub_question_text\":\"Campus safety and security services\"},{\"sub_question_index\":115,\"sub_question_text\":\"Student Formation and Discipline Office services\"},{\"sub_question_index\":116,\"sub_question_text\":\"Institutional Lasallian Formation Office (ILFO) services\"},{\"sub_question_index\":117,\"sub_question_text\":\"Lasallian Assistance Management Program (LAMP) services\"},{\"sub_question_index\":118,\"sub_question_text\":\"Quality of Institutional Health Services (Clinic)\"},{\"sub_question_index\":119,\"sub_question_text\":\"College Guidance and Counseling Center services\"}],\"form_section_index\":299},{\"id\":954,\"question\":\"Please share any comments about your level of satisfaction with the services above (optional).\",\"type\":\"short\",\"subtype\":\"\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":299},{\"id\":955,\"question\":\"How would you evaluate the following learning results that you have gained at the end of this College Experience?\",\"type\":\"grid\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5056,\"choice_text\":\"Very Good\"},{\"choice_index\":5057,\"choice_text\":\"Good\"},{\"choice_index\":5058,\"choice_text\":\"Poor\"},{\"choice_index\":5059,\"choice_text\":\"Very Poor\"}],\"rows\":[{\"sub_question_index\":120,\"sub_question_text\":\"General preparation for life\"},{\"sub_question_index\":121,\"sub_question_text\":\"Competence in your major field of study\"},{\"sub_question_index\":122,\"sub_question_text\":\"Foundation for graduate studies\"},{\"sub_question_index\":123,\"sub_question_text\":\"Critical thinking skills\"},{\"sub_question_index\":124,\"sub_question_text\":\"Quantitative reasoning skills\"},{\"sub_question_index\":125,\"sub_question_text\":\"Written communication skills\"},{\"sub_question_index\":126,\"sub_question_text\":\"Oral communication skills\"},{\"sub_question_index\":127,\"sub_question_text\":\"Leadership skills\"},{\"sub_question_index\":128,\"sub_question_text\":\"Capacity to understand current world issues\"},{\"sub_question_index\":129,\"sub_question_text\":\"Capacity to understand human diversity (cultural diversity, sexual diversity, etc.)\"},{\"sub_question_index\":130,\"sub_question_text\":\"Capacity to access relevant and trustworthy information\"},{\"sub_question_index\":120,\"sub_question_text\":\"General preparation for life\"},{\"sub_question_index\":121,\"sub_question_text\":\"Competence in your major field of study\"},{\"sub_question_index\":122,\"sub_question_text\":\"Foundation for graduate studies\"},{\"sub_question_index\":123,\"sub_question_text\":\"Critical thinking skills\"},{\"sub_question_index\":124,\"sub_question_text\":\"Quantitative reasoning skills\"},{\"sub_question_index\":125,\"sub_question_text\":\"Written communication skills\"},{\"sub_question_index\":126,\"sub_question_text\":\"Oral communication skills\"},{\"sub_question_index\":127,\"sub_question_text\":\"Leadership skills\"},{\"sub_question_index\":128,\"sub_question_text\":\"Capacity to understand current world issues\"},{\"sub_question_index\":129,\"sub_question_text\":\"Capacity to understand human diversity (cultural diversity, sexual diversity, etc.)\"},{\"sub_question_index\":130,\"sub_question_text\":\"Capacity to access relevant and trustworthy information\"},{\"sub_question_index\":120,\"sub_question_text\":\"General preparation for life\"},{\"sub_question_index\":121,\"sub_question_text\":\"Competence in your major field of study\"},{\"sub_question_index\":122,\"sub_question_text\":\"Foundation for graduate studies\"},{\"sub_question_index\":123,\"sub_question_text\":\"Critical thinking skills\"},{\"sub_question_index\":124,\"sub_question_text\":\"Quantitative reasoning skills\"},{\"sub_question_index\":125,\"sub_question_text\":\"Written communication skills\"},{\"sub_question_index\":126,\"sub_question_text\":\"Oral communication skills\"},{\"sub_question_index\":127,\"sub_question_text\":\"Leadership skills\"},{\"sub_question_index\":128,\"sub_question_text\":\"Capacity to understand current world issues\"},{\"sub_question_index\":129,\"sub_question_text\":\"Capacity to understand human diversity (cultural diversity, sexual diversity, etc.)\"},{\"sub_question_index\":130,\"sub_question_text\":\"Capacity to access relevant and trustworthy information\"},{\"sub_question_index\":120,\"sub_question_text\":\"General preparation for life\"},{\"sub_question_index\":121,\"sub_question_text\":\"Competence in your major field of study\"},{\"sub_question_index\":122,\"sub_question_text\":\"Foundation for graduate studies\"},{\"sub_question_index\":123,\"sub_question_text\":\"Critical thinking skills\"},{\"sub_question_index\":124,\"sub_question_text\":\"Quantitative reasoning skills\"},{\"sub_question_index\":125,\"sub_question_text\":\"Written communication skills\"},{\"sub_question_index\":126,\"sub_question_text\":\"Oral communication skills\"},{\"sub_question_index\":127,\"sub_question_text\":\"Leadership skills\"},{\"sub_question_index\":128,\"sub_question_text\":\"Capacity to understand current world issues\"},{\"sub_question_index\":129,\"sub_question_text\":\"Capacity to understand human diversity (cultural diversity, sexual diversity, etc.)\"},{\"sub_question_index\":130,\"sub_question_text\":\"Capacity to access relevant and trustworthy information\"}],\"form_section_index\":299},{\"id\":956,\"question\":\"What are your next plans regarding education and career\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5060,\"choice_text\":\"Continue with graduate studies in the same field\"},{\"choice_index\":5061,\"choice_text\":\"Continue with graduate studies in a different field\"},{\"choice_index\":5062,\"choice_text\":\"Continue with higher education in another field\"},{\"choice_index\":5063,\"choice_text\":\"Review for Licensure Examination\"},{\"choice_index\":5064,\"choice_text\":\"Look for a job\"},{\"choice_index\":5065,\"choice_text\":\"I already have a job and will immediately start working\"},{\"choice_index\":5066,\"choice_text\":\"Involve myself with volunteer activities\"},{\"choice_index\":5067,\"choice_text\":\"Help manage our family business\"},{\"choice_index\":5068,\"choice_text\":\"Work on an online job\"},{\"choice_index\":5069,\"choice_text\":\"Stay unemployed and rest for a while\"},{\"choice_index\":5070,\"choice_text\":\"Other\"}],\"rows\":[],\"form_section_index\":299},{\"id\":957,\"question\":\"What are your worries\\/concerns now that you are graduating from college?\",\"type\":\"checkbox\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5071,\"choice_text\":\"Feels unprepared for job application process (job interview, creating a resume, visiting companies, etc.)\"},{\"choice_index\":5072,\"choice_text\":\"Feels not ready for the world of work\"},{\"choice_index\":5073,\"choice_text\":\"Anxious about competition in job hunting\"},{\"choice_index\":5074,\"choice_text\":\"Pressure to provide\\/give back for the family\"},{\"choice_index\":5075,\"choice_text\":\"Expectations from family, society to succeed\"},{\"choice_index\":5076,\"choice_text\":\"Concerns about adjusting to change (workplace environment, new people, work responsibilities, leaving DLSL)\"},{\"choice_index\":5077,\"choice_text\":\"Other\"}],\"rows\":[],\"form_section_index\":299},{\"id\":958,\"question\":\"How likely would you recommend the following to a friend\",\"type\":\"grid\",\"subtype\":null,\"required\":true,\"options\":[{\"choice_index\":5078,\"choice_text\":\"Strongly Recommended\"},{\"choice_index\":5079,\"choice_text\":\"Recommended\"},{\"choice_index\":5080,\"choice_text\":\"NOT Recommended\"},{\"choice_index\":5081,\"choice_text\":\"Strongly NOT Recommended De La Salle Lipa as an academic institution\\t To enroll my college program in De La Salle Lipa.\\t To enroll in other college programs in De La Salle Lipa\"}],\"rows\":[{\"sub_question_index\":131,\"sub_question_text\":\"De La Salle Lipa as an academic institution\"},{\"sub_question_index\":132,\"sub_question_text\":\"To enroll my college program in De La Salle Lipa.\"},{\"sub_question_index\":133,\"sub_question_text\":\"To enroll in other college programs in De La Salle Lipa\"},{\"sub_question_index\":131,\"sub_question_text\":\"De La Salle Lipa as an academic institution\"},{\"sub_question_index\":132,\"sub_question_text\":\"To enroll my college program in De La Salle Lipa.\"},{\"sub_question_index\":133,\"sub_question_text\":\"To enroll in other college programs in De La Salle Lipa\"},{\"sub_question_index\":131,\"sub_question_text\":\"De La Salle Lipa as an academic institution\"},{\"sub_question_index\":132,\"sub_question_text\":\"To enroll my college program in De La Salle Lipa.\"},{\"sub_question_index\":133,\"sub_question_text\":\"To enroll in other college programs in De La Salle Lipa\"},{\"sub_question_index\":131,\"sub_question_text\":\"De La Salle Lipa as an academic institution\"},{\"sub_question_index\":132,\"sub_question_text\":\"To enroll my college program in De La Salle Lipa.\"},{\"sub_question_index\":133,\"sub_question_text\":\"To enroll in other college programs in De La Salle Lipa\"}],\"form_section_index\":299},{\"id\":959,\"question\":\"Overall comments in your stay in De La Salle Lipa.\",\"type\":\"short\",\"subtype\":\"\",\"required\":false,\"options\":[],\"rows\":[],\"form_section_index\":299}],\"timestamp\":\"2025-05-31T07:32:09+02:00\"}', 11, '2025-05-31 05:32:09', 1);

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

--
-- Dumping data for table `grid_answers`
--

INSERT INTO `grid_answers` (`grid_answer_index`, `response_index`, `main_question_index`, `sub_question_index`, `choice_index`) VALUES
(21, 36, 822, 65, 4640),
(22, 36, 822, 66, 4640),
(23, 36, 826, 82, 4650),
(24, 36, 826, 83, 4651),
(25, 36, 826, 84, 4651),
(26, 36, 826, 85, 4650),
(27, 36, 826, 86, 4651),
(28, 36, 826, 87, 4651),
(29, 36, 826, 88, 4650);

-- --------------------------------------------------------

--
-- Table structure for table `guardians`
--

CREATE TABLE `guardians` (
  `guardian_index` int(11) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guardians`
--

INSERT INTO `guardians` (`guardian_index`, `last_name`, `first_name`, `contact_number`) VALUES
(1, 'Agustin', 'Rias', '4218391312'),
(2, 'Alcantara', 'Rachelle', '9157091187'),
(3, 'Alonzo', 'Kia', '421839218'),
(4, 'Katigbak', 'Elizabeth', '9952144589'),
(5, 'Balion', 'Dareen', '9916873009'),
(6, 'Barte', 'Eden', '9215747674'),
(7, 'Cadeliña', 'Emie', '9178042206'),
(8, 'Catibog', 'Eme', '42141234124'),
(9, 'Del Rosario', 'Raquel', '9194087360'),
(10, 'Dela Peña', 'Mayra', '4142131245'),
(11, 'Dela Vega', 'Lourdes', '9214566458'),
(12, 'Doctolero', 'Breb Claude', '995401561'),
(13, 'Maninang', 'Sheila', '9171705367'),
(14, 'Estrella', 'Elenita', '4134213412'),
(15, 'Fedelicio', 'Jovencio', '9055989302'),
(16, 'Garcia', 'Reynaldo', '9302232851'),
(17, 'Jaurigue', 'Maria Luisa', '9360410172'),
(18, 'Guevarra', 'Audrey', '9166686257'),
(19, 'Lique', 'Jimmy', '9273391738'),
(20, 'Lirio', 'Amy', '656345456'),
(21, 'Liwanag', 'Magdalena', '9178765184'),
(22, 'Macalintal', 'Rizza', '9369354163'),
(23, 'Macasaet', 'John Paul Verlann', '9075169764'),
(24, 'Magbuhat', 'Cheryvel', '9874850109'),
(25, 'Manalo', 'Ronaldo', '9563360392'),
(26, 'Manimtim', 'Maricar', '9989031690'),
(27, 'Marquinez', 'Test', '54326531'),
(28, 'Meer', 'Elem', '64262656'),
(29, 'Mendez', 'Jethro', '938677662'),
(30, 'Nario', 'Joel', '9272747559'),
(31, 'Nario', 'Jayson', '9052294676'),
(32, 'Panuela', 'Robelyn', '9482517698'),
(33, 'Paray', 'Arlene', '9292437343'),
(34, 'Sahagun', 'Precious Claire', '9263009576'),
(35, 'Siman', 'Gloria', '9658065263'),
(36, 'Talens', 'Rochelle', '9478229099'),
(37, 'Tenorio', 'Norely', '9076473654'),
(38, 'Torres', 'Joselito', '6555433214');

-- --------------------------------------------------------

--
-- Table structure for table `main_questions`
--

CREATE TABLE `main_questions` (
  `main_question_index` int(11) NOT NULL,
  `form_index` int(11) DEFAULT NULL,
  `main_question_text` text DEFAULT NULL,
  `type_index` int(11) DEFAULT NULL,
  `subtype` enum('text','number','phone','email') DEFAULT 'text',
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `form_section_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `main_questions`
--

INSERT INTO `main_questions` (`main_question_index`, `form_index`, `main_question_text`, `type_index`, `subtype`, `is_required`, `form_section_index`) VALUES
(710, 6, 'dfgdgdfg', 1, '', 0, 226),
(722, 7, 'number', 1, '', 0, 238),
(822, 9, '', 6, NULL, 0, 271),
(823, 9, 'In the past two (2) weeks, have you:', 6, NULL, 0, 271),
(824, 9, 'Sometimes things happen to people that are unusually or especially frightening, horrible, or traumatic. For example a serious accident or fire, a physical or sexual assault or abuse, an earthquake or flood, a war, seeing someone be killed or seriously injured, having a loved one die through homicide or suicide. Have you ever experienced any of this kind of event?', 3, NULL, 0, 271),
(825, 9, 'How would you rate your current level of stress?', 3, NULL, 0, 271),
(826, 9, 'Suicide Risk Screening/Assessment (Please respond to the following items)', 6, NULL, 1, 271),
(827, 9, 'Thanks for answering the questions above. At this point, we would like to know if there are other things that you would like to share or talk about with your counselor.', 2, NULL, 0, 271),
(844, 8, 'Counselor being Evaluated', 5, NULL, 1, 277),
(845, 8, 'Please choose the number that corresponds to your level of agreement to the following statements (4 being the HIGHEST and 1 being the LOWEST):', 6, NULL, 1, 278),
(846, 8, 'Please take this opportunity to express your comments and suggestion about your experience with this session. We encourage you to be completely open, as this is the only way we can evaluate ourselves and initiate improvements.', 2, NULL, 0, 278),
(847, 8, 'Thank you!\n\nWe appreciate your comments and feedback.', 8, NULL, 0, 278),
(884, 10, 'I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.', 8, NULL, 0, 284),
(885, 10, 'Nickname', 1, 'text', 1, 285),
(886, 10, 'Last school attended during SHS                              \n2nd Year - 5th Year College students, Put N/A', 1, 'text', 1, 285),
(887, 10, 'Birthday', 7, NULL, 1, 285),
(888, 10, 'Age', 1, 'text', 1, 285),
(889, 10, 'Nationality', 1, 'text', 1, 285),
(890, 10, 'Personal Mobile Number', 1, 'text', 1, 285),
(891, 10, 'Home Landline Phone Number (Area Code & Phone Number)', 1, 'text', 0, 285),
(892, 10, 'COMPLETE PERMANENT ADDRESS (House Number, Block No., Lot No., Street, Subdivision, Barangay, City/Municipality, Province)', 1, 'text', 1, 285),
(893, 10, 'COMPLETE \"PRESENT ADDRESS\" (if living in apartment, dormitory etc.) Put N/A if not applicable', 1, 'text', 1, 285),
(894, 10, 'Name of Landlord/Landlady \nPut N/A if not applicable', 1, 'text', 1, 285),
(895, 10, 'Religion', 1, 'text', 1, 285),
(896, 10, 'Sex at birth', 3, NULL, 1, 285),
(897, 10, 'To which gender identity do you most identify?', 5, NULL, 1, 285),
(898, 10, 'Current Status', 3, NULL, 1, 285),
(899, 10, 'Are you a college student varsity?', 5, NULL, 1, 286),
(900, 10, 'Are your parents working abroad?', 3, NULL, 1, 287),
(901, 10, 'Father\'s Complete Name (Last Name, First Name M.I)\nWrite \"D\" if deceased and \"NI\" if no information', 1, 'text', 1, 287),
(902, 10, 'Occupation/Business of Father\nPut N/A if not applicable', 1, 'text', 1, 287),
(903, 10, 'Father\'s Cellphone Number', 1, 'text', 0, 287),
(904, 10, 'Father\'s email address\nPut N/A if not applicable', 1, 'text', 1, 287),
(905, 10, 'If father is OFW (what country)\nPut N/A if not applicable', 1, 'text', 1, 287),
(906, 10, 'Mother\'s Complete Name (Last Name, First Name M.I.)\nWrite \"D\" if deceased and \"NI\" if no information', 1, 'text', 1, 287),
(907, 10, 'Occupation/Business of Mother\nPut N/A if not applicable', 1, 'text', 1, 287),
(908, 10, 'Mother\'s Cellphone Number\nPut N/A if not applicable', 1, 'text', 1, 287),
(909, 10, 'Mother\'s email address\nPut N/A if not applicable', 1, 'text', 1, 287),
(910, 10, 'If mother is OFW (what country)\nPut N/A if not applicable', 1, 'text', 1, 287),
(911, 10, 'Parents are?\nThis portion will be treated with utmost confidentiality, please answer with all honesty', 4, NULL, 1, 287),
(912, 10, 'Guardian\'s Name\nContact person other than parents. Put N/A if not applicable.', 1, 'text', 1, 287),
(913, 10, 'Relationship to Guardian (e.g. uncle, aunt, grandmother, family friend, etc.)\nPut N/A if not applicable', 1, 'text', 1, 287),
(914, 10, 'Guardian\'s Contact Number\nPut N/A if not applicable', 1, 'text', 1, 287),
(915, 10, 'Living arrangement', 3, NULL, 1, 287),
(916, 10, 'Have you received therapy, counseling, or mental health treatment in the past?', 5, NULL, 1, 287),
(917, 10, 'Scholarship Category', 3, NULL, 1, 288),
(918, 10, 'Other persons who financially support you\nPut N/A if not applicable', 1, 'text', 1, 288),
(919, 10, 'Hobbies/interests', 1, 'text', 0, 288),
(936, 1, 'I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.', 4, NULL, 1, 294),
(937, 1, 'SOCIAL/EMOTIONAL CONCERNS', 4, NULL, 1, 295),
(938, 1, 'FAMILY & HOME CONCERNS', 4, NULL, 1, 295),
(939, 1, 'MENTAL/PHYSICAL HEALTH CONCERNS', 4, NULL, 1, 295),
(940, 1, 'ACADEMIC CONCERNS', 4, NULL, 1, 295),
(941, 1, 'PROFESSOR ISSUE CONCERNS', 4, NULL, 1, 295),
(942, 1, 'CAREER CONCERNS', 4, NULL, 1, 295),
(943, 1, 'I have other concerns/questions that I want to directly consult or discuss with my counselor.', 3, NULL, 1, 295),
(944, 1, 'We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments/suggestions, please indicate them below:', 1, 'text', 1, 295),
(945, 1, 'By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.', 4, NULL, 1, 295),
(946, 1, 'I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.', 3, NULL, 1, 297),
(947, 1, 'Name of Father/Mother or Legal Guardian', 1, 'text', 1, 297),
(948, 1, 'Contact number of parent/guardian', 1, 'text', 1, 297),
(949, 1, 'When client information is utilized on outcome research purposes, client names are not disclosed.', 3, NULL, 1, 298),
(950, 1, 'Counseling Guidelines\nPlease review the Counseling Guidelines through this link: https://bit.ly/counselingguide\nBy accomplishing this form you understand and agree to the guidelines set by CGCC.', 8, NULL, 0, 298),
(951, 1, 'This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.', 8, NULL, 0, 298),
(952, 11, 'How would you evaluate the overall quality of your college experience at De La Salle Lipa?', 3, NULL, 1, 299),
(953, 11, 'How satisfied are you with the following aspects that De La Salle Lipa has provided?', 6, NULL, 1, 299),
(954, 11, 'Please share any comments about your level of satisfaction with the services above (optional).', 1, '', 0, 299),
(955, 11, 'How would you evaluate the following learning results that you have gained at the end of this College Experience?', 6, NULL, 1, 299),
(956, 11, 'What are your next plans regarding education and career', 4, NULL, 1, 299),
(957, 11, 'What are your worries/concerns now that you are graduating from college?', 4, NULL, 1, 299),
(958, 11, 'How likely would you recommend the following to a friend', 6, NULL, 1, 299),
(959, 11, 'Overall comments in your stay in De La Salle Lipa.', 1, '', 0, 299);

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_index` int(11) NOT NULL,
  `dept_index` int(11) NOT NULL,
  `program_code` varchar(20) NOT NULL,
  `program_name` varchar(100) NOT NULL,
  `counselor_index` int(11) DEFAULT NULL COMMENT 'References the assigned counselor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`program_index`, `dept_index`, `program_code`, `program_name`, `counselor_index`) VALUES
(1, 1, 'BSA', 'Bachelor of Science in Accountancy', NULL),
(2, 1, 'BSAIS', 'Bachelor of Science in Accounting Information Systems', NULL),
(3, 1, 'BSLM', 'Bachelor of Science in Legal Management', NULL),
(4, 1, 'BSE', 'Bachelor of Science in Entrepreneurship', NULL),
(5, 1, 'BSMT', 'Bachelor of Science in Management Technology', NULL),
(6, 1, 'BSBA-FM', 'Bachelor of Science in Business Administration major in Financial Management', NULL),
(7, 1, 'BSBA-MM', 'Bachelor of Science in Business Administration major in Marketing Management', NULL),
(8, 1, 'CE', 'Certificate in Entrepreneurship', NULL),
(9, 2, 'BEED', 'Bachelor of Elementary Education', 1),
(10, 2, 'BSED', 'Bachelor of Secondary Education', NULL),
(11, 2, 'AB COM', 'Bachelor of Arts in Communication', 1),
(12, 2, 'BMMA', 'Bachelor of Multimedia Arts', NULL),
(13, 2, 'BS BIO', 'Bachelor of Science in Biology', NULL),
(14, 2, 'BSFS', 'Bachelor of Science in Forensic Science', NULL),
(15, 2, 'BS MATH', 'Bachelor of Science in Mathematics', NULL),
(16, 2, 'BS PSYCH', 'Bachelor of Science in Psychology', NULL),
(17, 3, 'BSHM', 'Bachelor of Science in Hospitality Management', NULL),
(18, 3, 'BSTM', 'Bachelor of Science in Tourism Management', NULL),
(19, 3, 'CCA', 'Certificate in Culinary Arts', NULL),
(20, 4, 'BS ARCHI', 'Bachelor of Science in Architecture', NULL),
(21, 4, 'BS CpE', 'Bachelor of Science in Computer Engineering', NULL),
(22, 4, 'BSCS', 'Bachelor of Science in Computer Science', NULL),
(23, 4, 'BSEE', 'Bachelor of Science in Electrical Engineering', NULL),
(24, 4, 'BSECE', 'Bachelor of Science in Electronics Engineering', NULL),
(25, 4, 'BSEMC', 'Bachelor of Science in Entertainment and Multimedia Computing', NULL),
(26, 4, 'BSIE', 'Bachelor of Science in Industrial Engineering', NULL),
(27, 4, 'BSIT', 'Bachelor of Science in Information Technology', NULL),
(28, 4, 'ACT', 'Associate in Computer Technology', 1),
(29, 5, 'BSN', 'Bachelor of Science in Nursing', NULL),
(30, 6, 'JD', 'Juris Doctor', NULL);

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
(7, 'date'),
(8, 'display');

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE `responses` (
  `response_index` int(11) NOT NULL,
  `form_index` int(11) DEFAULT NULL,
  `student_index` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `snapshot_index` int(11) DEFAULT NULL,
  `is_autosave` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `academic_year` varchar(9) NOT NULL DEFAULT '2023-2024' CHECK (`academic_year` regexp '^[0-9]{4}-[0-9]{4}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `responses`
--

INSERT INTO `responses` (`response_index`, `form_index`, `student_index`, `created_at`, `snapshot_index`, `is_autosave`, `updated_at`, `academic_year`) VALUES
(36, 9, 5, '2025-05-31 13:49:47', NULL, 1, NULL, '2024-2025'),
(37, 8, 5, '2025-05-31 14:32:30', NULL, 1, NULL, '2024-2025');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `section_index` int(11) NOT NULL,
  `section_name` varchar(50) NOT NULL,
  `program_index` int(11) NOT NULL,
  `year_level` enum('1','2','3','4','5') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`section_index`, `section_name`, `program_index`, `year_level`) VALUES
(1, 'BSA-1A', 1, '1'),
(2, 'BSA-1B', 1, '1'),
(3, 'BSAIS-1A', 2, '1'),
(4, 'BSAIS-1B', 2, '1'),
(5, 'BSLM-1A', 3, '1'),
(6, 'BSLM-1B', 3, '1'),
(7, 'BSE-1A', 4, '1'),
(8, 'BSE-1B', 4, '1'),
(9, 'BSMT-1A', 5, '1'),
(10, 'BSMT-1B', 5, '1'),
(11, 'BSBA-FM-1A', 6, '1'),
(12, 'BSBA-FM-1B', 6, '1'),
(13, 'BSBA-MM-1A', 7, '1'),
(14, 'BSBA-MM-1B', 7, '1'),
(15, 'CE-1A', 8, '1'),
(16, 'CE-1B', 8, '1'),
(17, 'BEED-1A', 9, '1'),
(18, 'BEED-1B', 9, '1'),
(19, 'BSED-1A', 10, '1'),
(20, 'BSED-1B', 10, '1'),
(21, 'ABCOM-1A', 11, '1'),
(22, 'ABCOM-1B', 11, '1'),
(23, 'BMMA-1A', 12, '1'),
(24, 'BMMA-1B', 12, '1'),
(25, 'BSBIO-1A', 13, '1'),
(26, 'BSBIO-1B', 13, '1'),
(27, 'BSFS-1A', 14, '1'),
(28, 'BSFS-1B', 14, '1'),
(29, 'BSMATH-1A', 15, '1'),
(30, 'BSMATH-1B', 15, '1'),
(31, 'BSPSYCH-1A', 16, '1'),
(32, 'BSPSYCH-1B', 16, '1'),
(33, 'BSHM-1A', 17, '1'),
(34, 'BSHM-1B', 17, '1'),
(35, 'BSTM-1A', 18, '1'),
(36, 'BSTM-1B', 18, '1'),
(37, 'CCA-1A', 19, '1'),
(38, 'CCA-1B', 19, '1'),
(39, 'BSARCHI-1A', 20, '1'),
(40, 'BSARCHI-1B', 20, '1'),
(41, 'BSCpE-1A', 21, '1'),
(42, 'BSCpE-1B', 21, '1'),
(43, 'BSCS-1A', 22, '1'),
(44, 'BSCS-1B', 22, '1'),
(45, 'BSEE-1A', 23, '1'),
(46, 'BSEE-1B', 23, '1'),
(47, 'BSECE-1A', 24, '1'),
(48, 'BSECE-1B', 24, '1'),
(49, 'BSEMC-1A', 25, '1'),
(50, 'BSEMC-1B', 25, '1'),
(51, 'BSIE-1A', 26, '1'),
(52, 'BSIE-1B', 26, '1'),
(53, 'BSIT-1A', 27, '1'),
(54, 'BSIT-1B', 27, '1'),
(55, 'ACT-1A', 28, '1'),
(56, 'ACT-1B', 28, '1'),
(57, 'BSN-1A', 29, '1'),
(58, 'BSN-1B', 29, '1'),
(59, 'JD-1A', 30, '1'),
(60, 'JD-1B', 30, '1'),
(61, 'BSA-2A', 1, '2'),
(62, 'BSA-2B', 1, '2'),
(63, 'BSAIS-2A', 2, '2'),
(64, 'BSAIS-2B', 2, '2'),
(65, 'BSLM-2A', 3, '2'),
(66, 'BSLM-2B', 3, '2'),
(67, 'BSE-2A', 4, '2'),
(68, 'BSE-2B', 4, '2'),
(69, 'BSMT-2A', 5, '2'),
(70, 'BSMT-2B', 5, '2'),
(71, 'BSBA-FM-2A', 6, '2'),
(72, 'BSBA-FM-2B', 6, '2'),
(73, 'BSBA-MM-2A', 7, '2'),
(74, 'BSBA-MM-2B', 7, '2'),
(75, 'CE-2A', 8, '2'),
(76, 'CE-2B', 8, '2'),
(77, 'BEED-2A', 9, '2'),
(78, 'BEED-2B', 9, '2'),
(79, 'BSED-2A', 10, '2'),
(80, 'BSED-2B', 10, '2'),
(81, 'ABCOM-2A', 11, '2'),
(82, 'ABCOM-2B', 11, '2'),
(83, 'BMMA-2A', 12, '2'),
(84, 'BMMA-2B', 12, '2'),
(85, 'BSBIO-2A', 13, '2'),
(86, 'BSBIO-2B', 13, '2'),
(87, 'BSFS-2A', 14, '2'),
(88, 'BSFS-2B', 14, '2'),
(89, 'BSMATH-2A', 15, '2'),
(90, 'BSMATH-2B', 15, '2'),
(91, 'BSPSYCH-2A', 16, '2'),
(92, 'BSPSYCH-2B', 16, '2'),
(93, 'BSHM-2A', 17, '2'),
(94, 'BSHM-2B', 17, '2'),
(95, 'BSTM-2A', 18, '2'),
(96, 'BSTM-2B', 18, '2'),
(97, 'CCA-2A', 19, '2'),
(98, 'CCA-2B', 19, '2'),
(99, 'A2A', 20, '2'),
(100, 'A2B', 20, '2'),
(101, 'O2A', 21, '2'),
(102, 'O2B', 21, '2'),
(103, 'C2A', 22, '2'),
(104, 'C2B', 22, '2'),
(105, 'V2A', 23, '2'),
(106, 'V2B', 23, '2'),
(107, 'T2A', 24, '2'),
(108, 'T2B', 24, '2'),
(109, 'EMC2A', 25, '2'),
(110, 'EMC2B', 25, '2'),
(111, 'D2A', 26, '2'),
(112, 'D2B', 26, '2'),
(113, 'IT2A', 27, '2'),
(114, 'IT2B', 27, '2'),
(115, 'I2A', 28, '2'),
(116, 'I2B', 28, '2'),
(117, 'G2A', 29, '2'),
(118, 'G2B', 29, '2'),
(119, 'JD-2A', 30, '2'),
(120, 'JD-2B', 30, '2'),
(121, 'BSA-3A', 1, '3'),
(122, 'BSA-3B', 1, '3'),
(123, 'BSAIS-3A', 2, '3'),
(124, 'BSAIS-3B', 2, '3'),
(125, 'BSLM-3A', 3, '3'),
(126, 'BSLM-3B', 3, '3'),
(127, 'BSE-3A', 4, '3'),
(128, 'BSE-3B', 4, '3'),
(129, 'BSMT-3A', 5, '3'),
(130, 'BSMT-3B', 5, '3'),
(131, 'BSBA-FM-3A', 6, '3'),
(132, 'BSBA-FM-3B', 6, '3'),
(133, 'BSBA-MM-3A', 7, '3'),
(134, 'BSBA-MM-3B', 7, '3'),
(135, 'CE-3A', 8, '3'),
(136, 'CE-3B', 8, '3'),
(137, 'BEED-3A', 9, '3'),
(138, 'BEED-3B', 9, '3'),
(139, 'BSED-3A', 10, '3'),
(140, 'BSED-3B', 10, '3'),
(141, 'ABCOM-3A', 11, '3'),
(142, 'ABCOM-3B', 11, '3'),
(143, 'BMMA-3A', 12, '3'),
(144, 'BMMA-3B', 12, '3'),
(145, 'BSBIO-3A', 13, '3'),
(146, 'BSBIO-3B', 13, '3'),
(147, 'BSFS-3A', 14, '3'),
(148, 'BSFS-3B', 14, '3'),
(149, 'BSMATH-3A', 15, '3'),
(150, 'BSMATH-3B', 15, '3'),
(151, 'BSPSYCH-3A', 16, '3'),
(152, 'BSPSYCH-3B', 16, '3'),
(153, 'BSHM-3A', 17, '3'),
(154, 'BSHM-3B', 17, '3'),
(155, 'BSTM-3A', 18, '3'),
(156, 'BSTM-3B', 18, '3'),
(157, 'CCA-3A', 19, '3'),
(158, 'CCA-3B', 19, '3'),
(159, 'A3A', 20, '3'),
(160, 'A3B', 20, '3'),
(161, 'O3A', 21, '3'),
(162, 'O3B', 21, '3'),
(163, 'C3A', 22, '3'),
(164, 'C3B', 22, '3'),
(165, 'V3A', 23, '3'),
(166, 'V3B', 23, '3'),
(167, 'T3A', 24, '3'),
(168, 'T3B', 24, '3'),
(169, 'EMC3A', 25, '3'),
(170, 'EMC3B', 25, '3'),
(171, 'D3A', 26, '3'),
(172, 'D3B', 26, '3'),
(173, 'IT3A', 27, '3'),
(174, 'IT3B', 27, '3'),
(175, 'I3A', 28, '3'),
(176, 'I3B', 28, '3'),
(177, 'G3A', 29, '3'),
(178, 'G3B', 29, '3'),
(179, 'JD-3A', 30, '3'),
(180, 'JD-3B', 30, '3'),
(181, 'BSA-4A', 1, '4'),
(182, 'BSA-4B', 1, '4'),
(183, 'BSAIS-4A', 2, '4'),
(184, 'BSAIS-4B', 2, '4'),
(185, 'BSLM-4A', 3, '4'),
(186, 'BSLM-4B', 3, '4'),
(187, 'BSE-4A', 4, '4'),
(188, 'BSE-4B', 4, '4'),
(189, 'BSMT-4A', 5, '4'),
(190, 'BSMT-4B', 5, '4'),
(191, 'BSBA-FM-4A', 6, '4'),
(192, 'BSBA-FM-4B', 6, '4'),
(193, 'BSBA-MM-4A', 7, '4'),
(194, 'BSBA-MM-4B', 7, '4'),
(195, 'CE-4A', 8, '4'),
(196, 'CE-4B', 8, '4'),
(197, 'BEED-4A', 9, '4'),
(198, 'BEED-4B', 9, '4'),
(199, 'BSED-4A', 10, '4'),
(200, 'BSED-4B', 10, '4'),
(201, 'ABCOM-4A', 11, '4'),
(202, 'ABCOM-4B', 11, '4'),
(203, 'BMMA-4A', 12, '4'),
(204, 'BMMA-4B', 12, '4'),
(205, 'BSBIO-4A', 13, '4'),
(206, 'BSBIO-4B', 13, '4'),
(207, 'BSFS-4A', 14, '4'),
(208, 'BSFS-4B', 14, '4'),
(209, 'BSMATH-4A', 15, '4'),
(210, 'BSMATH-4B', 15, '4'),
(211, 'BSPSYCH-4A', 16, '4'),
(212, 'BSPSYCH-4B', 16, '4'),
(213, 'BSHM-4A', 17, '4'),
(214, 'BSHM-4B', 17, '4'),
(215, 'BSTM-4A', 18, '4'),
(216, 'BSTM-4B', 18, '4'),
(217, 'CCA-4A', 19, '4'),
(218, 'CCA-4B', 19, '4'),
(219, 'A4A', 20, '4'),
(220, 'A4B', 20, '4'),
(221, 'O4A', 21, '4'),
(222, 'O4B', 21, '4'),
(223, 'C4A', 22, '4'),
(224, 'C4B', 22, '4'),
(225, 'V4A', 23, '4'),
(226, 'V4B', 23, '4'),
(227, 'T4A', 24, '4'),
(228, 'T4B', 24, '4'),
(229, 'EMC4A', 25, '4'),
(230, 'EMC4B', 25, '4'),
(231, 'D4A', 26, '4'),
(232, 'D4B', 26, '4'),
(233, 'IT4A', 27, '4'),
(234, 'IT4B', 27, '4'),
(235, 'I4A', 28, '4'),
(236, 'I4B', 28, '4'),
(237, 'G4A', 29, '4'),
(238, 'G4B', 29, '4'),
(239, 'JD-4A', 30, '4'),
(240, 'JD-4B', 30, '4');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_index` int(11) NOT NULL,
  `user_index` int(11) DEFAULT NULL,
  `image_path` varchar(200) NOT NULL COMMENT 'Profile picture of the student',
  `student_number` varchar(255) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL COMMENT 'phone number of the student',
  `year_level` int(1) NOT NULL,
  `section_index` int(11) NOT NULL,
  `guardian_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_index`, `user_index`, `image_path`, `student_number`, `last_name`, `first_name`, `contact_number`, `year_level`, `section_index`, `guardian_index`) VALUES
(1, 2, '', '321421321', 'AGUSTIN', 'JOHN ANDREI', '9832918931', 1, 1, 1),
(2, 3, '', '2023360151', 'ALCANTARA', 'JANNA MIKHAELA', '9457153265', 1, 1, 2),
(3, 4, '', '213214', 'ALONZO', 'ENJEY KASHLEE', '9278558558', 1, 2, 3),
(4, 5, '', '2023363891', 'ALONZO', 'JHENELLE', '9321389210', 1, 2, 4),
(5, 6, '/../../public/Media/uploads/6837ea6c3e90e-6836dd617df18-Credit_ 𝐀zα࣪z𝗲̫̄l.jpg', '2023351801', 'BALION', 'ANGEL AMAYA', '9155167138', 1, 45, 5),
(6, 7, '', '2021310121', 'BARTE', 'ALFONSO RAFAEL', '9953011635', 1, 3, 6),
(7, 8, '', '812180', 'CADELIŇA', 'REGINA ANGELI', '9387882631', 1, 4, 7),
(8, 9, '', '312421', 'CATIBOG', 'DJAN MATTHEW', '9155141440', 1, 4, 8),
(9, 10, '', '2023350761', 'DEL ROSARIO', 'RENZ ANDREI', '9321421312', 1, 54, 9),
(10, 11, '', '2023360611', 'DELA PEŇA', 'MARC LAWRENCE', '9395720600', 1, 5, 10),
(11, 12, '', '2023350511', 'DELA VEGA', 'PRINCESS MIHAELA', '9471091401', 1, 6, 11),
(12, 13, '', '2023352471', 'DOCTOLERO', 'LYRUS LEI', '9686269099', 1, 6, 12),
(13, 14, '', '2023359741', 'DONES', 'KYLE GABRIEL', '09954010556', 1, 7, 13),
(14, 15, '', '2023348471', 'ESTRELLA', 'JUAN BENJO', '09771549349', 1, 7, 14),
(15, 16, '', '35152231', 'FEDELICIO', 'LENARD LANCE', '09533599052', 1, 8, 15),
(16, 17, '', '2023362151', 'GARCIA', 'HARRY', '09566224682', 1, 8, 16),
(17, 18, '', '2023362381', 'JAURIGUE', 'IVAN JOSEPH', '9568379291', 1, 9, 17),
(18, 19, '', '2023347681', 'KINCHASAN', 'MARK JEROME', '9667531028', 1, 9, 18),
(19, 20, '', '2023363211', 'LIQUE', 'JERIC', '9219979430', 1, 10, 19),
(20, 21, '', '2023364851', 'LIRIO', 'SEAN CALVIN THEO', '9923142591', 1, 10, 20),
(21, 22, '', '2023362901', 'LIWANAG', 'KATHERINE ANNE', '9617739701', 1, 11, 21),
(22, 23, '', '2023364391', 'MACALINTAL', 'CHESTER BORIZ', '9952071990', 1, 11, 22),
(23, 24, '', '2023352051', 'MACASAET', 'JOHN RAFHAEL STEVEN', '9202784081', 1, 12, 23),
(24, 25, '', '1500017172', 'MAGBUHAT', 'ALEXIE CHYLE', '9984264195', 1, 12, 24),
(25, 26, '', '2023361281', 'MANALO', 'JOHN AARON', '9674326323', 1, 13, 25),
(26, 27, '', '2023351631', 'MANIMTIM', 'IAN KARVEY', '9770494572', 1, 13, 26),
(27, 28, '', '2023350751', 'MARQUINEZ', 'ISIAH JOSEPH', '9473450276', 1, 14, 27),
(28, 29, '', '5124214', 'MEER', 'SEBASTIAN ANGELO', '9321984921', 1, 14, 28),
(29, 30, '', '2023365041', 'MENDEZ', 'WYETH IRISH', '9302193221', 1, 15, 29),
(30, 31, '', '811870', 'NARIO', 'JAN ERNEST PACEY', '9552861753', 1, 15, 30),
(31, 32, '', '2023362191', 'NARIO', 'KEITH JUSTIN', '9774696570', 1, 16, 31),
(32, 33, '', '1700020669', 'PANUELA', 'MICHAEL JOSH', '9566322071', 1, 16, 32),
(33, 34, '', '2023362341', 'PARAY', 'JANE ALLYSON', '9293410108', 1, 17, 33),
(34, 35, '', '2023358411', 'SAHAGUN', 'DANIEL LUIS', '9298657375', 1, 17, 34),
(35, 36, '', '2023364651', 'SIMAN', 'THOMAS ALEXANDRE', '9760811239', 1, 18, 35),
(36, 37, '', '2023359771', 'TALENS', 'XYRELLE DOMINIQUE', '9605365864', 1, 18, 36),
(37, 38, '', '2023352411', 'TENORIO', 'JHON PAULO', '9912217223', 1, 19, 37),
(38, 39, '', '1700019578', 'TORRES', 'KYAN PRINCE', '9561998634', 1, 19, 38),
(39, NULL, '', '2021234567', 'SEUNGCHEOL', 'CHOI', '09123456789', 1, 20, NULL),
(40, NULL, '', '2022345678', 'JEONGHAN', 'YOON', '09234567890', 1, 20, NULL),
(41, NULL, '', '2023456789', 'JOSHUA', 'HONG', '09345678901', 1, 21, NULL),
(42, NULL, '', '2024567890', 'JUN', 'WEN', '09456789012', 1, 21, NULL),
(43, NULL, '', '2025678901', 'HOSHI', 'KWON', '09567890123', 1, 22, NULL),
(44, NULL, '', '2026789012', 'WONWOO', 'JEON', '09678901234', 1, 22, NULL),
(45, NULL, '', '2027890123', 'WOOZI', 'LEE', '09789012345', 1, 23, NULL),
(46, NULL, '', '2028901234', 'DOKYEOM', 'LEE', '09890123456', 1, 23, NULL),
(47, NULL, '', '2029012345', 'MINGYU', 'KIM', '09901234567', 1, 24, NULL),
(48, NULL, '', '2020123456', 'MINGHAO', 'XU', '09123456780', 1, 24, NULL),
(49, NULL, '', '2021357924', 'SEUNGKWAN', 'BOO', '09234567891', 1, 25, NULL),
(50, NULL, '', '2022468135', 'VERNON', 'CHWE', '09345678902', 1, 25, NULL),
(51, NULL, '', '2023579246', 'DINO', 'LEE', '09456789013', 1, 26, NULL),
(52, NULL, '', '2024681357', 'NAM', 'YEJUN', '09123456789', 1, 26, NULL),
(53, NULL, '', '2025792468', 'YU', 'HAMIN', '09234567890', 1, 27, NULL),
(54, NULL, '', '2026803579', 'CHAE', 'BONGGU', '09345678901', 1, 27, NULL),
(55, NULL, '', '2027914680', 'DO', 'EUNHO', '09456789012', 1, 28, NULL),
(56, NULL, '', '2028025791', 'HAN', 'NOAH', '09567890123', 1, 28, NULL),
(57, NULL, '', '2029136802', 'NAYEON', 'CHAE', '09678901234', 1, 29, NULL),
(58, NULL, '', '2020247913', 'JIHYO', 'JUNG', '09789012345', 1, 29, NULL),
(59, NULL, '', '2021368024', 'MOMO', 'IM', '09890123456', 1, 30, NULL),
(60, NULL, '', '2022479135', 'DAHYUN', 'KIM', '09901234567', 1, 30, NULL),
(61, NULL, '', '2023590246', 'CHAEYOUNG', 'KIM', '09123456780', 1, 31, NULL),
(62, NULL, '', '2024601357', 'TZUYU', 'CHU', '09234567891', 1, 31, NULL),
(63, NULL, '', '2025712468', 'MINA', 'KIM', '09345678902', 1, 32, NULL),
(64, NULL, '', '2026823579', 'JEONGYEON', 'KIM', '09456789013', 1, 32, NULL),
(65, NULL, '', '2027934680', 'JISOO', 'KIM', '09567890124', 1, 33, NULL),
(66, NULL, '', '2028045791', 'JENNIE', 'HAN', '09678901235', 1, 33, NULL),
(67, NULL, '', '2029156802', 'ROSÉ', 'PARK', '09789012346', 1, 34, NULL),
(68, NULL, '', '2020267913', 'LISA', 'MANOBAN', '09890123457', 1, 34, NULL),
(69, NULL, '', '2021378024', 'RM', 'KIM', '09901234568', 1, 35, NULL),
(70, NULL, '', '2022489135', 'JIN', 'GUZMAN', '09123456781', 1, 35, NULL),
(71, NULL, '', '2023500246', 'SUGA', 'MIN', '09234567892', 1, 36, NULL),
(72, NULL, '', '2024611357', 'J-HOPE', 'CHOI', '09345678903', 1, 36, NULL),
(73, NULL, '', '2025722468', 'PO', 'HO-SEOK', '09456789014', 1, 37, NULL),
(74, NULL, '', '2026833579', 'JUNGKOOK', 'KIM', '09567890125', 1, 37, NULL),
(75, NULL, '', '2027944680', 'SOOBIN', 'HWANG', '09678901236', 1, 38, NULL),
(76, NULL, '', '2028055791', 'BEOMGYU', 'LEE', '09789012347', 1, 38, NULL),
(77, NULL, '', '2029166802', 'YEONJUN', 'SEOL', '09890123458', 1, 39, NULL),
(78, NULL, '', '2020277913', 'KAI', 'HUENING', '09901234569', 1, 39, NULL),
(79, NULL, '', '2021388024', 'TAEHYUN', 'KIM', '09123456782', 1, 40, NULL),
(80, NULL, '', '2022499135', 'JAEHYUN', 'MYUNG', '09234567893', 1, 40, NULL),
(81, NULL, '', '2023510246', 'DONGHYUN', 'LEE', '09345678904', 1, 41, NULL),
(82, NULL, '', '2024621357', 'RIWOO', 'LEE', '09456789015', 1, 41, NULL),
(83, NULL, '', '2025732468', 'KIM CHAEWON', 'KIM', '09567890126', 1, 42, NULL),
(84, NULL, '', '2026843579', 'YUQI', 'ZHANG', '09678901237', 1, 42, NULL),
(85, NULL, '', '2027954680', 'SERGI', 'HAN', '09789012348', 1, 43, NULL),
(86, NULL, '', '2028065791', 'XIAOXUAN', 'LI', '09890123459', 1, 43, NULL),
(87, NULL, '', '2029176802', 'YOUNG K', 'KANG', '09901234570', 1, 44, NULL),
(88, NULL, '', '2020287913', 'CHANGBIN', 'LEE', '09123456783', 1, 44, NULL),
(89, NULL, '', '2021398024', 'JAE', 'HYUN', '09234567894', 1, 45, NULL),
(90, NULL, '', '2022509135', 'YOUNG KWON', 'LEE', '09345678905', 1, 45, NULL),
(91, NULL, '', '2023620246', 'SUNGJAE', 'LEE', '09456789016', 1, 46, NULL),
(92, NULL, '', '2024731357', 'GDRAGON', 'KWON', '09567890127', 1, 46, NULL),
(93, NULL, '', '2025842468', 'TAEYANG', 'YANG', '09678901238', 1, 47, NULL),
(94, NULL, '', '2026953579', 'TOP', 'SEUNGYOON', '09789012349', 1, 47, NULL),
(95, NULL, '', '2027064680', 'DAESUNG', 'KIM', '09890123460', 1, 48, NULL),
(96, NULL, '', '2028175791', 'HEESEUNG', 'PARK', '09901234571', 1, 48, NULL),
(97, NULL, '', '2029286802', 'NIKI', 'KIM', '09123456784', 1, 49, NULL),
(98, NULL, '', '2020397913', 'JAY', 'PARK', '09234567895', 1, 49, NULL),
(99, NULL, '', '2021408024', 'JUNGWON', 'JI', '09345678906', 1, 50, NULL),
(100, NULL, '', '2022519135', 'EUIJIN', 'KIM', '09456789017', 1, 50, NULL),
(101, NULL, '', '2023630246', 'SUNGHOON', 'JUNG', '09567890128', 1, 51, NULL),
(102, NULL, '', '2024741357', 'TAEYONG', 'LEE', '09678901239', 1, 51, NULL),
(103, NULL, '', '2025852468', 'JAEHYUN', 'JUNG', '09789012350', 1, 52, NULL),
(104, NULL, '', '2026963579', 'MARK', 'TUAN', '09890123461', 1, 52, NULL),
(105, NULL, '', '2027074680', 'WINWIN', 'LEE', '09901234572', 1, 53, NULL),
(106, NULL, '', '2028185791', 'JOHNNY', 'JUNG', '09123456785', 1, 53, NULL),
(107, NULL, '', '2029296802', 'BAEKHYUN', 'OH', '09234567896', 1, 54, NULL),
(108, NULL, '', '2020407913', 'SUHO', 'KIM', '09345678907', 1, 54, NULL),
(109, NULL, '', '2021418024', 'LAY', 'ZHENHUA', '09456789018', 1, 55, NULL),
(110, NULL, '', '2022529135', 'CHEN', 'XINGTAO', '09567890129', 1, 55, NULL),
(111, NULL, '', '2023640246', 'DO', 'KYUNGSOO', '09678901240', 1, 56, NULL),
(112, NULL, '', '2024751357', 'HYEIN', 'LEE', '09789012351', 1, 56, NULL),
(113, NULL, '', '2025862468', 'MINJI', 'KIM', '09890123462', 1, 57, NULL),
(114, NULL, '', '2026973579', 'HAERIN', 'KIM', '09901234573', 1, 57, NULL),
(115, NULL, '', '2027084680', 'DANBI', 'LEE', '09123456786', 1, 58, NULL),
(116, NULL, '', '2028195791', 'RENNA', 'KIM', '09234567897', 1, 58, NULL),
(117, NULL, '', '2029306802', 'SOPHIA', 'GRACE', '09345678908', 1, 59, NULL),
(118, NULL, '', '2023355555', 'LARA', 'RAJAGOPALAN', '09456789019', 1, 59, NULL),
(119, NULL, '', '2025123456', 'SEO', 'JOON', '09123456789', 1, 60, NULL),
(120, NULL, '', '2025234567', 'KIM', 'JAEHYUN', '09234567890', 1, 60, NULL),
(121, NULL, '', '2025345678', 'LEE', 'SEUNGCHAN', '09345678901', 2, 61, NULL),
(122, NULL, '', '2025456789', 'SONG', 'MINHO', '09456789012', 2, 61, NULL),
(123, NULL, '', '2025567890', 'PARK', 'SUNGWOON', '09567890123', 2, 62, NULL),
(124, NULL, '', '2025678901', 'CHOI', 'YONGSEOK', '09678901234', 2, 62, NULL),
(125, NULL, '', '2025789012', 'HAN', 'JIWOO', '09789012345', 2, 63, NULL),
(126, NULL, '', '2025890123', 'JEONG', 'JINWOO', '09890123456', 2, 63, NULL),
(127, NULL, '', '2025901234', 'HWANG', 'YOONJAE', '09901234567', 2, 64, NULL),
(128, NULL, '', '2026012345', 'KIM', 'JUNGHAN', '09123456789', 2, 64, NULL),
(129, NULL, '', '2026123456', 'YU', 'YEONJUN', '09234567890', 2, 65, NULL),
(130, NULL, '', '2026234567', 'CHAE', 'BORA', '09345678901', 2, 65, NULL),
(131, NULL, '', '2026345678', 'OH', 'HAZEL', '09456789012', 2, 66, NULL),
(132, NULL, '', '2026456789', 'SON', 'SOOJIN', '09567890123', 2, 66, NULL),
(133, NULL, '', '2026567890', 'KIM', 'HAYOON', '09678901234', 2, 67, NULL),
(134, NULL, '', '2026678901', 'YU', 'SUHYEON', '09789012345', 2, 67, NULL),
(135, NULL, '', '2026789012', 'LEE', 'HYUNJIN', '09890123456', 2, 68, NULL),
(136, NULL, '', '2026890123', 'PARK', 'SIHEON', '09901234567', 2, 68, NULL),
(137, NULL, '', '2026901234', 'CHOI', 'HAEUN', '09123456789', 2, 69, NULL),
(138, NULL, '', '2027012345', 'JANG', 'YERIN', '09234567890', 2, 69, NULL),
(139, NULL, '', '2027123456', 'KIM', 'HYUNWOO', '09345678901', 2, 70, NULL),
(140, NULL, '', '2027234567', 'SONG', 'HAECHAN', '09456789012', 2, 70, NULL),
(141, NULL, '', '2027345678', 'LEE', 'CHANYEONG', '09567890123', 2, 71, NULL),
(142, NULL, '', '2027456789', 'KIM', 'DAMI', '09678901234', 2, 71, NULL),
(143, NULL, '', '2027567890', 'PARK', 'MINJUN', '09789012345', 2, 72, NULL),
(144, NULL, '', '2027678901', 'CHOI', 'YOSEOP', '09890123456', 2, 72, NULL),
(145, NULL, '', '2027789012', 'KIM', 'GYUJIN', '09901234567', 2, 73, NULL),
(146, NULL, '', '2027890123', 'LEE', 'JUNHO', '09123456789', 2, 73, NULL),
(147, NULL, '', '2027901234', 'PARK', 'SEOHAM', '09234567890', 2, 74, NULL),
(148, NULL, '', '2028012345', 'SONG', 'YOONAH', '09345678901', 2, 74, NULL),
(149, NULL, '', '2028123456', 'KIM', 'SOOJIN', '09456789012', 2, 75, NULL),
(150, NULL, '', '2028234567', 'LEE', 'SOOJIN', '09567890123', 2, 75, NULL),
(151, NULL, '', '2028345678', 'CHOI', 'SOOJIN', '09678901234', 2, 76, NULL),
(152, NULL, '', '2028456789', 'PARK', 'SOOJIN', '09789012345', 2, 76, NULL),
(153, NULL, '', '2028567890', 'KIM', 'YERIN', '09890123456', 2, 77, NULL),
(154, NULL, '', '2028678901', 'SONG', 'YERIN', '09901234567', 2, 77, NULL),
(155, NULL, '', '2028789012', 'LEE', 'YERIN', '09123456789', 2, 78, NULL),
(156, NULL, '', '2028890123', 'CHOI', 'YERIN', '09234567890', 2, 78, NULL),
(157, NULL, '', '2028901234', 'PARK', 'YERIN', '09345678901', 2, 79, NULL),
(158, NULL, '', '2029012345', 'KIM', 'DAHYUN', '09456789012', 2, 79, NULL),
(159, NULL, '', '2029123456', 'SONG', 'DAHYUN', '09567890123', 2, 80, NULL),
(160, NULL, '', '2029234567', 'LEE', 'DAHYUN', '09678901234', 2, 80, NULL),
(161, NULL, '', '2029345678', 'CHOI', 'DAHYUN', '09789012345', 2, 81, NULL),
(162, NULL, '', '2029456789', 'PARK', 'DAHYUN', '09890123456', 2, 81, NULL),
(163, NULL, '', '2029567890', 'KIM', 'SOOMIN', '09901234567', 2, 82, NULL),
(164, NULL, '', '2029678901', 'SONG', 'SOOMIN', '09123456789', 2, 82, NULL),
(165, NULL, '', '2029789012', 'LEE', 'SOOMIN', '09234567890', 2, 83, NULL),
(166, NULL, '', '2029890123', 'CHOI', 'SOOMIN', '09345678901', 2, 83, NULL),
(167, NULL, '', '2029901234', 'PARK', 'SOOMIN', '09456789012', 2, 84, NULL),
(168, NULL, '', '2020012345', 'KIM', 'YOUNGMIN', '09567890123', 2, 84, NULL),
(169, NULL, '', '2020123456', 'SONG', 'YOUNGMIN', '09678901234', 2, 85, NULL),
(170, NULL, '', '2020234567', 'LEE', 'YOUNGMIN', '09789012345', 2, 85, NULL),
(171, NULL, '', '2020345678', 'CHOI', 'YOUNGMIN', '09890123456', 2, 86, NULL),
(172, NULL, '', '2020456789', 'PARK', 'YOUNGMIN', '09901234567', 2, 86, NULL),
(173, NULL, '', '2020567890', 'KIM', 'KYUNGSOO', '09123456789', 2, 87, NULL),
(174, NULL, '', '2020678901', 'SONG', 'KYUNGSOO', '09234567890', 2, 87, NULL),
(175, NULL, '', '2020789012', 'LEE', 'KYUNGSOO', '09345678901', 2, 88, NULL),
(176, NULL, '', '2020890123', 'CHOI', 'KYUNGSOO', '09456789012', 2, 88, NULL),
(177, NULL, '', '2020901234', 'PARK', 'KYUNGSOO', '09567890123', 2, 89, NULL),
(178, NULL, '', '2021012345', 'KIM', 'MINGYU', '09678901234', 2, 89, NULL),
(179, NULL, '', '2021123456', 'SONG', 'MINGYU', '09789012345', 2, 90, NULL),
(180, NULL, '', '2021234567', 'LEE', 'MINGYU', '09890123456', 2, 90, NULL),
(181, NULL, '', '2021345678', 'CHOI', 'MINGYU', '09901234567', 2, 91, NULL),
(182, NULL, '', '2021456789', 'PARK', 'MINGYU', '09123456789', 2, 91, NULL),
(183, NULL, '', '2021567890', 'KIM', 'SEUNGMIN', '09234567890', 2, 92, NULL),
(184, NULL, '', '2021678901', 'SONG', 'SEUNGMIN', '09345678901', 2, 92, NULL),
(185, NULL, '', '2021789012', 'LEE', 'SEUNGMIN', '09456789012', 2, 93, NULL),
(186, NULL, '', '2021890123', 'CHOI', 'SEUNGMIN', '09567890123', 2, 93, NULL),
(187, NULL, '', '2021901234', 'PARK', 'SEUNGMIN', '09678901234', 2, 94, NULL),
(188, NULL, '', '2022012345', 'KIM', 'SOOJIN', '09789012345', 2, 94, NULL),
(189, NULL, '', '2022123456', 'SONG', 'SOOJIN', '09890123456', 2, 95, NULL),
(190, NULL, '', '2022234567', 'LEE', 'SOOJIN', '09901234567', 2, 95, NULL),
(191, NULL, '', '2022345678', 'CHOI', 'SOOJIN', '09123456789', 2, 96, NULL),
(192, NULL, '', '2022456789', 'PARK', 'SOOJIN', '09234567890', 2, 96, NULL),
(193, NULL, '', '2022567890', 'KIM', 'SOOJIN', '09345678901', 2, 97, NULL),
(194, NULL, '', '2022678901', 'SONG', 'SOOJIN', '09456789012', 2, 97, NULL),
(195, NULL, '', '2022789012', 'SMITH', 'JOHN', '09567890123', 2, 98, NULL),
(196, NULL, '', '2022890123', 'JOHNSON', 'EMILY', '09678901234', 2, 98, NULL),
(197, NULL, '', '2022901234', 'WILLIAMS', 'MICHAEL', '09789012345', 2, 99, NULL),
(198, NULL, '', '2023012345', 'BROWN', 'JESSICA', '09890123456', 2, 99, NULL),
(199, NULL, '', '2023123456', 'JONES', 'WILLIAM', '09901234567', 2, 100, NULL),
(200, NULL, '', '2023234567', 'GARCIA', 'OLIVIA', '09123456789', 2, 100, NULL),
(201, NULL, '', '2023345678', 'MILLER', 'DAVID', '09234567890', 2, 101, NULL),
(202, NULL, '', '2023456789', 'DAVIS', 'SOPHIA', '09345678901', 2, 101, NULL),
(203, NULL, '', '2023567890', 'RODRIQUEZ', 'MATTHEW', '09456789012', 2, 102, NULL),
(204, NULL, '', '2023678901', 'MARTINEZ', 'ISABELLA', '09567890123', 2, 102, NULL),
(205, NULL, '', '2023789012', 'ANDERSON', 'JAMES', '09678901234', 2, 103, NULL),
(206, NULL, '', '2023890123', 'THOMAS', 'LUCAS', '09789012345', 2, 103, NULL),
(207, NULL, '', '2023901234', 'TAYLOR', 'CHARLES', '09890123456', 2, 104, NULL),
(208, NULL, '', '2024012345', 'MOORE', 'THOMAS', '09901234567', 2, 104, NULL),
(209, NULL, '', '2024123456', 'WHITE', 'JOSEPH', '09123456789', 2, 105, NULL),
(210, NULL, '', '2024234567', 'HARRIS', 'ALEXANDER', '09234567890', 2, 105, NULL),
(211, NULL, '', '2024345678', 'CLARK', 'BENJAMIN', '09345678901', 2, 106, NULL),
(212, NULL, '', '2024456789', 'LEWIS', 'DANIEL', '09456789012', 2, 106, NULL),
(213, NULL, '', '2024567890', 'ROBINSON', 'ETHAN', '09567890123', 2, 107, NULL),
(214, NULL, '', '2024678901', 'WALKER', 'JACOB', '09678901234', 2, 107, NULL),
(215, NULL, '', '2024789012', 'ALLEN', 'ANTHONY', '09789012345', 2, 108, NULL),
(216, NULL, '', '2024890123', 'KING', 'FREDERICK', '09890123456', 2, 108, NULL),
(217, NULL, '', '2024901234', 'SCOTT', 'GEORGE', '09901234567', 2, 109, NULL),
(218, NULL, '', '2025012345', 'ADAMS', 'JORDAN', '09123456789', 2, 109, NULL),
(219, NULL, '', '2025123456', 'BAKER', 'NATHAN', '09234567890', 2, 110, NULL),
(220, NULL, '', '2025234567', 'GARDNER', 'RILEY', '09345678901', 2, 110, NULL),
(221, NULL, '', '2025345678', 'EVANS', 'NOAH', '09456789012', 2, 111, NULL),
(222, NULL, '', '2025456789', 'HALL', 'LIAM', '09567890123', 2, 111, NULL),
(223, NULL, '', '2025567890', 'COOPER', 'JASON', '09678901234', 2, 112, NULL),
(224, NULL, '', '2025678901', 'REED', 'BRANDON', '09789012345', 2, 112, NULL),
(225, NULL, '', '2025789012', 'MITCHELL', 'JUSTIN', '09890123456', 2, 113, NULL),
(226, NULL, '', '2025890123', 'PETERSON', 'CAMERON', '09901234567', 2, 113, NULL),
(227, NULL, '', '2025901234', 'GRANT', 'BRADLEY', '09123456789', 2, 114, NULL),
(228, NULL, '', '2026012345', 'HUNTER', 'MATTHEW', '09234567890', 2, 114, NULL),
(229, NULL, '', '2026123456', 'STEWART', 'CALEB', '09345678901', 2, 115, NULL),
(230, NULL, '', '2026234567', 'PORTER', 'JACKSON', '09456789012', 2, 115, NULL),
(231, NULL, '', '2026345678', 'FOSTER', 'LOGAN', '09567890123', 2, 116, NULL),
(232, NULL, '', '2026456789', 'GRAY', 'OWEN', '09678901234', 2, 116, NULL),
(233, NULL, '', '2026567890', 'HAYES', 'AARON', '09789012345', 2, 117, NULL),
(234, NULL, '', '2026678901', 'FLETCHER', 'ERIC', '09890123456', 2, 117, NULL),
(235, NULL, '', '2026789012', 'LYMAN', 'JUAN', '09901234567', 2, 118, NULL),
(236, NULL, '', '2026890123', 'WEBB', 'JULIAN', '09123456789', 2, 118, NULL),
(237, NULL, '', '2026901234', 'CARPENTER', 'ADRIAN', '09234567890', 2, 119, NULL),
(238, NULL, '', '2027012345', 'COLE', 'GABRIEL', '09345678901', 2, 119, NULL),
(239, NULL, '', '2027123456', 'FIELDS', 'BRADLEY', '09456789012', 2, 120, NULL),
(240, NULL, '', '2027234567', 'HAWKINS', 'MAXWELL', '09567890123', 2, 120, NULL),
(241, NULL, '', '2027345678', 'BUTLER', 'HENRY', '09678901234', 3, 121, NULL),
(242, NULL, '', '2027456789', 'FISHER', 'SIMON', '09789012345', 3, 121, NULL),
(243, NULL, '', '2027567890', 'BROOKS', 'SEBASTIAN', '09890123456', 3, 122, NULL),
(244, NULL, '', '2027678901', 'BARNES', 'JAYDEN', '09901234567', 3, 122, NULL),
(245, NULL, '', '2027789012', 'HENDRICKS', 'NICHOLAS', '09123456789', 3, 123, NULL),
(246, NULL, '', '2027890123', 'HENDERSON', 'SAMUEL', '09234567890', 3, 123, NULL),
(247, NULL, '', '2027901234', 'HAYNES', 'JEREMY', '09345678901', 3, 124, NULL),
(248, NULL, '', '2028012345', 'HUNT', 'ADAM', '09456789012', 3, 124, NULL),
(249, NULL, '', '2028123456', 'HODGES', 'JONATHAN', '09567890123', 3, 125, NULL),
(250, NULL, '', '2028234567', 'HOWARD', 'ISAIAH', '09678901234', 3, 125, NULL),
(251, NULL, '', '2028901234', 'GIBSON', 'NATHANIEL', '09789012345', 3, 126, NULL),
(252, NULL, '', '2029012345', 'REED', 'BENJAMIN', '09890123456', 3, 126, NULL),
(253, NULL, '', '2029123456', 'MORRIS', 'DANNY', '09901234567', 3, 127, NULL),
(254, NULL, '', '2029234567', 'COLEMAN', 'VINCENT', '09123456789', 3, 127, NULL),
(255, NULL, '', '2029345678', 'WELLS', 'ALAN', '09234567890', 3, 128, NULL),
(256, NULL, '', '2029456789', 'FORD', 'TANNER', '09345678901', 3, 128, NULL),
(257, NULL, '', '2029567890', 'DEAN', 'AIDEN', '09456789012', 3, 129, NULL),
(258, NULL, '', '2029678901', 'WARD', 'KAYDEN', '09567890123', 3, 129, NULL),
(259, NULL, '', '2029789012', 'WEBSTER', 'CARTER', '09678901234', 3, 130, NULL),
(260, NULL, '', '2029890123', 'PATTERSON', 'LANDON', '09789012345', 3, 130, NULL),
(261, NULL, '', '2029901234', 'GRAYSON', 'COLIN', '09890123456', 3, 131, NULL),
(262, NULL, '', '2020012345', 'RAMSEY', 'LANDON', '09901234567', 3, 131, NULL),
(263, NULL, '', '2020123456', 'SHELTON', 'GAVIN', '09123456789', 3, 132, NULL),
(264, NULL, '', '2020234567', 'BROOKS', 'SOOJIN', '09234567890', 3, 132, NULL),
(265, NULL, '', '2020345678', 'BARNETT', 'JASPER', '09345678901', 3, 133, NULL),
(266, NULL, '', '2020456789', 'CARSON', 'BRAXTON', '09456789012', 3, 133, NULL),
(267, NULL, '', '2020567890', 'LLOYD', 'XAVIER', '09567890123', 3, 134, NULL),
(268, NULL, '', '2020678901', 'MCKINNEY', 'GIDEON', '09678901234', 3, 134, NULL),
(269, NULL, '', '2020789012', 'JOYCE', 'JASPER', '09789012345', 3, 135, NULL),
(270, NULL, '', '2020890123', 'HARVEY', 'BECKETT', '09890123456', 3, 135, NULL),
(271, NULL, '', '2020901234', 'BUTLER', 'MILES', '09901234567', 3, 136, NULL),
(272, NULL, '', '2021012345', 'FLETCHER', 'ANDREW', '09123456789', 3, 136, NULL),
(273, NULL, '', '2021123456', 'ELLIS', 'JACOB', '09234567890', 3, 137, NULL),
(274, NULL, '', '2021234567', 'HARRISON', 'DUSTIN', '09345678901', 3, 137, NULL),
(275, NULL, '', '2021345678', 'LYONS', 'MATTHEW', '09456789012', 3, 138, NULL),
(276, NULL, '', '2021456789', 'BRODERICK', 'LIAM', '09567890123', 3, 138, NULL),
(277, NULL, '', '2021567890', 'WATSON', 'NOAH', '09678901234', 3, 139, NULL),
(278, NULL, '', '2021678901', 'BOWMAN', 'ETHAN', '09789012345', 3, 139, NULL),
(279, NULL, '', '2021789012', 'DAWSON', 'LUKE', '09890123456', 3, 140, NULL),
(280, NULL, '', '2021890123', 'STANTON', 'JORDAN', '09901234567', 3, 140, NULL),
(281, NULL, '', '2021901234', 'SHERMAN', 'ALEX', '09123456789', 3, 141, NULL),
(282, NULL, '', '2022012345', 'GARDNER', 'RILEY', '09234567890', 3, 141, NULL),
(283, NULL, '', '2022123456', 'EVANS', 'NOAH', '09345678901', 3, 142, NULL),
(284, NULL, '', '2022234567', 'HALL', 'LIAM', '09456789012', 3, 142, NULL),
(285, NULL, '', '2022345678', 'COOPER', 'JASON', '09567890123', 3, 143, NULL),
(286, NULL, '', '2022456789', 'REED', 'BRANDON', '09678901234', 3, 143, NULL),
(287, NULL, '', '2022567890', 'MITCHELL', 'JUSTIN', '09789012345', 3, 144, NULL),
(288, NULL, '', '2022678901', 'PETERSON', 'CAMERON', '09890123456', 3, 144, NULL),
(289, NULL, '', '2022789012', 'GRANT', 'BRADLEY', '09901234567', 3, 145, NULL),
(290, NULL, '', '2022890123', 'HUNTER', 'MATTHEW', '09123456789', 3, 145, NULL),
(291, NULL, '', '2022901234', 'STEWART', 'CALEB', '09234567890', 3, 146, NULL),
(292, NULL, '', '2023012345', 'PORTER', 'JACKSON', '09345678901', 3, 146, NULL),
(293, NULL, '', '2023123456', 'FOSTER', 'LOGAN', '09456789012', 3, 147, NULL),
(294, NULL, '', '2023234567', 'GRAY', 'OWEN', '09567890123', 3, 147, NULL),
(295, NULL, '', '2023345678', 'FIELDS', 'BRADLEY', '09678901234', 3, 148, NULL),
(296, NULL, '', '2023456789', 'HAWKINS', 'MAXWELL', '09789012345', 3, 148, NULL),
(297, NULL, '', '2023567890', 'CARPENTER', 'SEBASTIAN', '09890123456', 3, 149, NULL),
(298, NULL, '', '2023678901', 'COLE', 'GABRIEL', '09901234567', 3, 149, NULL),
(299, NULL, '', '2023789012', 'BUTLER', 'HENRY', '09123456789', 3, 150, NULL),
(300, NULL, '', '2023890123', 'FLETCHER', 'SIMON', '09234567890', 3, 150, NULL),
(301, NULL, '', '2023901234', 'WEBSTER', 'FRANKLIN', '09345678901', 3, 151, NULL),
(302, NULL, '', '2024012345', 'PATTERSON', 'JULIAN', '09456789012', 3, 151, NULL),
(303, NULL, '', '2024123456', 'GRAYSON', 'NATHAN', '09567890123', 3, 152, NULL),
(304, NULL, '', '2024234567', 'RAMSEY', 'RILEY', '09678901234', 3, 152, NULL),
(305, NULL, '', '2024345678', 'SHELTON', 'NICHOLAS', '09789012345', 3, 153, NULL),
(306, NULL, '', '2024456789', 'BROOKS', 'KENNETH', '09890123456', 3, 153, NULL),
(307, NULL, '', '2024567890', 'BARNES', 'MARCUS', '09901234567', 3, 154, NULL),
(308, NULL, '', '2024678901', 'HENDRICKS', 'MALCOLM', '09123456789', 3, 154, NULL),
(309, NULL, '', '2024789012', 'HENDERSON', 'MADDEN', '09234567890', 3, 155, NULL),
(310, NULL, '', '2024890123', 'HAYNES', 'MARSHALL', '09345678901', 3, 155, NULL),
(311, NULL, '', '2024901234', 'HUNT', 'MICHAEL', '09456789012', 3, 156, NULL),
(312, NULL, '', '2025012345', 'HODGES', 'WILLIAM', '09567890123', 3, 156, NULL),
(313, NULL, '', '2025123456', 'ANDERSON', 'JAMES', '09678901234', 3, 157, NULL),
(314, NULL, '', '2025234567', 'THOMAS', 'CHARLES', '09789012345', 3, 157, NULL),
(315, NULL, '', '2025345678', 'TAYLOR', 'THOMAS', '09890123456', 3, 158, NULL),
(316, NULL, '', '2025456789', 'MOORE', 'ANTHONY', '09901234567', 3, 158, NULL),
(317, NULL, '', '2025567890', 'WHITE', 'JUAN', '09123456789', 3, 159, NULL),
(318, NULL, '', '2025678901', 'HARRIS', 'JULIAN', '09234567890', 3, 159, NULL),
(319, NULL, '', '2025789012', 'CLARK', 'ADRIAN', '09345678901', 3, 160, NULL),
(320, NULL, '', '2025890123', 'LEWIS', 'ERIC', '09456789012', 3, 160, NULL),
(321, NULL, '', '2025901234', 'ROBINSON', 'AARON', '09567890123', 3, 161, NULL),
(322, NULL, '', '2026012345', 'WALKER', 'RICHARD', '09678901234', 3, 161, NULL),
(323, NULL, '', '2026123456', 'ALLEN', 'STEPHEN', '09789012345', 3, 162, NULL),
(324, NULL, '', '2026234567', 'KING', 'JEREMIAH', '09890123456', 3, 162, NULL),
(325, NULL, '', '2026345678', 'SCOTT', 'JEROME', '09901234567', 3, 163, NULL),
(326, NULL, '', '2026456789', 'ADAMS', 'CASEY', '09123456789', 3, 163, NULL),
(327, NULL, '', '2026567890', 'BAKER', 'GREGORY', '09234567890', 3, 164, NULL),
(328, NULL, '', '2026678901', 'GARDNER', 'FELIX', '09345678901', 3, 164, NULL),
(329, NULL, '', '2026789012', 'EVANS', 'THEODORE', '09456789012', 3, 165, NULL),
(330, NULL, '', '2026890123', 'HALL', 'GABRIEL', '09567890123', 3, 165, NULL),
(331, NULL, '', '2026901234', 'COOPER', 'DOMINIC', '09678901234', 3, 166, NULL),
(332, NULL, '', '2027012345', 'REED', 'JORDAN', '09789012345', 3, 166, NULL),
(333, NULL, '', '2027123456', 'MITCHELL', 'JUAN', '09890123456', 3, 167, NULL),
(334, NULL, '', '2027234567', 'PETERSON', 'DARIUS', '09901234567', 3, 167, NULL),
(335, NULL, '', '2027345678', 'GRANT', 'BRODY', '09123456789', 3, 168, NULL),
(336, NULL, '', '2027456789', 'HUNTER', 'JOSIAH', '09234567890', 3, 168, NULL),
(337, NULL, '', '2027567890', 'STEWART', 'JASPER', '09345678901', 3, 169, NULL),
(338, NULL, '', '2027678901', 'PORTER', 'QUINCY', '09456789012', 3, 169, NULL),
(339, NULL, '', '2027789012', 'FOSTER', 'JOSHUA', '09567890123', 3, 170, NULL),
(340, NULL, '', '2027890123', 'GRAY', 'NATHANIEL', '09678901234', 3, 170, NULL),
(341, NULL, '', '2027901234', 'FIELDS', 'MATTHEW', '09789012345', 3, 171, NULL),
(342, NULL, '', '2028012345', 'HAYES', 'LIAM', '09890123456', 3, 171, NULL),
(343, NULL, '', '2028123456', 'FLETCHER', 'OWEN', '09901234567', 3, 172, NULL),
(344, NULL, '', '2028234567', 'LYMAN', 'MAXWELL', '09123456789', 3, 172, NULL),
(345, NULL, '', '2028345678', 'WEBB', 'JULIAN', '09234567890', 3, 173, NULL),
(346, NULL, '', '2028456789', 'CARPENTER', 'GABE', '09345678901', 3, 173, NULL),
(347, NULL, '', '2028567890', 'COLE', 'MARCUS', '09456789012', 3, 174, NULL),
(348, NULL, '', '2028678901', 'FIELDS', 'BENJAMIN', '09567890123', 3, 174, NULL),
(349, NULL, '', '2028789012', 'LYONS', 'CALEB', '09678901234', 3, 175, NULL),
(350, NULL, '', '2028890123', 'BRODERICK', 'DANNY', '09789012345', 3, 175, NULL),
(351, NULL, '', '2028901234', 'WELLS', 'VINCENT', '09890123456', 3, 176, NULL),
(352, NULL, '', '2029012345', 'WARD', 'GIDEON', '09901234567', 3, 176, NULL),
(353, NULL, '', '2029123456', 'WEBSTER', 'ISAIAH', '09123456789', 3, 177, NULL),
(354, NULL, '', '2029234567', 'PATTERSON', 'NATHAN', '09234567890', 3, 177, NULL),
(355, NULL, '', '2029345678', 'GRAYSON', 'SIMON', '09345678901', 3, 178, NULL),
(356, NULL, '', '2029456789', 'RAMSEY', 'CARTER', '09456789012', 3, 178, NULL),
(357, NULL, '', '2029567890', 'SHELTON', 'LANDON', '09567890123', 3, 179, NULL),
(358, NULL, '', '2029678901', 'BROOKS', 'BECKETT', '09678901234', 3, 179, NULL),
(359, NULL, '', '2029789012', 'BARNETT', 'JASPER', '09789012345', 3, 180, NULL),
(360, NULL, '', '2029890123', 'CARSON', 'BRAXTON', '09890123456', 3, 180, NULL),
(361, NULL, '', '2029901234', 'LLOYD', 'XAVIER', '09901234567', 4, 181, NULL),
(362, NULL, '', '2020012345', 'MCKINNEY', 'GIDEON', '09123456789', 4, 181, NULL),
(363, NULL, '', '2020123456', 'JOYCE', 'JASPER', '09234567890', 4, 182, NULL),
(364, NULL, '', '2020234567', 'HARVEY', 'BECKETT', '09345678901', 4, 182, NULL),
(365, NULL, '', '2020345678', 'BUTLER', 'MILES', '09456789012', 4, 183, NULL),
(366, NULL, '', '2020456789', 'FLETCHER', 'ANDREW', '09567890123', 4, 183, NULL),
(367, NULL, '', '2020567890', 'ELLIS', 'JACOB', '09678901234', 4, 184, NULL),
(368, NULL, '', '2020678901', 'HARRISON', 'DUSTIN', '09789012345', 4, 184, NULL),
(369, NULL, '', '2020789012', 'LYONS', 'MATTHEW', '09890123456', 4, 185, NULL),
(370, NULL, '', '2020890123', 'BRODERICK', 'LIAM', '09901234567', 4, 185, NULL),
(371, NULL, '', '2020901234', 'WATSON', 'NOAH', '09123456789', 4, 186, NULL),
(372, NULL, '', '2021012345', 'BOWMAN', 'ETHAN', '09234567890', 4, 186, NULL),
(373, NULL, '', '2021123456', 'DAWSON', 'LUKE', '09345678901', 4, 187, NULL),
(374, NULL, '', '2021234567', 'STANTON', 'JORDAN', '09456789012', 4, 187, NULL),
(375, NULL, '', '2021345678', 'SHERMAN', 'ALEX', '09567890123', 4, 188, NULL),
(376, NULL, '', '2021456789', 'GARDNER', 'RILEY', '09678901234', 4, 188, NULL),
(377, NULL, '', '2021567890', 'EVANS', 'NOAH', '09789012345', 4, 189, NULL),
(378, NULL, '', '2021678901', 'HALL', 'LIAM', '09890123456', 4, 189, NULL),
(379, NULL, '', '2021789012', 'COOPER', 'JASPER', '09901234567', 4, 190, NULL),
(380, NULL, '', '2021890123', 'REED', 'BRAXTON', '09123456789', 4, 190, NULL),
(381, NULL, '', '2021901234', 'MITCHELL', 'KENNETH', '09234567890', 4, 191, NULL),
(382, NULL, '', '2022012345', 'PETERSON', 'MARCUS', '09345678901', 4, 191, NULL),
(383, NULL, '', '2022123456', 'GRANT', 'MALCOLM', '09456789012', 4, 192, NULL),
(384, NULL, '', '2022234567', 'HUNTER', 'MADDEN', '09567890123', 4, 192, NULL),
(385, NULL, '', '2022345678', 'STEWART', 'MARSHALL', '09678901234', 4, 193, NULL),
(386, NULL, '', '2022456789', 'PORTER', 'GIDEON', '09789012345', 4, 193, NULL),
(387, NULL, '', '2022567890', 'FOSTER', 'JASPER', '09890123456', 4, 194, NULL),
(388, NULL, '', '2022678901', 'GRAY', 'BECKETT', '09901234567', 4, 194, NULL),
(389, NULL, '', '2022789012', 'FIELDS', 'JACKSON', '09123456789', 4, 195, NULL),
(390, NULL, '', '2022890123', 'HAYES', 'MAX', '09234567890', 4, 195, NULL),
(391, NULL, '', '2022901234', 'FLETCHER', 'QUINCY', '09345678901', 4, 196, NULL),
(392, NULL, '', '2023012345', 'LYMAN', 'JUAN', '09456789012', 4, 196, NULL),
(393, NULL, '', '2023123456', 'WEBB', 'JULIAN', '09567890123', 4, 197, NULL),
(394, NULL, '', '2023234567', 'CARPENTER', 'SEBASTIAN', '09678901234', 4, 197, NULL),
(395, NULL, '', '2023345678', 'COLE', 'VINCENT', '09789012345', 4, 198, NULL),
(396, NULL, '', '2023456789', 'FIELDS', 'AIDEN', '09890123456', 4, 198, NULL),
(397, NULL, '', '2023567890', 'LYONS', 'KAYDEN', '09901234567', 4, 199, NULL),
(398, NULL, '', '2023678901', 'BRODERICK', 'NATHANIEL', '09123456789', 4, 199, NULL),
(399, NULL, '', '2023789012', 'WELLS', 'JORDAN', '09234567890', 4, 200, NULL),
(400, NULL, '', '2023890123', 'WARD', 'ISAIAH', '09345678901', 4, 200, NULL),
(401, NULL, '', '2023901234', 'WEBSTER', 'GIDEON', '09456789012', 4, 201, NULL),
(402, NULL, '', '2024012345', 'PATTERSON', 'FELIX', '09567890123', 4, 201, NULL),
(403, NULL, '', '2024123456', 'GRAYSON', 'THEODORE', '09678901234', 4, 202, NULL),
(404, NULL, '', '2024234567', 'RAMSEY', 'GAVIN', '09789012345', 4, 202, NULL),
(405, NULL, '', '2024345678', 'SHELTON', 'MILES', '09890123456', 4, 203, NULL),
(406, NULL, '', '2024456789', 'BROOKS', 'NATHAN', '09901234567', 4, 203, NULL),
(407, NULL, '', '2024567890', 'BARNETT', 'SIMON', '09123456789', 4, 204, NULL),
(408, NULL, '', '2024678901', 'CARSON', 'CARTER', '09234567890', 4, 204, NULL),
(409, NULL, '', '2024789012', 'LLOYD', 'LANDON', '09345678901', 4, 205, NULL),
(410, NULL, '', '2024890123', 'MCKINNEY', 'BECKETT', '09456789012', 4, 205, NULL),
(411, NULL, '', '2024901234', 'JOYCE', 'BRADLEY', '09567890123', 4, 206, NULL),
(412, NULL, '', '2025012345', 'HARVEY', 'JASPER', '09678901234', 4, 206, NULL),
(413, NULL, '', '2025123456', 'BUTLER', 'MAXWELL', '09789012345', 4, 207, NULL),
(414, NULL, '', '2025234567', 'FLETCHER', 'ETHAN', '09890123456', 4, 207, NULL),
(415, NULL, '', '2025345678', 'ELLIS', 'NOAH', '09901234567', 4, 208, NULL),
(416, NULL, '', '2025456789', 'HARRISON', 'LIAM', '09123456789', 4, 208, NULL),
(417, NULL, '', '2025567890', 'LYONS', 'JACOB', '09234567890', 4, 209, NULL),
(418, NULL, '', '2025678901', 'BRODERICK', 'DUSTIN', '09345678901', 4, 209, NULL),
(419, NULL, '', '2025789012', 'WATSON', 'DANNY', '09456789012', 4, 210, NULL),
(420, NULL, '', '2025890123', 'BOWMAN', 'GABE', '09567890123', 4, 210, NULL),
(421, NULL, '', '2025901234', 'DAWSON', 'SEBASTIAN', '09678901234', 4, 211, NULL),
(422, NULL, '', '2026012345', 'STANTON', 'JULIAN', '09789012345', 4, 211, NULL),
(423, NULL, '', '2026123456', 'SHERMAN', 'FRANKLIN', '09890123456', 4, 212, NULL),
(424, NULL, '', '2026234567', 'GARDNER', 'JEREMY', '09901234567', 4, 212, NULL),
(425, NULL, '', '2026345678', 'EVANS', 'JEREMIAH', '09123456789', 4, 213, NULL),
(426, NULL, '', '2026456789', 'HALL', 'JORDAN', '09234567890', 4, 213, NULL),
(427, NULL, '', '2026567890', 'COOPER', 'CASEY', '09345678901', 4, 214, NULL),
(428, NULL, '', '2026678901', 'REED', 'GREGORY', '09456789012', 4, 214, NULL),
(429, NULL, '', '2026789012', 'MITCHELL', 'MARCUS', '09567890123', 4, 215, NULL),
(430, NULL, '', '2026890123', 'PETERSON', 'KENNETH', '09678901234', 4, 215, NULL),
(431, NULL, '', '2026901234', 'GRANT', 'BRADEN', '09789012345', 4, 216, NULL),
(432, NULL, '', '2027012345', 'HUNTER', 'BRODY', '09890123456', 4, 216, NULL),
(433, NULL, '', '2027123456', 'STEWART', 'NATHAN', '09901234567', 4, 217, NULL),
(434, NULL, '', '2027234567', 'PORTER', 'SIMON', '09123456789', 4, 217, NULL),
(435, NULL, '', '2027345678', 'FOSTER', 'JASPER', '09234567890', 4, 218, NULL),
(436, NULL, '', '2027456789', 'GRAY', 'BRAXTON', '09345678901', 4, 218, NULL),
(437, NULL, '', '2027567890', 'FIELDS', 'MAXWELL', '09456789012', 4, 219, NULL),
(438, NULL, '', '2027678901', 'HAYES', 'GIDEON', '09567890123', 4, 219, NULL),
(439, NULL, '', '2027789012', 'FLETCHER', 'JUAN', '09678901234', 4, 220, NULL),
(440, NULL, '', '2027890123', 'LYMAN', 'JULIAN', '09789012345', 4, 220, NULL),
(441, NULL, '', '2027901234', 'WEBB', 'MARSHALL', '09890123456', 4, 221, NULL),
(442, NULL, '', '2028012345', 'CARPENTER', 'GIDEON', '09901234567', 4, 221, NULL),
(443, NULL, '', '2028123456', 'COLE', 'JASPER', '09123456789', 4, 222, NULL),
(444, NULL, '', '2028234567', 'FIELDS', 'BRADLEY', '09234567890', 4, 222, NULL),
(445, NULL, '', '2028345678', 'LYONS', 'KENNETH', '09345678901', 4, 223, NULL),
(446, NULL, '', '2028456789', 'BRODERICK', 'NATHANIEL', '09456789012', 4, 223, NULL),
(447, NULL, '', '2028567890', 'WELLS', 'MARCUS', '09567890123', 4, 224, NULL),
(448, NULL, '', '2028678901', 'WARD', 'VINCENT', '09678901234', 4, 224, NULL),
(449, NULL, '', '2028789012', 'WEBSTER', 'MADDEN', '09789012345', 4, 225, NULL),
(450, NULL, '', '2028890123', 'PATTERSON', 'MALCOLM', '09890123456', 4, 225, NULL),
(451, NULL, '', '2028901234', 'GRAYSON', 'MARSHALL', '09901234567', 4, 226, NULL),
(452, NULL, '', '2029012345', 'RAMSEY', 'GIDEON', '09123456789', 4, 226, NULL),
(453, NULL, '', '2029123456', 'SHELTON', 'JASPER', '09234567890', 4, 227, NULL),
(454, NULL, '', '2029234567', 'BROOKS', 'BRAXTON', '09345678901', 4, 227, NULL),
(455, NULL, '', '2029345678', 'BARNETT', 'KENNETH', '09456789012', 4, 228, NULL),
(456, NULL, '', '2029456789', 'CARSON', 'SIMON', '09567890123', 4, 228, NULL),
(457, NULL, '', '2029567890', 'LLOYD', 'QUINCY', '09678901234', 4, 229, NULL),
(458, NULL, '', '2029678901', 'MCKINNEY', 'JULIAN', '09789012345', 4, 229, NULL),
(459, NULL, '', '2029789012', 'JOYCE', 'JUAN', '09890123456', 4, 230, NULL),
(460, NULL, '', '2029890123', 'HARVEY', 'GREGORY', '09901234567', 4, 230, NULL),
(461, NULL, '', '2029901234', 'BUTLER', 'THEODORE', '09123456789', 4, 231, NULL),
(462, NULL, '', '2020012345', 'FLETCHER', 'FELIX', '09234567890', 4, 231, NULL),
(463, NULL, '', '2020123456', 'WEBSTER', 'JASPER', '09345678901', 4, 232, NULL),
(464, NULL, '', '2020234567', 'PATTERSON', 'BRADLEY', '09456789012', 4, 232, NULL),
(465, NULL, '', '2020345678', 'GRAYSON', 'JEREMY', '09567890123', 4, 233, NULL),
(466, NULL, '', '2020456789', 'RAMSEY', 'JEREMIAH', '09678901234', 4, 233, NULL),
(467, NULL, '', '2020567890', 'SHELTON', 'JORDAN', '09789012345', 4, 234, NULL),
(468, NULL, '', '2020678901', 'BROOKS', 'CASEY', '09890123456', 4, 234, NULL),
(469, NULL, '', '2020789012', 'BARNETT', 'GABE', '09901234567', 4, 235, NULL),
(470, NULL, '', '2020890123', 'CARSON', 'MARCUS', '09123456789', 4, 235, NULL),
(471, NULL, '', '2020901234', 'LLOYD', 'VINCENT', '09234567890', 4, 236, NULL),
(472, NULL, '', '2021012345', 'MCKINNEY', 'DANNY', '09345678901', 4, 236, NULL),
(473, NULL, '', '2021123456', 'JOYCE', 'MAXWELL', '09456789012', 4, 237, NULL),
(474, NULL, '', '2021234567', 'HARVEY', 'GIDEON', '09567890123', 4, 237, NULL),
(475, NULL, '', '2021345678', 'STEWART', 'JUAN', '09678901234', 4, 238, NULL),
(476, NULL, '', '2021456789', 'PORTER', 'JULIAN', '09789012345', 4, 238, NULL),
(477, NULL, '', '2021567890', 'FOSTER', 'FRANKLIN', '09890123456', 4, 239, NULL),
(478, NULL, '', '2021678901', 'GRAY', 'JEREMY', '09901234567', 4, 239, NULL),
(479, NULL, '', '2021789012', 'FIELDS', 'JEREMIAH', '09123456789', 4, 240, NULL),
(480, NULL, '', '2021890123', 'HAYES', 'JASPER', '09234567890', 4, 240, NULL);

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
(65, 822, 'Worried about your health or about getting sick'),
(66, 822, 'Been bothered by not being able to fall asleep or stay asleep, or by waking up too early'),
(67, 822, 'Been bothered by not being able to focus when you were in class or doing homework/reading a book/playing a game'),
(68, 822, 'Had less fun doing things than you used to'),
(69, 822, 'Felt sad or depressed for several hours'),
(70, 822, 'Felt more irritated or easily annoyed than usual'),
(71, 822, 'Felt angry or lost your temper'),
(72, 822, 'Feeling nervous, anxious, or scared'),
(73, 822, 'Not been able to stop worrying'),
(74, 822, 'Not been able to do things you wanted to or should have done, because they made you feel nervous'),
(75, 822, 'Little interest or pleasure in doing things'),
(76, 823, 'Had an alcoholic beverage (beer, wine, liquor, etc)?'),
(77, 823, 'Smoked a cigarette/vape?'),
(78, 823, 'Used prohibited drugs?'),
(79, 823, 'Used any medicine without a doctor’s prescription to get high or change the way you feel?'),
(80, 823, 'Have you thought about ending your life or committing suicide?'),
(81, 823, 'Have you EVER tried to kill yourself?'),
(82, 826, 'I have thoughts about killing myself in the last 7 days.'),
(83, 826, 'I wish I could go to sleep and never wake up.'),
(84, 826, 'I feel hopeless about my current situation.'),
(85, 826, 'I have taken steps to prepare to end my life'),
(86, 826, 'I have tried inflicting harm to myself within the last 7 days.'),
(87, 826, 'I am thinking about harming or killing someone.'),
(88, 826, 'I had suicidal attempts'),
(89, 845, 'The counselor understood my social/emotional, academic, and career-related concerns and provided useful information and assistance.'),
(90, 845, 'I felt comfortable with my counselor'),
(91, 845, 'I was able to express my thoughts and feelings effectively to my counselor.'),
(92, 845, 'The counselor actively listened to me.'),
(93, 845, 'The counselor provided professional and courteous assistance.'),
(94, 845, 'The counselor is always available.'),
(95, 845, 'Provides a venue for private confidential counseling sessions.'),
(96, 845, 'The time allotted for the session was sufficient.'),
(97, 845, 'Seeing the counselor was worth my time.'),
(98, 845, 'Overall, I was satisfied with the counseling session.'),
(99, 953, 'Teachers'),
(100, 953, 'Curriculum'),
(101, 953, 'Quality of academic advising'),
(102, 953, 'Quality of teaching modules'),
(103, 953, 'Quality of practice/OJT opportunities (e.g. facilitating access to internships))'),
(104, 953, 'Overall usefulness of De La Salle Lipa’s website'),
(105, 953, 'Quality of library resources and services'),
(106, 953, 'Quality of enrollment process and services'),
(107, 953, 'Quality of payment process'),
(108, 953, 'Viewing of grades'),
(109, 953, 'Quality of services in acquiring copy of student records (e.g. copy of grades etc.)'),
(110, 953, 'Overall value of the education with respect to tuition fee'),
(111, 953, 'Quality of online academic-related engagements with students'),
(112, 953, 'Quality of activities of student organizations'),
(113, 953, 'Quality of student government plans and programs'),
(114, 953, 'Campus safety and security services'),
(115, 953, 'Student Formation and Discipline Office services'),
(116, 953, 'Institutional Lasallian Formation Office (ILFO) services'),
(117, 953, 'Lasallian Assistance Management Program (LAMP) services'),
(118, 953, 'Quality of Institutional Health Services (Clinic)'),
(119, 953, 'College Guidance and Counseling Center services'),
(120, 955, 'General preparation for life'),
(121, 955, 'Competence in your major field of study'),
(122, 955, 'Foundation for graduate studies'),
(123, 955, 'Critical thinking skills'),
(124, 955, 'Quantitative reasoning skills'),
(125, 955, 'Written communication skills'),
(126, 955, 'Oral communication skills'),
(127, 955, 'Leadership skills'),
(128, 955, 'Capacity to understand current world issues'),
(129, 955, 'Capacity to understand human diversity (cultural diversity, sexual diversity, etc.)'),
(130, 955, 'Capacity to access relevant and trustworthy information'),
(131, 958, 'De La Salle Lipa as an academic institution'),
(132, 958, 'To enroll my college program in De La Salle Lipa.'),
(133, 958, 'To enroll in other college programs in De La Salle Lipa');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_index` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_index`, `email`, `password`, `type`, `created_at`) VALUES
(1, 'amybalion533@gmail.com', '$2y$10$JfEL/xtKAXCWWA/IFsQlv.pJ39dlOjSxShMC/nJexZbqE/gEgcplm', 'admin', '2025-04-30 07:34:49'),
(2, 'john_andrei_agustin@dlsl.edu.ph', '$2y$10$IfKXZxjTDfsOx2ac7DbliuGt/FB2z4bOgnjMpn.XEgQYYxnkRFgn2', 'student', '2025-05-21 14:08:04'),
(3, 'janna_mikhaela_alcantara@dlsl.edu.ph', '$2y$10$DSTo2wsafCp7tUbsl6ho6uamAIgRlwbHyl0Ucwd1W1Abj1w1J3KRS', 'student', '2025-05-21 14:08:04'),
(4, 'enjey_kashlee_alonzo@dlsl.edu.ph', '$2y$10$5VFKdSCYn47oG1MtnR.uN.gtP.ZcXHXDsSEGb0I6RMC.Cz7KgSCfS', 'student', '2025-05-21 14:08:04'),
(5, 'jhenelle_alonzo@dlsl.edu.ph', '$2y$10$RPaBZZHwP1s1RkYy7xU2nOHqXitcmJo1w7BweAWyq7SOlw8j246k6', 'student', '2025-05-21 14:08:04'),
(6, 'balionamaya01@gmail.com', '$2y$10$hKuEIN7731797elcOd8LRuZXa8IuXxTGl6CA4ga1LmSpGCU43Pyi.', 'student', '2025-05-21 14:08:04'),
(7, 'alfonso_rafael_barte@dlsl.edu.ph', '$2y$10$BUhHo1FlpS1xAVfAoS8hFOE3.WQx8acrFA6Hxno5DD2rG2OwaLYd6', 'student', '2025-05-21 14:08:04'),
(8, 'regina_angeli_cadelina@dlsl.edu.ph', '$2y$10$pUB5g.xMPRVaZp9iMrTUluZ7MlRV1xFjvmAUuJtkWFTj6KhMiAe3y', 'student', '2025-05-21 14:08:04'),
(9, 'djan_matthew_catibog@dlsl.edu.ph', '$2y$10$zl3QBEmvnmFPxCv/yUiFeO0I5HquLFB.yOiwNCS2ndJYSnA5d5Z3i', 'student', '2025-05-21 14:08:04'),
(10, 'renz_andrei_delrosario@dlsl.edu.ph', '$2y$10$SgYxNE.KhkO4eb0UCeCaV.NFLeiP2B.Q6TTO02B5TyGUaWAcjJABS', 'student', '2025-05-21 14:08:04'),
(11, 'marc_lawrence_delapena@dlsl.edu.ph', '$2y$10$yr0APo2tZym4EQo2B9noxuOBcEnjkV1w543mIs49M0nAcM1GKIvyy', 'student', '2025-05-21 14:08:04'),
(12, 'princess_mihaela_delavega@dlsl.edu.ph', '$2y$10$HxmyyCeurXZ3xsatFL/x4eRX3DZaYSCv3XxVxHg1v5YscmsiwFsLC', 'student', '2025-05-21 14:08:04'),
(13, 'lyrus_lei_doctolero@dlsl.edu.ph', '$2y$10$F7vOn957rN/op.OTpdlbpOjXwl.DjNPvUkMe7b97YpJeT7nPahKi6', 'student', '2025-05-21 14:08:04'),
(14, 'kyle_gabriel_dones@dlsl.edu.ph', '$2y$10$0eQy2.9hAuDt5HWpKIMjH.8uFIzSspoYZ61mr2nyh/K5G36vZ3kAO', 'student', '2025-05-21 14:08:04'),
(15, 'juan_benjo_estrella@dlsl.edu.ph', '$2y$10$Silj.7XO0aHoIEp.evS.YOg.DNcECe6tM3oIKFUh9l7Yi.MncqjNm', 'student', '2025-05-21 14:08:04'),
(16, 'lenard_lance_fedelicio@dlsl.edu.ph', '$2y$10$uRmN.mJyo.rHvKo/L592S.TKbQePLpYIjREQHidyeJCC9PWgb6ls6', 'student', '2025-05-21 14:08:04'),
(17, 'harry_garcia@dlsl.edu.ph', '$2y$10$GfunqhFqYnb7ZpWJgoGWauATxZs4asc95S24D5rGp4FtI6pp37JaC', 'student', '2025-05-21 14:08:04'),
(18, 'ivan_joseph_jaurigue@dlsl.edu.ph', '$2y$10$VeR50O93IwjapQrhlz2f6Ofg3BywBw2y0imRn/Xy2.aYANvTeyM66', 'student', '2025-05-21 14:08:04'),
(19, 'mark_jerome_kinchasan@dlsl.edu.ph', '$2y$10$zxl2Cg8aEk2Q99MD0BoSP.aHid3E3Nd.OaRgPGyrwFfE/6s8QcbN2', 'student', '2025-05-21 14:08:04'),
(20, 'jeric_lique@dls.edu.ph', '$2y$10$orUkNKTUtxb/BuQvLmKFduN5lP2s.9IbaOeMlS4HW5dPhSMfK/0S6', 'student', '2025-05-21 14:08:04'),
(21, 'sean_calvin_theo_lirio@dlsl.edu.ph', '$2y$10$OpCb5aqwk8tj43TPIwLbBuEeHC9khitjI6lxWwwcYpwqei.OaHIIK', 'student', '2025-05-21 14:08:04'),
(22, 'katherine_anne_liwanag@dlsl.edu.ph', '$2y$10$S2b/nvdF1h8mozS9FkfHguQ9RUEbztQNAu7Gin6yuco/vdX.SCvVS', 'student', '2025-05-21 14:08:04'),
(23, 'chester_boriz_macalintal@dlsl.edu.ph', '$2y$10$QXmw6RmxHRZfZ7GJzaAPpuBN7Zzvfrv6xVFgyyUbSQv9FNmSHFkTm', 'student', '2025-05-21 14:08:04'),
(24, 'john_rafhael_steven_macasaet@dlsl.edu.ph', '$2y$10$ZPthA56sBUitJDCWmWwFeuM.W5Ac1PbToZIcdGSikvX5HuIlHPNMe', 'student', '2025-05-21 14:08:04'),
(25, 'alexie_chyle_magbuhat@dlsl.edu.ph', '$2y$10$yh2KGb9z2v/ghqeBYu52LuBi8g1/rjpqmAJzojHx8cHFh4lXJxUAm', 'student', '2025-05-21 14:08:04'),
(26, 'john_aaron_manalo@dlsl.edu.ph', '$2y$10$18UBw8Wb3YLkvMAntdXAvemUp5AXKx/uKn8YvZKurkjSM7kDEho5W', 'student', '2025-05-21 14:08:04'),
(27, 'ian_karvey_manimtim@dlsl.edu.ph', '$2y$10$coFT86cOqRf0few9pGm5OOnB7J/dpyOfn70VPz5h6lIeei3USf4Cu', 'student', '2025-05-21 14:08:04'),
(28, 'isiah_joseph_marquinez@dlsl.edu.ph', '$2y$10$Xd26uhc/UoJMsWJ1GUAQCuyHcDcTAnSfbtKvE40eolTJUk5kydSOe', 'student', '2025-05-21 14:08:04'),
(29, 'sebastian_angelo_meer@dlsl.edu.ph', '$2y$10$IC7qDEauxzyDT0riJBmFzun.gCH8fGLBrlxaGTmHzDMf5sKzGeq3S', 'student', '2025-05-21 14:08:04'),
(30, 'wyeth_irish_mendez@dlsl.edu.ph', '$2y$10$ENGFpX5ri8kHWw/FUzlp5uQzh0cJ7A7aXc9VwPNohEuQJIr4bVKoK', 'student', '2025-05-21 14:08:04'),
(31, 'jan_ernest_pacey_nario@dlsl.edu.ph', '$2y$10$yLTJNInibQTsV0lY6JYgYOgR1gOcNSEv4xS.PkJAZqHfR5J.HKy5O', 'student', '2025-05-21 14:08:04'),
(32, 'keith_justin_nario@dlsl.edu.ph', '$2y$10$7oJVqHKmzj1VB2pyOSxDJefxiGKyadYUoRLfXFaWiC3IzMSwWgeHm', 'student', '2025-05-21 14:08:04'),
(33, 'michael_josh_panuela@dlsl.edu.ph', '$2y$10$a2ivsiOyQoiPUbzMQKiXjOVyLpqWTO0gmNIGHfYhY1WWsIJ78sDhG', 'student', '2025-05-21 14:08:04'),
(34, 'jane_allyson_paray@dlsl.edu.ph', '$2y$10$1sB63FEh3SOFTa/I4wuZs.PcZ3ThtVV2HOmuEkhqytlrSwEsHSNBa', 'student', '2025-05-21 14:08:04'),
(35, 'daniel_luis_sahagun@dlsl.edu.ph', '$2y$10$ph0LGK3yCejg5CAP4G65f.QYPMtduRqUkkQSSJClsiYUccc0/PySS', 'student', '2025-05-21 14:08:04'),
(36, 'thomas_alexandre_siman@dlsl.edu.ph', '$2y$10$5kREJq9AfjvXenR9ofl4h.p28YZcS0TcDgNScx5InRNWGAZ/7rlYa', 'student', '2025-05-21 14:08:04'),
(37, 'xyrelle_dominique_talens@dlsl.edu.ph', '$2y$10$L11qAVZF9fFA7pIn70AYrOj9.Xp7ZNonVt5FftsmskB4QmBCV0mOy', 'student', '2025-05-21 14:08:04'),
(38, 'jhon_paulo_tenorio@dlsl.edu.ph', '$2y$10$Z.j6Uin5x8.g7TOweygODuaWKw1CYgWUn/Wk/wfK9eVsv/U/H9fs.', 'student', '2025-05-21 14:08:04'),
(39, 'kyan_prince_torres@dlsl.edu.ph', '$2y$10$Plkf7Flr.mkg/Gv5KLVygOO4BW7e25deeuLpff00dc5PoVpwQsH0W', 'student', '2025-05-21 14:08:04'),
(40, 'angel_amaya_balion@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:02:54'),
(41, 'juan.dela.cruz@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(42, 'maria.santos@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(43, 'antonio.lim@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(44, 'sofia.reyes@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(45, 'carlos.gonzales@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(46, 'lucia.ramirez@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(47, 'fernando.tan@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(48, 'isabela.garcia@dlsl.edu.ph', '$2y$10$oruFH6IQ9LvWbRCTFDG3ouK3VTo3t3efKj9mkhBpZP11xrPFt1Tmm', 'counselor', '2025-05-27 05:25:25'),
(49, 'renz.andrei.delrosario@dlsl.edu.ph', '$2y$10$E5bQo2ZVNbL.G85IBAURmu32J9vv6JTrnr/9FjMPggHtldOid1HkW', 'admin', '2025-05-27 12:20:42'),
(50, 'xyrelle.dominique.talens@dlsl.edu.ph', '$2y$10$E5bQo2ZVNbL.G85IBAURmu32J9vv6JTrnr/9FjMPggHtldOid1HkW', 'admin', '2025-05-27 12:48:40'),
(51, 'lyrus.lei.doctolero@dlsl.edu.ph', '$2y$10$E5bQo2ZVNbL.G85IBAURmu32J9vv6JTrnr/9FjMPggHtldOid1HkW', 'admin', '2025-05-27 12:52:59'),
(52, 'lyrusdoc2@gmail.com', '$2y$10$E5bQo2ZVNbL.G85IBAURmu32J9vv6JTrnr/9FjMPggHtldOid1HkW', 'admin', '2025-05-27 12:54:21'),
(53, 'renzandreidelrosario@gmail.com', '$2y$10$E5bQo2ZVNbL.G85IBAURmu32J9vv6JTrnr/9FjMPggHtldOid1HkW', 'admin', '2025-05-27 12:54:21'),
(54, 'deleonfuego@gmail.com', '$2y$10$E5bQo2ZVNbL.G85IBAURmu32J9vv6JTrnr/9FjMPggHtldOid1HkW', 'admin', '2025-05-27 12:54:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`answer_index`),
  ADD KEY `Response_ID` (`response_index`);

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
  ADD KEY `fk_counselors_users` (`user_index`);

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
-- Indexes for table `form_sections`
--
ALTER TABLE `form_sections`
  ADD PRIMARY KEY (`form_section_index`),
  ADD KEY `form_index` (`form_index`);

--
-- Indexes for table `form_snapshots`
--
ALTER TABLE `form_snapshots`
  ADD PRIMARY KEY (`snapshot_index`);

--
-- Indexes for table `grid_answers`
--
ALTER TABLE `grid_answers`
  ADD PRIMARY KEY (`grid_answer_index`),
  ADD KEY `Response_id` (`response_index`);

--
-- Indexes for table `guardians`
--
ALTER TABLE `guardians`
  ADD PRIMARY KEY (`guardian_index`);

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
  ADD KEY `dept_index` (`dept_index`),
  ADD KEY `fk_programs_counselors` (`counselor_index`);

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
  ADD KEY `Form_ID` (`form_index`),
  ADD KEY `snapshot_id` (`snapshot_index`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`section_index`),
  ADD KEY `program_id` (`program_index`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_index`),
  ADD KEY `fk_student_program` (`section_index`),
  ADD KEY `fk_student_guardian` (`guardian_index`),
  ADD KEY `fk_students_users` (`user_index`);

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
  MODIFY `answer_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=987;

--
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `choice_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5082;

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `counselor_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `form_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `form_sections`
--
ALTER TABLE `form_sections`
  MODIFY `form_section_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300;

--
-- AUTO_INCREMENT for table `form_snapshots`
--
ALTER TABLE `form_snapshots`
  MODIFY `snapshot_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `grid_answers`
--
ALTER TABLE `grid_answers`
  MODIFY `grid_answer_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `guardians`
--
ALTER TABLE `guardians`
  MODIFY `guardian_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `main_questions`
--
ALTER TABLE `main_questions`
  MODIFY `main_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=960;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `question_types`
--
ALTER TABLE `question_types`
  MODIFY `type_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `responses`
--
ALTER TABLE `responses`
  MODIFY `response_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=481;

--
-- AUTO_INCREMENT for table `sub_questions`
--
ALTER TABLE `sub_questions`
  MODIFY `sub_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`response_index`) REFERENCES `responses` (`response_index`) ON DELETE CASCADE;

--
-- Constraints for table `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `choices_ibfk_1` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`) ON DELETE CASCADE;

--
-- Constraints for table `counselors`
--
ALTER TABLE `counselors`
  ADD CONSTRAINT `fk_counselors_users` FOREIGN KEY (`user_index`) REFERENCES `users` (`user_index`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `form_sections`
--
ALTER TABLE `form_sections`
  ADD CONSTRAINT `form_sections_ibfk_1` FOREIGN KEY (`form_index`) REFERENCES `forms` (`form_index`) ON DELETE CASCADE;

--
-- Constraints for table `grid_answers`
--
ALTER TABLE `grid_answers`
  ADD CONSTRAINT `grid_answers_ibfk_1` FOREIGN KEY (`response_index`) REFERENCES `responses` (`response_index`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `fk_programs_counselors` FOREIGN KEY (`counselor_index`) REFERENCES `counselors` (`counselor_index`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`dept_index`) REFERENCES `departments` (`dept_index`);

--
-- Constraints for table `responses`
--
ALTER TABLE `responses`
  ADD CONSTRAINT `responses_ibfk_1` FOREIGN KEY (`form_index`) REFERENCES `forms` (`form_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `responses_ibfk_2` FOREIGN KEY (`snapshot_index`) REFERENCES `form_snapshots` (`snapshot_index`);

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`program_index`) REFERENCES `programs` (`program_index`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_student_guardian` FOREIGN KEY (`guardian_index`) REFERENCES `guardians` (`guardian_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_student_section` FOREIGN KEY (`section_index`) REFERENCES `sections` (`section_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_students_users` FOREIGN KEY (`user_index`) REFERENCES `users` (`user_index`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sub_questions`
--
ALTER TABLE `sub_questions`
  ADD CONSTRAINT `sub_questions_ibfk_1` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
