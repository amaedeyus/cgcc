-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 05:10 PM
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
(2072, 368, 'Yes'),
(2073, 369, 'Adjusting to change'),
(2074, 369, 'Experiencing Bullying/Discrimination'),
(2075, 369, 'Struggling with Relationship Problems'),
(2076, 369, 'Issues with self-image'),
(2077, 369, 'Concerns about sexuality/gender identity'),
(2078, 369, 'Finding it difficult to express one\'s thoughts/feelings'),
(2079, 369, 'Struggling in getting along with others/making friends'),
(2080, 369, 'Spiritual/Religious issues'),
(2081, 369, 'Lack of decision making skills'),
(2082, 369, 'Lack of social support'),
(2083, 369, 'Lacking of self-confidence'),
(2084, 369, 'Lacks effective communication skills'),
(2085, 369, 'Need to develop leadership skills'),
(2086, 369, 'Need to have better self-concept'),
(2087, 369, 'Experiencing harassment'),
(2088, 369, 'Trust issue'),
(2089, 369, 'Feeling very strong emotions'),
(2090, 369, 'No social/emotional concern'),
(2091, 370, 'Absence of father/mother'),
(2092, 370, 'Dealing with a loss'),
(2093, 370, 'Feeling of being unloved'),
(2094, 370, 'Financial difficulties'),
(2095, 370, 'Struggling with parents’ marital conflicts/separationz'),
(2096, 370, 'Health of a family member'),
(2097, 370, 'Home environment is not conducive to study'),
(2098, 370, 'Homesickness/Living away from home'),
(2099, 370, 'Lacking parents\' appreciation'),
(2100, 370, 'Not getting along well with a family member/relative'),
(2101, 370, 'Feeling pressured by high expectations from parents/family'),
(2102, 370, 'Feeling invalidated by family members'),
(2103, 370, 'Concerned about the health of a family member'),
(2104, 370, 'Too many responsibilities at home'),
(2105, 370, 'No Family/Home Concern'),
(2106, 371, 'Struggling with addiction (substance use, internet, gaming, gambling, shopping)'),
(2107, 371, 'Difficulty in managing emotions'),
(2108, 371, 'Feeling burned out'),
(2109, 371, 'Feeling tired/fatigued most of the time (physically/emotionally)'),
(2110, 371, 'Having a physical illness that needs medical attention'),
(2111, 371, 'Racing thoughts'),
(2112, 371, 'Overthinking / Anxiety'),
(2113, 371, 'Having panic attacks'),
(2114, 371, 'Experiencing stress'),
(2115, 371, 'Difficulty coping with stress'),
(2116, 371, 'Deep feelings of sadness'),
(2117, 371, 'Self-harm behavior (cutting, scratching, burning, etc.)'),
(2118, 371, 'Erratic sleeping patterns'),
(2119, 371, 'Suicidal thoughts'),
(2120, 371, 'Suicide attempt'),
(2121, 371, 'Difficulty concentrating/being more forgetful'),
(2122, 371, 'Avoiding people, situations, or responsibilities'),
(2123, 371, 'Unable to enjoy/loss of interest in activities'),
(2124, 371, 'Feeling empty/Not feeling anything'),
(2125, 371, 'Increased irritability'),
(2126, 371, 'Crying spells'),
(2127, 371, 'Changes in appetite (eating more or less)'),
(2128, 371, 'No Mental/Physical Health Concerns'),
(2129, 372, 'Difficulty in adjusting to learning modality'),
(2130, 372, 'Difficulty in meeting academic requirements'),
(2131, 372, 'Difficulty working independently'),
(2132, 372, 'Difficulty working in a group/pair'),
(2133, 372, 'Dissatisfaction with academic performance/grades'),
(2134, 372, 'Lacking effective study habits (note-taking, time management)'),
(2135, 372, 'Difficulty overcoming distractions'),
(2136, 372, 'Lacking motivation'),
(2137, 372, 'Struggling with procrastination'),
(2138, 372, 'Struggling to balance academics with extracurricular/non-academic activities'),
(2139, 372, 'Test anxiety'),
(2140, 372, 'No Academic concern'),
(2141, 373, 'Favoritism/ unfair treatment'),
(2142, 373, 'Inadequate background knowledge about the subjects'),
(2143, 373, 'Unavailable most of the time'),
(2144, 373, 'Difficult to reach or communicate with'),
(2145, 373, 'Unethical/unprofessional behavior'),
(2146, 373, 'Does not provide timely feedback'),
(2147, 373, 'No Professor issues/concerns'),
(2148, 374, 'Uncertainty about career choice/ wanting to shift to another program'),
(2149, 374, 'Career choice is limited by financial resources'),
(2150, 374, 'Unaware of strengths, abilities, or interests'),
(2151, 374, 'Feeling lost and overwhelmed about making a career decision'),
(2152, 374, 'Feeling pressured by peers/family to succeed'),
(2153, 374, 'Need help with career planning'),
(2154, 374, 'Dissatisfied with the present college program'),
(2155, 374, 'Anxious about the future/world of work'),
(2156, 374, 'No Career concern'),
(2157, 375, 'Yes'),
(2158, 375, 'No'),
(2159, 377, 'I Certify'),
(2160, 378, 'Agree'),
(2161, 378, 'Disagree'),
(2162, 381, 'I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.'),
(2163, 381, 'I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.'),
(2164, 382, 'Yes');

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
(1, 'STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025', 'This form would only take 15- 20 minutes of your time.\n\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.', '2025-04-30 05:28:30'),
(2, 'fsdfsdfs', 'fsdfsdfsdf', '2025-04-30 12:25:24');

-- --------------------------------------------------------

--
-- Table structure for table `form_sections`
--

CREATE TABLE `form_sections` (
  `section_index` int(11) NOT NULL,
  `form_index` int(11) NOT NULL,
  `section_title` varchar(255) NOT NULL,
  `section_description` text DEFAULT NULL,
  `section_order` int(11) NOT NULL,
  `behavior` enum('same-page','next-page') DEFAULT 'same-page'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_sections`
--

INSERT INTO `form_sections` (`section_index`, `form_index`, `section_title`, `section_description`, `section_order`, `behavior`) VALUES
(2, 2, 'Title', 'This is a description', 1, 'same-page'),
(116, 1, 'Consent', 'This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).', 1, 'same-page'),
(117, 1, 'DETAILED CONCERNS', 'The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.', 2, 'same-page'),
(118, 1, 'CLIENT CONSENT FORM', 'This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\n\nAPPOINTMENT\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\n\nCOUNSELING and ASSESSMENT\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor’s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\n\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\n\nRISKS\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\n\nCOUNSELOR CONTACT INFORMATION\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.', 3, 'same-page'),
(119, 1, 'CONFIDENTIALITY and RELEASE of INFORMATION', 'Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\n\nThe exceptions to confidentiality include:\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and/or potential victims.\n\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\n\nWe are required to release your records if they are subpoenaed by a court of law.\n\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\n\nIf you provide us with a request to release your records\n\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\n\nIf you are a child/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.', 4, 'same-page'),
(120, 1, 'USE of CLIENT INFORMATION on OUTCOME RESEARCH', '', 5, 'same-page');

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
(1, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"section_index\":91,\"section_title\":\"Consent\",\"section_description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":288,\"main_question_text\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\"],\"rows\":[]},{\"main_question_index\":289,\"main_question_text\":\"sdfsdfsdfsdfsdf\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":92,\"section_title\":\"DETAILED CONCERNS\",\"section_description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":290,\"main_question_text\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Adjusting to change\",\"Experiencing Bullying\\/Discrimination\",\"Struggling with Relationship Problems\",\"Issues with self-image\",\"Concerns about sexuality\\/gender identity\",\"Finding it difficult to express one\'s thoughts\\/feelings\",\"Struggling in getting along with others\\/making friends\",\"Spiritual\\/Religious issues\",\"Lack of decision making skills\",\"Lack of social support\",\"Lacking of self-confidence\",\"Lacks effective communication skills\",\"Need to develop leadership skills\",\"Need to have better self-concept\",\"Experiencing harassment\",\"Trust issue\",\"Feeling very strong emotions\",\"No social\\/emotional concern\"],\"rows\":[]},{\"main_question_index\":291,\"main_question_text\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Absence of father\\/mother\",\"Dealing with a loss\",\"Feeling of being unloved\",\"Financial difficulties\",\"Struggling with parents\\u2019 marital conflicts\\/separationz\",\"Health of a family member\",\"Home environment is not conducive to study\",\"Homesickness\\/Living away from home\",\"Lacking parents\' appreciation\",\"Not getting along well with a family member\\/relative\",\"Feeling pressured by high expectations from parents\\/family\",\"Feeling invalidated by family members\",\"Concerned about the health of a family member\",\"Too many responsibilities at home\",\"No Family\\/Home Concern\"],\"rows\":[]},{\"main_question_index\":292,\"main_question_text\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\",\"Difficulty in managing emotions\",\"Feeling burned out\",\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\",\"Having a physical illness that needs medical attention\",\"Racing thoughts\",\"Overthinking \\/ Anxiety\",\"Having panic attacks\",\"Experiencing stress\",\"Difficulty coping with stress\",\"Deep feelings of sadness\",\"Self-harm behavior (cutting, scratching, burning, etc.)\",\"Erratic sleeping patterns\",\"Suicidal thoughts\",\"Suicide attempt\",\"Difficulty concentrating\\/being more forgetful\",\"Avoiding people, situations, or responsibilities\",\"Unable to enjoy\\/loss of interest in activities\",\"Feeling empty\\/Not feeling anything\",\"Increased irritability\",\"Crying spells\",\"Changes in appetite (eating more or less)\",\"No Mental\\/Physical Health Concerns\"],\"rows\":[]},{\"main_question_index\":293,\"main_question_text\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Difficulty in adjusting to learning modality\",\"Difficulty in meeting academic requirements\",\"Difficulty working independently\",\"Difficulty working in a group\\/pair\",\"Dissatisfaction with academic performance\\/grades\",\"Lacking effective study habits (note-taking, time management)\",\"Difficulty overcoming distractions\",\"Lacking motivation\",\"Struggling with procrastination\",\"Struggling to balance academics with extracurricular\\/non-academic activities\",\"Test anxiety\",\"No Academic concern\"],\"rows\":[]},{\"main_question_index\":294,\"main_question_text\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Favoritism\\/ unfair treatment\",\"Inadequate background knowledge about the subjects\",\"Unavailable most of the time\",\"Difficult to reach or communicate with\",\"Unethical\\/unprofessional behavior\",\"Does not provide timely feedback\",\"No Professor issues\\/concerns\"],\"rows\":[]},{\"main_question_index\":295,\"main_question_text\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Uncertainty about career choice\\/ wanting to shift to another program\",\"Career choice is limited by financial resources\",\"Unaware of strengths, abilities, or interests\",\"Feeling lost and overwhelmed about making a career decision\",\"Feeling pressured by peers\\/family to succeed\",\"Need help with career planning\",\"Dissatisfied with the present college program\",\"Anxious about the future\\/world of work\",\"No Career concern\"],\"rows\":[]},{\"main_question_index\":296,\"main_question_text\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\",\"No\"],\"rows\":[]},{\"main_question_index\":297,\"main_question_text\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":298,\"main_question_text\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"I Certify\"],\"rows\":[]}]},{\"section_index\":93,\"section_title\":\"CLIENT CONSENT FORM\",\"section_description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"behavior\":\"same-page\",\"questions\":[]},{\"section_index\":94,\"section_title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"section_description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":299,\"main_question_text\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Agree\",\"Disagree\"],\"rows\":[]},{\"main_question_index\":300,\"main_question_text\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":301,\"main_question_text\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":95,\"section_title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"section_description\":\"\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":302,\"main_question_text\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\",\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"],\"rows\":[]},{\"main_question_index\":303,\"main_question_text\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":true,\"options\":[\"Yes\"],\"rows\":[]}]}],\"timestamp\":\"2025-05-20T15:25:43+02:00\"}', 1, '2025-05-20 13:25:43', 0),
(2, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"section_index\":96,\"section_title\":\"Consent\",\"section_description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":304,\"main_question_text\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\"],\"rows\":[]}]},{\"section_index\":97,\"section_title\":\"DETAILED CONCERNS\",\"section_description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":305,\"main_question_text\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Adjusting to change\",\"Experiencing Bullying\\/Discrimination\",\"Struggling with Relationship Problems\",\"Issues with self-image\",\"Concerns about sexuality\\/gender identity\",\"Finding it difficult to express one\'s thoughts\\/feelings\",\"Struggling in getting along with others\\/making friends\",\"Spiritual\\/Religious issues\",\"Lack of decision making skills\",\"Lack of social support\",\"Lacking of self-confidence\",\"Lacks effective communication skills\",\"Need to develop leadership skills\",\"Need to have better self-concept\",\"Experiencing harassment\",\"Trust issue\",\"Feeling very strong emotions\",\"No social\\/emotional concern\"],\"rows\":[]},{\"main_question_index\":306,\"main_question_text\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Absence of father\\/mother\",\"Dealing with a loss\",\"Feeling of being unloved\",\"Financial difficulties\",\"Struggling with parents\\u2019 marital conflicts\\/separationz\",\"Health of a family member\",\"Home environment is not conducive to study\",\"Homesickness\\/Living away from home\",\"Lacking parents\' appreciation\",\"Not getting along well with a family member\\/relative\",\"Feeling pressured by high expectations from parents\\/family\",\"Feeling invalidated by family members\",\"Concerned about the health of a family member\",\"Too many responsibilities at home\",\"No Family\\/Home Concern\"],\"rows\":[]},{\"main_question_index\":307,\"main_question_text\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\",\"Difficulty in managing emotions\",\"Feeling burned out\",\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\",\"Having a physical illness that needs medical attention\",\"Racing thoughts\",\"Overthinking \\/ Anxiety\",\"Having panic attacks\",\"Experiencing stress\",\"Difficulty coping with stress\",\"Deep feelings of sadness\",\"Self-harm behavior (cutting, scratching, burning, etc.)\",\"Erratic sleeping patterns\",\"Suicidal thoughts\",\"Suicide attempt\",\"Difficulty concentrating\\/being more forgetful\",\"Avoiding people, situations, or responsibilities\",\"Unable to enjoy\\/loss of interest in activities\",\"Feeling empty\\/Not feeling anything\",\"Increased irritability\",\"Crying spells\",\"Changes in appetite (eating more or less)\",\"No Mental\\/Physical Health Concerns\"],\"rows\":[]},{\"main_question_index\":308,\"main_question_text\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Difficulty in adjusting to learning modality\",\"Difficulty in meeting academic requirements\",\"Difficulty working independently\",\"Difficulty working in a group\\/pair\",\"Dissatisfaction with academic performance\\/grades\",\"Lacking effective study habits (note-taking, time management)\",\"Difficulty overcoming distractions\",\"Lacking motivation\",\"Struggling with procrastination\",\"Struggling to balance academics with extracurricular\\/non-academic activities\",\"Test anxiety\",\"No Academic concern\"],\"rows\":[]},{\"main_question_index\":309,\"main_question_text\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Favoritism\\/ unfair treatment\",\"Inadequate background knowledge about the subjects\",\"Unavailable most of the time\",\"Difficult to reach or communicate with\",\"Unethical\\/unprofessional behavior\",\"Does not provide timely feedback\",\"No Professor issues\\/concerns\"],\"rows\":[]},{\"main_question_index\":310,\"main_question_text\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Uncertainty about career choice\\/ wanting to shift to another program\",\"Career choice is limited by financial resources\",\"Unaware of strengths, abilities, or interests\",\"Feeling lost and overwhelmed about making a career decision\",\"Feeling pressured by peers\\/family to succeed\",\"Need help with career planning\",\"Dissatisfied with the present college program\",\"Anxious about the future\\/world of work\",\"No Career concern\"],\"rows\":[]},{\"main_question_index\":311,\"main_question_text\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\",\"No\"],\"rows\":[]},{\"main_question_index\":312,\"main_question_text\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":313,\"main_question_text\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"I Certify\"],\"rows\":[]}]},{\"section_index\":98,\"section_title\":\"CLIENT CONSENT FORM\",\"section_description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"behavior\":\"same-page\",\"questions\":[]},{\"section_index\":99,\"section_title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"section_description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":314,\"main_question_text\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Agree\",\"Disagree\"],\"rows\":[]},{\"main_question_index\":315,\"main_question_text\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":316,\"main_question_text\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":100,\"section_title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"section_description\":\"\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":317,\"main_question_text\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\",\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"],\"rows\":[]},{\"main_question_index\":318,\"main_question_text\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":true,\"options\":[\"Yes\"],\"rows\":[]}]}],\"timestamp\":\"2025-05-20T15:43:23+02:00\"}', 1, '2025-05-20 13:43:23', 0),
(3, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"section_index\":101,\"section_title\":\"Consent\",\"section_description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":319,\"main_question_text\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\"],\"rows\":[]},{\"main_question_index\":320,\"main_question_text\":\"adadasdasddas\",\"type\":\"paragraph\",\"is_required\":false,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":102,\"section_title\":\"DETAILED CONCERNS\",\"section_description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":321,\"main_question_text\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Adjusting to change\",\"Experiencing Bullying\\/Discrimination\",\"Struggling with Relationship Problems\",\"Issues with self-image\",\"Concerns about sexuality\\/gender identity\",\"Finding it difficult to express one\'s thoughts\\/feelings\",\"Struggling in getting along with others\\/making friends\",\"Spiritual\\/Religious issues\",\"Lack of decision making skills\",\"Lack of social support\",\"Lacking of self-confidence\",\"Lacks effective communication skills\",\"Need to develop leadership skills\",\"Need to have better self-concept\",\"Experiencing harassment\",\"Trust issue\",\"Feeling very strong emotions\",\"No social\\/emotional concern\"],\"rows\":[]},{\"main_question_index\":322,\"main_question_text\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Absence of father\\/mother\",\"Dealing with a loss\",\"Feeling of being unloved\",\"Financial difficulties\",\"Struggling with parents\\u2019 marital conflicts\\/separationz\",\"Health of a family member\",\"Home environment is not conducive to study\",\"Homesickness\\/Living away from home\",\"Lacking parents\' appreciation\",\"Not getting along well with a family member\\/relative\",\"Feeling pressured by high expectations from parents\\/family\",\"Feeling invalidated by family members\",\"Concerned about the health of a family member\",\"Too many responsibilities at home\",\"No Family\\/Home Concern\"],\"rows\":[]},{\"main_question_index\":323,\"main_question_text\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\",\"Difficulty in managing emotions\",\"Feeling burned out\",\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\",\"Having a physical illness that needs medical attention\",\"Racing thoughts\",\"Overthinking \\/ Anxiety\",\"Having panic attacks\",\"Experiencing stress\",\"Difficulty coping with stress\",\"Deep feelings of sadness\",\"Self-harm behavior (cutting, scratching, burning, etc.)\",\"Erratic sleeping patterns\",\"Suicidal thoughts\",\"Suicide attempt\",\"Difficulty concentrating\\/being more forgetful\",\"Avoiding people, situations, or responsibilities\",\"Unable to enjoy\\/loss of interest in activities\",\"Feeling empty\\/Not feeling anything\",\"Increased irritability\",\"Crying spells\",\"Changes in appetite (eating more or less)\",\"No Mental\\/Physical Health Concerns\"],\"rows\":[]},{\"main_question_index\":324,\"main_question_text\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Difficulty in adjusting to learning modality\",\"Difficulty in meeting academic requirements\",\"Difficulty working independently\",\"Difficulty working in a group\\/pair\",\"Dissatisfaction with academic performance\\/grades\",\"Lacking effective study habits (note-taking, time management)\",\"Difficulty overcoming distractions\",\"Lacking motivation\",\"Struggling with procrastination\",\"Struggling to balance academics with extracurricular\\/non-academic activities\",\"Test anxiety\",\"No Academic concern\"],\"rows\":[]},{\"main_question_index\":325,\"main_question_text\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Favoritism\\/ unfair treatment\",\"Inadequate background knowledge about the subjects\",\"Unavailable most of the time\",\"Difficult to reach or communicate with\",\"Unethical\\/unprofessional behavior\",\"Does not provide timely feedback\",\"No Professor issues\\/concerns\"],\"rows\":[]},{\"main_question_index\":326,\"main_question_text\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Uncertainty about career choice\\/ wanting to shift to another program\",\"Career choice is limited by financial resources\",\"Unaware of strengths, abilities, or interests\",\"Feeling lost and overwhelmed about making a career decision\",\"Feeling pressured by peers\\/family to succeed\",\"Need help with career planning\",\"Dissatisfied with the present college program\",\"Anxious about the future\\/world of work\",\"No Career concern\"],\"rows\":[]},{\"main_question_index\":327,\"main_question_text\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\",\"No\"],\"rows\":[]},{\"main_question_index\":328,\"main_question_text\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":329,\"main_question_text\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"I Certify\"],\"rows\":[]}]},{\"section_index\":103,\"section_title\":\"CLIENT CONSENT FORM\",\"section_description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"behavior\":\"same-page\",\"questions\":[]},{\"section_index\":104,\"section_title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"section_description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":330,\"main_question_text\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Agree\",\"Disagree\"],\"rows\":[]},{\"main_question_index\":331,\"main_question_text\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":332,\"main_question_text\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":105,\"section_title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"section_description\":\"\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":333,\"main_question_text\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\",\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"],\"rows\":[]},{\"main_question_index\":334,\"main_question_text\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":true,\"options\":[\"Yes\"],\"rows\":[]}]}],\"timestamp\":\"2025-05-20T15:45:00+02:00\"}', 1, '2025-05-20 13:45:00', 0);
INSERT INTO `form_snapshots` (`snapshot_index`, `snapshot_data`, `form_index`, `created_at`, `is_active`) VALUES
(4, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"section_index\":106,\"section_title\":\"Consent\",\"section_description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":335,\"main_question_text\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\"],\"rows\":[]},{\"main_question_index\":336,\"main_question_text\":\"adadasdasddasdasdasdasddasd\",\"type\":\"paragraph\",\"is_required\":false,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":107,\"section_title\":\"DETAILED CONCERNS\",\"section_description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":337,\"main_question_text\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Adjusting to change\",\"Experiencing Bullying\\/Discrimination\",\"Struggling with Relationship Problems\",\"Issues with self-image\",\"Concerns about sexuality\\/gender identity\",\"Finding it difficult to express one\'s thoughts\\/feelings\",\"Struggling in getting along with others\\/making friends\",\"Spiritual\\/Religious issues\",\"Lack of decision making skills\",\"Lack of social support\",\"Lacking of self-confidence\",\"Lacks effective communication skills\",\"Need to develop leadership skills\",\"Need to have better self-concept\",\"Experiencing harassment\",\"Trust issue\",\"Feeling very strong emotions\",\"No social\\/emotional concern\"],\"rows\":[]},{\"main_question_index\":338,\"main_question_text\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Absence of father\\/mother\",\"Dealing with a loss\",\"Feeling of being unloved\",\"Financial difficulties\",\"Struggling with parents\\u2019 marital conflicts\\/separationz\",\"Health of a family member\",\"Home environment is not conducive to study\",\"Homesickness\\/Living away from home\",\"Lacking parents\' appreciation\",\"Not getting along well with a family member\\/relative\",\"Feeling pressured by high expectations from parents\\/family\",\"Feeling invalidated by family members\",\"Concerned about the health of a family member\",\"Too many responsibilities at home\",\"No Family\\/Home Concern\"],\"rows\":[]},{\"main_question_index\":339,\"main_question_text\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\",\"Difficulty in managing emotions\",\"Feeling burned out\",\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\",\"Having a physical illness that needs medical attention\",\"Racing thoughts\",\"Overthinking \\/ Anxiety\",\"Having panic attacks\",\"Experiencing stress\",\"Difficulty coping with stress\",\"Deep feelings of sadness\",\"Self-harm behavior (cutting, scratching, burning, etc.)\",\"Erratic sleeping patterns\",\"Suicidal thoughts\",\"Suicide attempt\",\"Difficulty concentrating\\/being more forgetful\",\"Avoiding people, situations, or responsibilities\",\"Unable to enjoy\\/loss of interest in activities\",\"Feeling empty\\/Not feeling anything\",\"Increased irritability\",\"Crying spells\",\"Changes in appetite (eating more or less)\",\"No Mental\\/Physical Health Concerns\"],\"rows\":[]},{\"main_question_index\":340,\"main_question_text\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Difficulty in adjusting to learning modality\",\"Difficulty in meeting academic requirements\",\"Difficulty working independently\",\"Difficulty working in a group\\/pair\",\"Dissatisfaction with academic performance\\/grades\",\"Lacking effective study habits (note-taking, time management)\",\"Difficulty overcoming distractions\",\"Lacking motivation\",\"Struggling with procrastination\",\"Struggling to balance academics with extracurricular\\/non-academic activities\",\"Test anxiety\",\"No Academic concern\"],\"rows\":[]},{\"main_question_index\":341,\"main_question_text\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Favoritism\\/ unfair treatment\",\"Inadequate background knowledge about the subjects\",\"Unavailable most of the time\",\"Difficult to reach or communicate with\",\"Unethical\\/unprofessional behavior\",\"Does not provide timely feedback\",\"No Professor issues\\/concerns\"],\"rows\":[]},{\"main_question_index\":342,\"main_question_text\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Uncertainty about career choice\\/ wanting to shift to another program\",\"Career choice is limited by financial resources\",\"Unaware of strengths, abilities, or interests\",\"Feeling lost and overwhelmed about making a career decision\",\"Feeling pressured by peers\\/family to succeed\",\"Need help with career planning\",\"Dissatisfied with the present college program\",\"Anxious about the future\\/world of work\",\"No Career concern\"],\"rows\":[]},{\"main_question_index\":343,\"main_question_text\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\",\"No\"],\"rows\":[]},{\"main_question_index\":344,\"main_question_text\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":345,\"main_question_text\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"I Certify\"],\"rows\":[]}]},{\"section_index\":108,\"section_title\":\"CLIENT CONSENT FORM\",\"section_description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"behavior\":\"same-page\",\"questions\":[]},{\"section_index\":109,\"section_title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"section_description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":346,\"main_question_text\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Agree\",\"Disagree\"],\"rows\":[]},{\"main_question_index\":347,\"main_question_text\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":348,\"main_question_text\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":110,\"section_title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"section_description\":\"\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":349,\"main_question_text\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\",\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"],\"rows\":[]},{\"main_question_index\":350,\"main_question_text\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":true,\"options\":[\"Yes\"],\"rows\":[]}]}],\"timestamp\":\"2025-05-20T15:45:11+02:00\"}', 1, '2025-05-20 13:45:11', 0),
(5, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"section_index\":111,\"section_title\":\"Consent\",\"section_description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":351,\"main_question_text\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\"],\"rows\":[]},{\"main_question_index\":352,\"main_question_text\":\"adadasdasddasdasdasdasddasd\",\"type\":\"paragraph\",\"is_required\":false,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":353,\"main_question_text\":\"dasdasdsdad\",\"type\":\"short\",\"is_required\":false,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":112,\"section_title\":\"DETAILED CONCERNS\",\"section_description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":354,\"main_question_text\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Adjusting to change\",\"Experiencing Bullying\\/Discrimination\",\"Struggling with Relationship Problems\",\"Issues with self-image\",\"Concerns about sexuality\\/gender identity\",\"Finding it difficult to express one\'s thoughts\\/feelings\",\"Struggling in getting along with others\\/making friends\",\"Spiritual\\/Religious issues\",\"Lack of decision making skills\",\"Lack of social support\",\"Lacking of self-confidence\",\"Lacks effective communication skills\",\"Need to develop leadership skills\",\"Need to have better self-concept\",\"Experiencing harassment\",\"Trust issue\",\"Feeling very strong emotions\",\"No social\\/emotional concern\"],\"rows\":[]},{\"main_question_index\":355,\"main_question_text\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Absence of father\\/mother\",\"Dealing with a loss\",\"Feeling of being unloved\",\"Financial difficulties\",\"Struggling with parents\\u2019 marital conflicts\\/separationz\",\"Health of a family member\",\"Home environment is not conducive to study\",\"Homesickness\\/Living away from home\",\"Lacking parents\' appreciation\",\"Not getting along well with a family member\\/relative\",\"Feeling pressured by high expectations from parents\\/family\",\"Feeling invalidated by family members\",\"Concerned about the health of a family member\",\"Too many responsibilities at home\",\"No Family\\/Home Concern\"],\"rows\":[]},{\"main_question_index\":356,\"main_question_text\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\",\"Difficulty in managing emotions\",\"Feeling burned out\",\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\",\"Having a physical illness that needs medical attention\",\"Racing thoughts\",\"Overthinking \\/ Anxiety\",\"Having panic attacks\",\"Experiencing stress\",\"Difficulty coping with stress\",\"Deep feelings of sadness\",\"Self-harm behavior (cutting, scratching, burning, etc.)\",\"Erratic sleeping patterns\",\"Suicidal thoughts\",\"Suicide attempt\",\"Difficulty concentrating\\/being more forgetful\",\"Avoiding people, situations, or responsibilities\",\"Unable to enjoy\\/loss of interest in activities\",\"Feeling empty\\/Not feeling anything\",\"Increased irritability\",\"Crying spells\",\"Changes in appetite (eating more or less)\",\"No Mental\\/Physical Health Concerns\"],\"rows\":[]},{\"main_question_index\":357,\"main_question_text\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Difficulty in adjusting to learning modality\",\"Difficulty in meeting academic requirements\",\"Difficulty working independently\",\"Difficulty working in a group\\/pair\",\"Dissatisfaction with academic performance\\/grades\",\"Lacking effective study habits (note-taking, time management)\",\"Difficulty overcoming distractions\",\"Lacking motivation\",\"Struggling with procrastination\",\"Struggling to balance academics with extracurricular\\/non-academic activities\",\"Test anxiety\",\"No Academic concern\"],\"rows\":[]},{\"main_question_index\":358,\"main_question_text\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Favoritism\\/ unfair treatment\",\"Inadequate background knowledge about the subjects\",\"Unavailable most of the time\",\"Difficult to reach or communicate with\",\"Unethical\\/unprofessional behavior\",\"Does not provide timely feedback\",\"No Professor issues\\/concerns\"],\"rows\":[]},{\"main_question_index\":359,\"main_question_text\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"Uncertainty about career choice\\/ wanting to shift to another program\",\"Career choice is limited by financial resources\",\"Unaware of strengths, abilities, or interests\",\"Feeling lost and overwhelmed about making a career decision\",\"Feeling pressured by peers\\/family to succeed\",\"Need help with career planning\",\"Dissatisfied with the present college program\",\"Anxious about the future\\/world of work\",\"No Career concern\"],\"rows\":[]},{\"main_question_index\":360,\"main_question_text\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Yes\",\"No\"],\"rows\":[]},{\"main_question_index\":361,\"main_question_text\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":362,\"main_question_text\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":false,\"options\":[\"I Certify\"],\"rows\":[]}]},{\"section_index\":113,\"section_title\":\"CLIENT CONSENT FORM\",\"section_description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"behavior\":\"same-page\",\"questions\":[]},{\"section_index\":114,\"section_title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"section_description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":363,\"main_question_text\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"Agree\",\"Disagree\"],\"rows\":[]},{\"main_question_index\":364,\"main_question_text\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]},{\"main_question_index\":365,\"main_question_text\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"is_required\":true,\"include_other\":false,\"options\":[],\"rows\":[]}]},{\"section_index\":115,\"section_title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"section_description\":\"\",\"behavior\":\"same-page\",\"questions\":[{\"main_question_index\":366,\"main_question_text\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"is_required\":true,\"include_other\":false,\"options\":[\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\",\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"],\"rows\":[]},{\"main_question_index\":367,\"main_question_text\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"is_required\":true,\"include_other\":true,\"options\":[\"Yes\"],\"rows\":[]}]}],\"timestamp\":\"2025-05-20T16:02:51+02:00\"}', 1, '2025-05-20 14:02:51', 1);

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
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `include_other` tinyint(1) DEFAULT 0,
  `section_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `main_questions`
--

INSERT INTO `main_questions` (`main_question_index`, `form_index`, `main_question_text`, `type_index`, `is_required`, `include_other`, `section_index`) VALUES
(2, 2, 'fsdfsfd', 6, 0, 0, 2),
(368, 1, 'I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.', 4, 1, 0, 116),
(369, 1, 'SOCIAL/EMOTIONAL CONCERNS', 4, 1, 0, 117),
(370, 1, 'FAMILY & HOME CONCERNS', 4, 1, 0, 117),
(371, 1, 'MENTAL/PHYSICAL HEALTH CONCERNS', 4, 1, 0, 117),
(372, 1, 'ACADEMIC CONCERNS', 4, 1, 0, 117),
(373, 1, 'PROFESSOR ISSUE CONCERNS', 4, 1, 0, 117),
(374, 1, 'CAREER CONCERNS', 4, 1, 0, 117),
(375, 1, 'I have other concerns/questions that I want to directly consult or discuss with my counselor.', 3, 1, 0, 117),
(376, 1, 'We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments/suggestions, please indicate them below:', 1, 1, 0, 117),
(377, 1, 'By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.', 4, 1, 0, 117),
(378, 1, 'I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.', 3, 1, 0, 119),
(379, 1, 'Name of Father/Mother or Legal Guardian', 1, 1, 0, 119),
(380, 1, 'Contact number of parent/guardian', 1, 1, 0, 119),
(381, 1, 'When client information is utilized on outcome research purposes, client names are not disclosed.', 3, 1, 0, 120),
(382, 1, 'Counseling Guidelines Please review the Counseling Guidelines through this link: https://bit.ly/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.', 4, 1, 1, 120);

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
  `created_at` datetime DEFAULT NULL,
  `snapshot_index` int(11) DEFAULT NULL
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
(1, 2, 'fsdfdsf');

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
-- Indexes for table `form_sections`
--
ALTER TABLE `form_sections`
  ADD PRIMARY KEY (`section_index`),
  ADD KEY `form_index` (`form_index`);

--
-- Indexes for table `form_snapshots`
--
ALTER TABLE `form_snapshots`
  ADD PRIMARY KEY (`snapshot_index`),
  ADD KEY `form_index` (`form_index`);

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
  ADD KEY `QType_ID` (`type_index`),
  ADD KEY `section_index` (`section_index`);

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
  ADD KEY `Form_ID` (`form_index`),
  ADD KEY `snapshot_id` (`snapshot_index`);

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
  MODIFY `choice_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2165;

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
  MODIFY `form_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `form_sections`
--
ALTER TABLE `form_sections`
  MODIFY `section_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `form_snapshots`
--
ALTER TABLE `form_snapshots`
  MODIFY `snapshot_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `grid_answers`
--
ALTER TABLE `grid_answers`
  MODIFY `grid_answer_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_questions`
--
ALTER TABLE `main_questions`
  MODIFY `main_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=383;

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
  MODIFY `sub_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- Constraints for table `form_sections`
--
ALTER TABLE `form_sections`
  ADD CONSTRAINT `form_sections_ibfk_1` FOREIGN KEY (`form_index`) REFERENCES `forms` (`form_index`) ON DELETE CASCADE;

--
-- Constraints for table `form_snapshots`
--
ALTER TABLE `form_snapshots`
  ADD CONSTRAINT `form_snapshots_ibfk_1` FOREIGN KEY (`form_index`) REFERENCES `forms` (`form_index`);

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
  ADD CONSTRAINT `main_questions_ibfk_2` FOREIGN KEY (`type_index`) REFERENCES `question_types` (`type_index`),
  ADD CONSTRAINT `main_questions_ibfk_3` FOREIGN KEY (`section_index`) REFERENCES `form_sections` (`section_index`) ON DELETE SET NULL;

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
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
