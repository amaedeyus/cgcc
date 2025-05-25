-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2025 at 04:15 AM
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
(2351, 415, 'Yes'),
(2352, 416, 'Adjusting to change'),
(2353, 416, 'Experiencing Bullying/Discrimination'),
(2354, 416, 'Struggling with Relationship Problems'),
(2355, 416, 'Issues with self-image'),
(2356, 416, 'Concerns about sexuality/gender identity'),
(2357, 416, 'Finding it difficult to express one\'s thoughts/feelings'),
(2358, 416, 'Struggling in getting along with others/making friends'),
(2359, 416, 'Spiritual/Religious issues'),
(2360, 416, 'Lack of decision making skills'),
(2361, 416, 'Lack of social support'),
(2362, 416, 'Lacking of self-confidence'),
(2363, 416, 'Lacks effective communication skills'),
(2364, 416, 'Need to develop leadership skills'),
(2365, 416, 'Need to have better self-concept'),
(2366, 416, 'Experiencing harassment'),
(2367, 416, 'Trust issue'),
(2368, 416, 'Feeling very strong emotions'),
(2369, 416, 'No social/emotional concern'),
(2370, 417, 'Absence of father/mother'),
(2371, 417, 'Dealing with a loss'),
(2372, 417, 'Feeling of being unloved'),
(2373, 417, 'Financial difficulties'),
(2374, 417, 'Struggling with parents’ marital conflicts/separationz'),
(2375, 417, 'Health of a family member'),
(2376, 417, 'Home environment is not conducive to study'),
(2377, 417, 'Homesickness/Living away from home'),
(2378, 417, 'Lacking parents\' appreciation'),
(2379, 417, 'Not getting along well with a family member/relative'),
(2380, 417, 'Feeling pressured by high expectations from parents/family'),
(2381, 417, 'Feeling invalidated by family members'),
(2382, 417, 'Concerned about the health of a family member'),
(2383, 417, 'Too many responsibilities at home'),
(2384, 417, 'No Family/Home Concern'),
(2385, 418, 'Struggling with addiction (substance use, internet, gaming, gambling, shopping)'),
(2386, 418, 'Difficulty in managing emotions'),
(2387, 418, 'Feeling burned out'),
(2388, 418, 'Feeling tired/fatigued most of the time (physically/emotionally)'),
(2389, 418, 'Having a physical illness that needs medical attention'),
(2390, 418, 'Racing thoughts'),
(2391, 418, 'Overthinking / Anxiety'),
(2392, 418, 'Having panic attacks'),
(2393, 418, 'Experiencing stress'),
(2394, 418, 'Difficulty coping with stress'),
(2395, 418, 'Deep feelings of sadness'),
(2396, 418, 'Self-harm behavior (cutting, scratching, burning, etc.)'),
(2397, 418, 'Erratic sleeping patterns'),
(2398, 418, 'Suicidal thoughts'),
(2399, 418, 'Suicide attempt'),
(2400, 418, 'Difficulty concentrating/being more forgetful'),
(2401, 418, 'Avoiding people, situations, or responsibilities'),
(2402, 418, 'Unable to enjoy/loss of interest in activities'),
(2403, 418, 'Feeling empty/Not feeling anything'),
(2404, 418, 'Increased irritability'),
(2405, 418, 'Crying spells'),
(2406, 418, 'Changes in appetite (eating more or less)'),
(2407, 418, 'No Mental/Physical Health Concerns'),
(2408, 419, 'Difficulty in adjusting to learning modality'),
(2409, 419, 'Difficulty in meeting academic requirements'),
(2410, 419, 'Difficulty working independently'),
(2411, 419, 'Difficulty working in a group/pair'),
(2412, 419, 'Dissatisfaction with academic performance/grades'),
(2413, 419, 'Lacking effective study habits (note-taking, time management)'),
(2414, 419, 'Difficulty overcoming distractions'),
(2415, 419, 'Lacking motivation'),
(2416, 419, 'Struggling with procrastination'),
(2417, 419, 'Struggling to balance academics with extracurricular/non-academic activities'),
(2418, 419, 'Test anxiety'),
(2419, 419, 'No Academic concern'),
(2420, 420, 'Favoritism/ unfair treatment'),
(2421, 420, 'Inadequate background knowledge about the subjects'),
(2422, 420, 'Unavailable most of the time'),
(2423, 420, 'Difficult to reach or communicate with'),
(2424, 420, 'Unethical/unprofessional behavior'),
(2425, 420, 'Does not provide timely feedback'),
(2426, 420, 'No Professor issues/concerns'),
(2427, 421, 'Uncertainty about career choice/ wanting to shift to another program'),
(2428, 421, 'Career choice is limited by financial resources'),
(2429, 421, 'Unaware of strengths, abilities, or interests'),
(2430, 421, 'Feeling lost and overwhelmed about making a career decision'),
(2431, 421, 'Feeling pressured by peers/family to succeed'),
(2432, 421, 'Need help with career planning'),
(2433, 421, 'Dissatisfied with the present college program'),
(2434, 421, 'Anxious about the future/world of work'),
(2435, 421, 'No Career concern'),
(2436, 422, 'Yes'),
(2437, 422, 'No'),
(2438, 424, 'I Certify'),
(2439, 425, 'Agree'),
(2440, 425, 'Disagree'),
(2441, 428, 'I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.'),
(2442, 428, 'I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.'),
(2443, 429, 'Yes');

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
  `calendar_link` varchar(200) NOT NULL,
  `status` enum('active','inactive','deleted','') NOT NULL
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
(131, 1, 'Consent', 'This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).', 1, 'same-page'),
(132, 1, 'DETAILED CONCERNS', 'The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.', 2, 'same-page'),
(133, 1, 'CLIENT CONSENT FORM', 'This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\n\nAPPOINTMENT\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\n\nCOUNSELING and ASSESSMENT\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor’s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\n\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\n\nRISKS\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\n\nCOUNSELOR CONTACT INFORMATION\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.', 3, 'same-page'),
(134, 1, 'CONFIDENTIALITY and RELEASE of INFORMATION', 'Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\n\nThe exceptions to confidentiality include:\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and/or potential victims.\n\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\n\nWe are required to release your records if they are subpoenaed by a court of law.\n\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\n\nIf you provide us with a request to release your records\n\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\n\nIf you are a child/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.', 4, 'same-page'),
(135, 1, 'USE of CLIENT INFORMATION on OUTCOME RESEARCH', '', 5, 'same-page');

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
(11, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"id\":121,\"title\":\"Consent\",\"description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"order\":1,\"behavior\":\"same-page\",\"questions\":[{\"id\":383,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2165,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":121},{\"id\":384,\"question\":\"dasdsad\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":121}]},{\"id\":122,\"title\":\"DETAILED CONCERNS\",\"description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"order\":2,\"behavior\":\"same-page\",\"questions\":[{\"id\":385,\"question\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2166,\"choice_text\":\"Adjusting to change\"},{\"choice_index\":2167,\"choice_text\":\"Experiencing Bullying\\/Discrimination\"},{\"choice_index\":2168,\"choice_text\":\"Struggling with Relationship Problems\"},{\"choice_index\":2169,\"choice_text\":\"Issues with self-image\"},{\"choice_index\":2170,\"choice_text\":\"Concerns about sexuality\\/gender identity\"},{\"choice_index\":2171,\"choice_text\":\"Finding it difficult to express one\'s thoughts\\/feelings\"},{\"choice_index\":2172,\"choice_text\":\"Struggling in getting along with others\\/making friends\"},{\"choice_index\":2173,\"choice_text\":\"Spiritual\\/Religious issues\"},{\"choice_index\":2174,\"choice_text\":\"Lack of decision making skills\"},{\"choice_index\":2175,\"choice_text\":\"Lack of social support\"},{\"choice_index\":2176,\"choice_text\":\"Lacking of self-confidence\"},{\"choice_index\":2177,\"choice_text\":\"Lacks effective communication skills\"},{\"choice_index\":2178,\"choice_text\":\"Need to develop leadership skills\"},{\"choice_index\":2179,\"choice_text\":\"Need to have better self-concept\"},{\"choice_index\":2180,\"choice_text\":\"Experiencing harassment\"},{\"choice_index\":2181,\"choice_text\":\"Trust issue\"},{\"choice_index\":2182,\"choice_text\":\"Feeling very strong emotions\"},{\"choice_index\":2183,\"choice_text\":\"No social\\/emotional concern\"}],\"rows\":[],\"section_index\":122},{\"id\":386,\"question\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2184,\"choice_text\":\"Absence of father\\/mother\"},{\"choice_index\":2185,\"choice_text\":\"Dealing with a loss\"},{\"choice_index\":2186,\"choice_text\":\"Feeling of being unloved\"},{\"choice_index\":2187,\"choice_text\":\"Financial difficulties\"},{\"choice_index\":2188,\"choice_text\":\"Struggling with parents\\u2019 marital conflicts\\/separationz\"},{\"choice_index\":2189,\"choice_text\":\"Health of a family member\"},{\"choice_index\":2190,\"choice_text\":\"Home environment is not conducive to study\"},{\"choice_index\":2191,\"choice_text\":\"Homesickness\\/Living away from home\"},{\"choice_index\":2192,\"choice_text\":\"Lacking parents\' appreciation\"},{\"choice_index\":2193,\"choice_text\":\"Not getting along well with a family member\\/relative\"},{\"choice_index\":2194,\"choice_text\":\"Feeling pressured by high expectations from parents\\/family\"},{\"choice_index\":2195,\"choice_text\":\"Feeling invalidated by family members\"},{\"choice_index\":2196,\"choice_text\":\"Concerned about the health of a family member\"},{\"choice_index\":2197,\"choice_text\":\"Too many responsibilities at home\"},{\"choice_index\":2198,\"choice_text\":\"No Family\\/Home Concern\"}],\"rows\":[],\"section_index\":122},{\"id\":387,\"question\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2199,\"choice_text\":\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\"},{\"choice_index\":2200,\"choice_text\":\"Difficulty in managing emotions\"},{\"choice_index\":2201,\"choice_text\":\"Feeling burned out\"},{\"choice_index\":2202,\"choice_text\":\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\"},{\"choice_index\":2203,\"choice_text\":\"Having a physical illness that needs medical attention\"},{\"choice_index\":2204,\"choice_text\":\"Racing thoughts\"},{\"choice_index\":2205,\"choice_text\":\"Overthinking \\/ Anxiety\"},{\"choice_index\":2206,\"choice_text\":\"Having panic attacks\"},{\"choice_index\":2207,\"choice_text\":\"Experiencing stress\"},{\"choice_index\":2208,\"choice_text\":\"Difficulty coping with stress\"},{\"choice_index\":2209,\"choice_text\":\"Deep feelings of sadness\"},{\"choice_index\":2210,\"choice_text\":\"Self-harm behavior (cutting, scratching, burning, etc.)\"},{\"choice_index\":2211,\"choice_text\":\"Erratic sleeping patterns\"},{\"choice_index\":2212,\"choice_text\":\"Suicidal thoughts\"},{\"choice_index\":2213,\"choice_text\":\"Suicide attempt\"},{\"choice_index\":2214,\"choice_text\":\"Difficulty concentrating\\/being more forgetful\"},{\"choice_index\":2215,\"choice_text\":\"Avoiding people, situations, or responsibilities\"},{\"choice_index\":2216,\"choice_text\":\"Unable to enjoy\\/loss of interest in activities\"},{\"choice_index\":2217,\"choice_text\":\"Feeling empty\\/Not feeling anything\"},{\"choice_index\":2218,\"choice_text\":\"Increased irritability\"},{\"choice_index\":2219,\"choice_text\":\"Crying spells\"},{\"choice_index\":2220,\"choice_text\":\"Changes in appetite (eating more or less)\"},{\"choice_index\":2221,\"choice_text\":\"No Mental\\/Physical Health Concerns\"}],\"rows\":[],\"section_index\":122},{\"id\":388,\"question\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2222,\"choice_text\":\"Difficulty in adjusting to learning modality\"},{\"choice_index\":2223,\"choice_text\":\"Difficulty in meeting academic requirements\"},{\"choice_index\":2224,\"choice_text\":\"Difficulty working independently\"},{\"choice_index\":2225,\"choice_text\":\"Difficulty working in a group\\/pair\"},{\"choice_index\":2226,\"choice_text\":\"Dissatisfaction with academic performance\\/grades\"},{\"choice_index\":2227,\"choice_text\":\"Lacking effective study habits (note-taking, time management)\"},{\"choice_index\":2228,\"choice_text\":\"Difficulty overcoming distractions\"},{\"choice_index\":2229,\"choice_text\":\"Lacking motivation\"},{\"choice_index\":2230,\"choice_text\":\"Struggling with procrastination\"},{\"choice_index\":2231,\"choice_text\":\"Struggling to balance academics with extracurricular\\/non-academic activities\"},{\"choice_index\":2232,\"choice_text\":\"Test anxiety\"},{\"choice_index\":2233,\"choice_text\":\"No Academic concern\"}],\"rows\":[],\"section_index\":122},{\"id\":389,\"question\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2234,\"choice_text\":\"Favoritism\\/ unfair treatment\"},{\"choice_index\":2235,\"choice_text\":\"Inadequate background knowledge about the subjects\"},{\"choice_index\":2236,\"choice_text\":\"Unavailable most of the time\"},{\"choice_index\":2237,\"choice_text\":\"Difficult to reach or communicate with\"},{\"choice_index\":2238,\"choice_text\":\"Unethical\\/unprofessional behavior\"},{\"choice_index\":2239,\"choice_text\":\"Does not provide timely feedback\"},{\"choice_index\":2240,\"choice_text\":\"No Professor issues\\/concerns\"}],\"rows\":[],\"section_index\":122},{\"id\":390,\"question\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2241,\"choice_text\":\"Uncertainty about career choice\\/ wanting to shift to another program\"},{\"choice_index\":2242,\"choice_text\":\"Career choice is limited by financial resources\"},{\"choice_index\":2243,\"choice_text\":\"Unaware of strengths, abilities, or interests\"},{\"choice_index\":2244,\"choice_text\":\"Feeling lost and overwhelmed about making a career decision\"},{\"choice_index\":2245,\"choice_text\":\"Feeling pressured by peers\\/family to succeed\"},{\"choice_index\":2246,\"choice_text\":\"Need help with career planning\"},{\"choice_index\":2247,\"choice_text\":\"Dissatisfied with the present college program\"},{\"choice_index\":2248,\"choice_text\":\"Anxious about the future\\/world of work\"},{\"choice_index\":2249,\"choice_text\":\"No Career concern\"}],\"rows\":[],\"section_index\":122},{\"id\":391,\"question\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2250,\"choice_text\":\"Yes\"},{\"choice_index\":2251,\"choice_text\":\"No\"}],\"rows\":[],\"section_index\":122},{\"id\":392,\"question\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":122},{\"id\":393,\"question\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2252,\"choice_text\":\"I Certify\"}],\"rows\":[],\"section_index\":122}]},{\"id\":123,\"title\":\"CLIENT CONSENT FORM\",\"description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"order\":3,\"behavior\":\"same-page\",\"questions\":[]},{\"id\":124,\"title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"order\":4,\"behavior\":\"same-page\",\"questions\":[{\"id\":394,\"question\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2253,\"choice_text\":\"Agree\"},{\"choice_index\":2254,\"choice_text\":\"Disagree\"}],\"rows\":[],\"section_index\":124},{\"id\":395,\"question\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":124},{\"id\":396,\"question\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":124}]},{\"id\":125,\"title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"description\":\"\",\"order\":5,\"behavior\":\"same-page\",\"questions\":[{\"id\":397,\"question\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2255,\"choice_text\":\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\"},{\"choice_index\":2256,\"choice_text\":\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"}],\"rows\":[],\"section_index\":125},{\"id\":398,\"question\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":true,\"options\":[{\"choice_index\":2257,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":125}]}],\"questions\":[{\"id\":383,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2165,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":121},{\"id\":384,\"question\":\"dasdsad\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":121},{\"id\":385,\"question\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2166,\"choice_text\":\"Adjusting to change\"},{\"choice_index\":2167,\"choice_text\":\"Experiencing Bullying\\/Discrimination\"},{\"choice_index\":2168,\"choice_text\":\"Struggling with Relationship Problems\"},{\"choice_index\":2169,\"choice_text\":\"Issues with self-image\"},{\"choice_index\":2170,\"choice_text\":\"Concerns about sexuality\\/gender identity\"},{\"choice_index\":2171,\"choice_text\":\"Finding it difficult to express one\'s thoughts\\/feelings\"},{\"choice_index\":2172,\"choice_text\":\"Struggling in getting along with others\\/making friends\"},{\"choice_index\":2173,\"choice_text\":\"Spiritual\\/Religious issues\"},{\"choice_index\":2174,\"choice_text\":\"Lack of decision making skills\"},{\"choice_index\":2175,\"choice_text\":\"Lack of social support\"},{\"choice_index\":2176,\"choice_text\":\"Lacking of self-confidence\"},{\"choice_index\":2177,\"choice_text\":\"Lacks effective communication skills\"},{\"choice_index\":2178,\"choice_text\":\"Need to develop leadership skills\"},{\"choice_index\":2179,\"choice_text\":\"Need to have better self-concept\"},{\"choice_index\":2180,\"choice_text\":\"Experiencing harassment\"},{\"choice_index\":2181,\"choice_text\":\"Trust issue\"},{\"choice_index\":2182,\"choice_text\":\"Feeling very strong emotions\"},{\"choice_index\":2183,\"choice_text\":\"No social\\/emotional concern\"}],\"rows\":[],\"section_index\":122},{\"id\":386,\"question\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2184,\"choice_text\":\"Absence of father\\/mother\"},{\"choice_index\":2185,\"choice_text\":\"Dealing with a loss\"},{\"choice_index\":2186,\"choice_text\":\"Feeling of being unloved\"},{\"choice_index\":2187,\"choice_text\":\"Financial difficulties\"},{\"choice_index\":2188,\"choice_text\":\"Struggling with parents\\u2019 marital conflicts\\/separationz\"},{\"choice_index\":2189,\"choice_text\":\"Health of a family member\"},{\"choice_index\":2190,\"choice_text\":\"Home environment is not conducive to study\"},{\"choice_index\":2191,\"choice_text\":\"Homesickness\\/Living away from home\"},{\"choice_index\":2192,\"choice_text\":\"Lacking parents\' appreciation\"},{\"choice_index\":2193,\"choice_text\":\"Not getting along well with a family member\\/relative\"},{\"choice_index\":2194,\"choice_text\":\"Feeling pressured by high expectations from parents\\/family\"},{\"choice_index\":2195,\"choice_text\":\"Feeling invalidated by family members\"},{\"choice_index\":2196,\"choice_text\":\"Concerned about the health of a family member\"},{\"choice_index\":2197,\"choice_text\":\"Too many responsibilities at home\"},{\"choice_index\":2198,\"choice_text\":\"No Family\\/Home Concern\"}],\"rows\":[],\"section_index\":122},{\"id\":387,\"question\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2199,\"choice_text\":\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\"},{\"choice_index\":2200,\"choice_text\":\"Difficulty in managing emotions\"},{\"choice_index\":2201,\"choice_text\":\"Feeling burned out\"},{\"choice_index\":2202,\"choice_text\":\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\"},{\"choice_index\":2203,\"choice_text\":\"Having a physical illness that needs medical attention\"},{\"choice_index\":2204,\"choice_text\":\"Racing thoughts\"},{\"choice_index\":2205,\"choice_text\":\"Overthinking \\/ Anxiety\"},{\"choice_index\":2206,\"choice_text\":\"Having panic attacks\"},{\"choice_index\":2207,\"choice_text\":\"Experiencing stress\"},{\"choice_index\":2208,\"choice_text\":\"Difficulty coping with stress\"},{\"choice_index\":2209,\"choice_text\":\"Deep feelings of sadness\"},{\"choice_index\":2210,\"choice_text\":\"Self-harm behavior (cutting, scratching, burning, etc.)\"},{\"choice_index\":2211,\"choice_text\":\"Erratic sleeping patterns\"},{\"choice_index\":2212,\"choice_text\":\"Suicidal thoughts\"},{\"choice_index\":2213,\"choice_text\":\"Suicide attempt\"},{\"choice_index\":2214,\"choice_text\":\"Difficulty concentrating\\/being more forgetful\"},{\"choice_index\":2215,\"choice_text\":\"Avoiding people, situations, or responsibilities\"},{\"choice_index\":2216,\"choice_text\":\"Unable to enjoy\\/loss of interest in activities\"},{\"choice_index\":2217,\"choice_text\":\"Feeling empty\\/Not feeling anything\"},{\"choice_index\":2218,\"choice_text\":\"Increased irritability\"},{\"choice_index\":2219,\"choice_text\":\"Crying spells\"},{\"choice_index\":2220,\"choice_text\":\"Changes in appetite (eating more or less)\"},{\"choice_index\":2221,\"choice_text\":\"No Mental\\/Physical Health Concerns\"}],\"rows\":[],\"section_index\":122},{\"id\":388,\"question\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2222,\"choice_text\":\"Difficulty in adjusting to learning modality\"},{\"choice_index\":2223,\"choice_text\":\"Difficulty in meeting academic requirements\"},{\"choice_index\":2224,\"choice_text\":\"Difficulty working independently\"},{\"choice_index\":2225,\"choice_text\":\"Difficulty working in a group\\/pair\"},{\"choice_index\":2226,\"choice_text\":\"Dissatisfaction with academic performance\\/grades\"},{\"choice_index\":2227,\"choice_text\":\"Lacking effective study habits (note-taking, time management)\"},{\"choice_index\":2228,\"choice_text\":\"Difficulty overcoming distractions\"},{\"choice_index\":2229,\"choice_text\":\"Lacking motivation\"},{\"choice_index\":2230,\"choice_text\":\"Struggling with procrastination\"},{\"choice_index\":2231,\"choice_text\":\"Struggling to balance academics with extracurricular\\/non-academic activities\"},{\"choice_index\":2232,\"choice_text\":\"Test anxiety\"},{\"choice_index\":2233,\"choice_text\":\"No Academic concern\"}],\"rows\":[],\"section_index\":122},{\"id\":389,\"question\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2234,\"choice_text\":\"Favoritism\\/ unfair treatment\"},{\"choice_index\":2235,\"choice_text\":\"Inadequate background knowledge about the subjects\"},{\"choice_index\":2236,\"choice_text\":\"Unavailable most of the time\"},{\"choice_index\":2237,\"choice_text\":\"Difficult to reach or communicate with\"},{\"choice_index\":2238,\"choice_text\":\"Unethical\\/unprofessional behavior\"},{\"choice_index\":2239,\"choice_text\":\"Does not provide timely feedback\"},{\"choice_index\":2240,\"choice_text\":\"No Professor issues\\/concerns\"}],\"rows\":[],\"section_index\":122},{\"id\":390,\"question\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2241,\"choice_text\":\"Uncertainty about career choice\\/ wanting to shift to another program\"},{\"choice_index\":2242,\"choice_text\":\"Career choice is limited by financial resources\"},{\"choice_index\":2243,\"choice_text\":\"Unaware of strengths, abilities, or interests\"},{\"choice_index\":2244,\"choice_text\":\"Feeling lost and overwhelmed about making a career decision\"},{\"choice_index\":2245,\"choice_text\":\"Feeling pressured by peers\\/family to succeed\"},{\"choice_index\":2246,\"choice_text\":\"Need help with career planning\"},{\"choice_index\":2247,\"choice_text\":\"Dissatisfied with the present college program\"},{\"choice_index\":2248,\"choice_text\":\"Anxious about the future\\/world of work\"},{\"choice_index\":2249,\"choice_text\":\"No Career concern\"}],\"rows\":[],\"section_index\":122},{\"id\":391,\"question\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2250,\"choice_text\":\"Yes\"},{\"choice_index\":2251,\"choice_text\":\"No\"}],\"rows\":[],\"section_index\":122},{\"id\":392,\"question\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":122},{\"id\":393,\"question\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2252,\"choice_text\":\"I Certify\"}],\"rows\":[],\"section_index\":122},{\"id\":394,\"question\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2253,\"choice_text\":\"Agree\"},{\"choice_index\":2254,\"choice_text\":\"Disagree\"}],\"rows\":[],\"section_index\":124},{\"id\":395,\"question\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":124},{\"id\":396,\"question\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":124},{\"id\":397,\"question\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2255,\"choice_text\":\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\"},{\"choice_index\":2256,\"choice_text\":\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"}],\"rows\":[],\"section_index\":125},{\"id\":398,\"question\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":true,\"options\":[{\"choice_index\":2257,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":125}],\"timestamp\":\"2025-05-21T10:28:27+02:00\"}', 1, '2025-05-21 08:28:27', 0);
INSERT INTO `form_snapshots` (`snapshot_index`, `snapshot_data`, `form_index`, `created_at`, `is_active`) VALUES
(12, '{\"form_index\":1,\"form_name\":\"STUDENT INDIVIDUAL INVENTORY (SII) & CLIENT CONSENT FORM AY 2024-2025\",\"description\":\"This form would only take 15- 20 minutes of your time.\\n\\nEvery person\'s life is a developing story. The person you are today is a result of your upbringing and experiences, joys and sorrows, desires, and dreams. While we know that it\'s tempting to rush at times, please take some time to reflect on your life.\",\"sections\":[{\"id\":126,\"title\":\"Consent\",\"description\":\"This section outlines the terms and conditions regarding the collection, processing, and storage of personal information by the College Guidance and Counseling Center (CGCC) at De La Salle Lipa (DLSL).\",\"order\":1,\"behavior\":\"same-page\",\"questions\":[{\"id\":399,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2258,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":126},{\"id\":400,\"question\":\"JSONNNN\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":126}]},{\"id\":127,\"title\":\"DETAILED CONCERNS\",\"description\":\"The items below describe some of the concerns that students your age might experience. Please check your top five concerns in which the guidance counselor can help you with.\",\"order\":2,\"behavior\":\"same-page\",\"questions\":[{\"id\":401,\"question\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2259,\"choice_text\":\"Adjusting to change\"},{\"choice_index\":2260,\"choice_text\":\"Experiencing Bullying\\/Discrimination\"},{\"choice_index\":2261,\"choice_text\":\"Struggling with Relationship Problems\"},{\"choice_index\":2262,\"choice_text\":\"Issues with self-image\"},{\"choice_index\":2263,\"choice_text\":\"Concerns about sexuality\\/gender identity\"},{\"choice_index\":2264,\"choice_text\":\"Finding it difficult to express one\'s thoughts\\/feelings\"},{\"choice_index\":2265,\"choice_text\":\"Struggling in getting along with others\\/making friends\"},{\"choice_index\":2266,\"choice_text\":\"Spiritual\\/Religious issues\"},{\"choice_index\":2267,\"choice_text\":\"Lack of decision making skills\"},{\"choice_index\":2268,\"choice_text\":\"Lack of social support\"},{\"choice_index\":2269,\"choice_text\":\"Lacking of self-confidence\"},{\"choice_index\":2270,\"choice_text\":\"Lacks effective communication skills\"},{\"choice_index\":2271,\"choice_text\":\"Need to develop leadership skills\"},{\"choice_index\":2272,\"choice_text\":\"Need to have better self-concept\"},{\"choice_index\":2273,\"choice_text\":\"Experiencing harassment\"},{\"choice_index\":2274,\"choice_text\":\"Trust issue\"},{\"choice_index\":2275,\"choice_text\":\"Feeling very strong emotions\"},{\"choice_index\":2276,\"choice_text\":\"No social\\/emotional concern\"}],\"rows\":[],\"section_index\":127},{\"id\":402,\"question\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2277,\"choice_text\":\"Absence of father\\/mother\"},{\"choice_index\":2278,\"choice_text\":\"Dealing with a loss\"},{\"choice_index\":2279,\"choice_text\":\"Feeling of being unloved\"},{\"choice_index\":2280,\"choice_text\":\"Financial difficulties\"},{\"choice_index\":2281,\"choice_text\":\"Struggling with parents\\u2019 marital conflicts\\/separationz\"},{\"choice_index\":2282,\"choice_text\":\"Health of a family member\"},{\"choice_index\":2283,\"choice_text\":\"Home environment is not conducive to study\"},{\"choice_index\":2284,\"choice_text\":\"Homesickness\\/Living away from home\"},{\"choice_index\":2285,\"choice_text\":\"Lacking parents\' appreciation\"},{\"choice_index\":2286,\"choice_text\":\"Not getting along well with a family member\\/relative\"},{\"choice_index\":2287,\"choice_text\":\"Feeling pressured by high expectations from parents\\/family\"},{\"choice_index\":2288,\"choice_text\":\"Feeling invalidated by family members\"},{\"choice_index\":2289,\"choice_text\":\"Concerned about the health of a family member\"},{\"choice_index\":2290,\"choice_text\":\"Too many responsibilities at home\"},{\"choice_index\":2291,\"choice_text\":\"No Family\\/Home Concern\"}],\"rows\":[],\"section_index\":127},{\"id\":403,\"question\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2292,\"choice_text\":\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\"},{\"choice_index\":2293,\"choice_text\":\"Difficulty in managing emotions\"},{\"choice_index\":2294,\"choice_text\":\"Feeling burned out\"},{\"choice_index\":2295,\"choice_text\":\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\"},{\"choice_index\":2296,\"choice_text\":\"Having a physical illness that needs medical attention\"},{\"choice_index\":2297,\"choice_text\":\"Racing thoughts\"},{\"choice_index\":2298,\"choice_text\":\"Overthinking \\/ Anxiety\"},{\"choice_index\":2299,\"choice_text\":\"Having panic attacks\"},{\"choice_index\":2300,\"choice_text\":\"Experiencing stress\"},{\"choice_index\":2301,\"choice_text\":\"Difficulty coping with stress\"},{\"choice_index\":2302,\"choice_text\":\"Deep feelings of sadness\"},{\"choice_index\":2303,\"choice_text\":\"Self-harm behavior (cutting, scratching, burning, etc.)\"},{\"choice_index\":2304,\"choice_text\":\"Erratic sleeping patterns\"},{\"choice_index\":2305,\"choice_text\":\"Suicidal thoughts\"},{\"choice_index\":2306,\"choice_text\":\"Suicide attempt\"},{\"choice_index\":2307,\"choice_text\":\"Difficulty concentrating\\/being more forgetful\"},{\"choice_index\":2308,\"choice_text\":\"Avoiding people, situations, or responsibilities\"},{\"choice_index\":2309,\"choice_text\":\"Unable to enjoy\\/loss of interest in activities\"},{\"choice_index\":2310,\"choice_text\":\"Feeling empty\\/Not feeling anything\"},{\"choice_index\":2311,\"choice_text\":\"Increased irritability\"},{\"choice_index\":2312,\"choice_text\":\"Crying spells\"},{\"choice_index\":2313,\"choice_text\":\"Changes in appetite (eating more or less)\"},{\"choice_index\":2314,\"choice_text\":\"No Mental\\/Physical Health Concerns\"}],\"rows\":[],\"section_index\":127},{\"id\":404,\"question\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2315,\"choice_text\":\"Difficulty in adjusting to learning modality\"},{\"choice_index\":2316,\"choice_text\":\"Difficulty in meeting academic requirements\"},{\"choice_index\":2317,\"choice_text\":\"Difficulty working independently\"},{\"choice_index\":2318,\"choice_text\":\"Difficulty working in a group\\/pair\"},{\"choice_index\":2319,\"choice_text\":\"Dissatisfaction with academic performance\\/grades\"},{\"choice_index\":2320,\"choice_text\":\"Lacking effective study habits (note-taking, time management)\"},{\"choice_index\":2321,\"choice_text\":\"Difficulty overcoming distractions\"},{\"choice_index\":2322,\"choice_text\":\"Lacking motivation\"},{\"choice_index\":2323,\"choice_text\":\"Struggling with procrastination\"},{\"choice_index\":2324,\"choice_text\":\"Struggling to balance academics with extracurricular\\/non-academic activities\"},{\"choice_index\":2325,\"choice_text\":\"Test anxiety\"},{\"choice_index\":2326,\"choice_text\":\"No Academic concern\"}],\"rows\":[],\"section_index\":127},{\"id\":405,\"question\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2327,\"choice_text\":\"Favoritism\\/ unfair treatment\"},{\"choice_index\":2328,\"choice_text\":\"Inadequate background knowledge about the subjects\"},{\"choice_index\":2329,\"choice_text\":\"Unavailable most of the time\"},{\"choice_index\":2330,\"choice_text\":\"Difficult to reach or communicate with\"},{\"choice_index\":2331,\"choice_text\":\"Unethical\\/unprofessional behavior\"},{\"choice_index\":2332,\"choice_text\":\"Does not provide timely feedback\"},{\"choice_index\":2333,\"choice_text\":\"No Professor issues\\/concerns\"}],\"rows\":[],\"section_index\":127},{\"id\":406,\"question\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2334,\"choice_text\":\"Uncertainty about career choice\\/ wanting to shift to another program\"},{\"choice_index\":2335,\"choice_text\":\"Career choice is limited by financial resources\"},{\"choice_index\":2336,\"choice_text\":\"Unaware of strengths, abilities, or interests\"},{\"choice_index\":2337,\"choice_text\":\"Feeling lost and overwhelmed about making a career decision\"},{\"choice_index\":2338,\"choice_text\":\"Feeling pressured by peers\\/family to succeed\"},{\"choice_index\":2339,\"choice_text\":\"Need help with career planning\"},{\"choice_index\":2340,\"choice_text\":\"Dissatisfied with the present college program\"},{\"choice_index\":2341,\"choice_text\":\"Anxious about the future\\/world of work\"},{\"choice_index\":2342,\"choice_text\":\"No Career concern\"}],\"rows\":[],\"section_index\":127},{\"id\":407,\"question\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2343,\"choice_text\":\"Yes\"},{\"choice_index\":2344,\"choice_text\":\"No\"}],\"rows\":[],\"section_index\":127},{\"id\":408,\"question\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":127},{\"id\":409,\"question\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2345,\"choice_text\":\"I Certify\"}],\"rows\":[],\"section_index\":127}]},{\"id\":128,\"title\":\"CLIENT CONSENT FORM\",\"description\":\"This form is a document provided by the CGCC to students in order to properly acquire consent for Counseling. The form contains information about the counseling service and the agreement between the counselor and the student.\\n\\nAPPOINTMENT\\nYour sessions are scheduled and agreed upon by you and your counselors. When you need to cancel or reschedule an appointment, please give us at least 24-hours notice.\\n\\nCOUNSELING and ASSESSMENT\\nCounseling is an opportunity to identify and build on current strengths, learn problem-solving strategies, develop or enhance coping skills, learn more effective ways to communicate with others, and receive support and feedback. Assessment is crucial in facilitating the counselor\\u2019s understanding of the client. The counseling relationship is designed to be one that will promote change and growth. The counselor and client both have active roles. A record of the counseling and assessment services provided to each client is maintained.\\n\\nThe goal of the counselor is to provide a comfortable and supportive environment conducive to insight, healing, and personal growth. Your role, as the client, will be to identify goals you would like to achieve during the course of counseling and be willing to examine any potential obstacles and strengths that will either hinder or help you achieve your desired goals.\\n\\nRISKS\\nCounseling and assessment can have benefits and risks and it is important to consider both when making any treatment decisions. Since counseling involves discussing unpleasant aspects of your life, there is a risk that you may experience temporary uncomfortable feelings like sadness, guilt, anger, frustration, loneliness, and helplessness. Disclosing personal information during an assessment may likewise feel uncomfortable and might make you feel vulnerable.\\n\\nCOUNSELOR CONTACT INFORMATION\\nThe primary way to get in touch with us is by contacting your counselor through Canvas or email. If you are in a crisis and need immediate assistance, please go to your nearest emergency room.\",\"order\":3,\"behavior\":\"same-page\",\"questions\":[]},{\"id\":129,\"title\":\"CONFIDENTIALITY and RELEASE of INFORMATION\",\"description\":\"Protecting your privacy is very important. The information in your record is confidential and will not be disclosed to anyone without your written consent unless required by law.\\n\\nThe exceptions to confidentiality include:\\nIf you tell your counselor that you are going to harm or kill yourself or someone else, we are required by law to do whatever we can do to prevent that from happening and to ensure your safety and the safety of others. This may require notifying family members, parents, legal guardians, legal authorities, and\\/or potential victims.\\n\\nIf you tell us about incidents of abuse, we are required to report this to proper authorities.\\n\\nWe are required to release your records if they are subpoenaed by a court of law.\\n\\nIn addition to the above, there are several other situations where confidentiality cannot be insured, including:\\n\\nIf you provide us with a request to release your records\\n\\nIf you are in family counseling, we cannot guarantee confidentiality will be maintained by other family members.\\n\\nIf you are a child\\/minor or unable to voluntarily consent, a guardian must give written consent and can access your records.\",\"order\":4,\"behavior\":\"same-page\",\"questions\":[{\"id\":410,\"question\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2346,\"choice_text\":\"Agree\"},{\"choice_index\":2347,\"choice_text\":\"Disagree\"}],\"rows\":[],\"section_index\":129},{\"id\":411,\"question\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":129},{\"id\":412,\"question\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":129}]},{\"id\":130,\"title\":\"USE of CLIENT INFORMATION on OUTCOME RESEARCH\",\"description\":\"\",\"order\":5,\"behavior\":\"same-page\",\"questions\":[{\"id\":413,\"question\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2348,\"choice_text\":\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\"},{\"choice_index\":2349,\"choice_text\":\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"}],\"rows\":[],\"section_index\":130},{\"id\":414,\"question\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":true,\"options\":[{\"choice_index\":2350,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":130}]}],\"questions\":[{\"id\":399,\"question\":\"I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2258,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":126},{\"id\":400,\"question\":\"JSONNNN\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":126},{\"id\":401,\"question\":\"SOCIAL\\/EMOTIONAL CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2259,\"choice_text\":\"Adjusting to change\"},{\"choice_index\":2260,\"choice_text\":\"Experiencing Bullying\\/Discrimination\"},{\"choice_index\":2261,\"choice_text\":\"Struggling with Relationship Problems\"},{\"choice_index\":2262,\"choice_text\":\"Issues with self-image\"},{\"choice_index\":2263,\"choice_text\":\"Concerns about sexuality\\/gender identity\"},{\"choice_index\":2264,\"choice_text\":\"Finding it difficult to express one\'s thoughts\\/feelings\"},{\"choice_index\":2265,\"choice_text\":\"Struggling in getting along with others\\/making friends\"},{\"choice_index\":2266,\"choice_text\":\"Spiritual\\/Religious issues\"},{\"choice_index\":2267,\"choice_text\":\"Lack of decision making skills\"},{\"choice_index\":2268,\"choice_text\":\"Lack of social support\"},{\"choice_index\":2269,\"choice_text\":\"Lacking of self-confidence\"},{\"choice_index\":2270,\"choice_text\":\"Lacks effective communication skills\"},{\"choice_index\":2271,\"choice_text\":\"Need to develop leadership skills\"},{\"choice_index\":2272,\"choice_text\":\"Need to have better self-concept\"},{\"choice_index\":2273,\"choice_text\":\"Experiencing harassment\"},{\"choice_index\":2274,\"choice_text\":\"Trust issue\"},{\"choice_index\":2275,\"choice_text\":\"Feeling very strong emotions\"},{\"choice_index\":2276,\"choice_text\":\"No social\\/emotional concern\"}],\"rows\":[],\"section_index\":127},{\"id\":402,\"question\":\"FAMILY & HOME CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2277,\"choice_text\":\"Absence of father\\/mother\"},{\"choice_index\":2278,\"choice_text\":\"Dealing with a loss\"},{\"choice_index\":2279,\"choice_text\":\"Feeling of being unloved\"},{\"choice_index\":2280,\"choice_text\":\"Financial difficulties\"},{\"choice_index\":2281,\"choice_text\":\"Struggling with parents\\u2019 marital conflicts\\/separationz\"},{\"choice_index\":2282,\"choice_text\":\"Health of a family member\"},{\"choice_index\":2283,\"choice_text\":\"Home environment is not conducive to study\"},{\"choice_index\":2284,\"choice_text\":\"Homesickness\\/Living away from home\"},{\"choice_index\":2285,\"choice_text\":\"Lacking parents\' appreciation\"},{\"choice_index\":2286,\"choice_text\":\"Not getting along well with a family member\\/relative\"},{\"choice_index\":2287,\"choice_text\":\"Feeling pressured by high expectations from parents\\/family\"},{\"choice_index\":2288,\"choice_text\":\"Feeling invalidated by family members\"},{\"choice_index\":2289,\"choice_text\":\"Concerned about the health of a family member\"},{\"choice_index\":2290,\"choice_text\":\"Too many responsibilities at home\"},{\"choice_index\":2291,\"choice_text\":\"No Family\\/Home Concern\"}],\"rows\":[],\"section_index\":127},{\"id\":403,\"question\":\"MENTAL\\/PHYSICAL HEALTH CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2292,\"choice_text\":\"Struggling with addiction (substance use, internet, gaming, gambling, shopping)\"},{\"choice_index\":2293,\"choice_text\":\"Difficulty in managing emotions\"},{\"choice_index\":2294,\"choice_text\":\"Feeling burned out\"},{\"choice_index\":2295,\"choice_text\":\"Feeling tired\\/fatigued most of the time (physically\\/emotionally)\"},{\"choice_index\":2296,\"choice_text\":\"Having a physical illness that needs medical attention\"},{\"choice_index\":2297,\"choice_text\":\"Racing thoughts\"},{\"choice_index\":2298,\"choice_text\":\"Overthinking \\/ Anxiety\"},{\"choice_index\":2299,\"choice_text\":\"Having panic attacks\"},{\"choice_index\":2300,\"choice_text\":\"Experiencing stress\"},{\"choice_index\":2301,\"choice_text\":\"Difficulty coping with stress\"},{\"choice_index\":2302,\"choice_text\":\"Deep feelings of sadness\"},{\"choice_index\":2303,\"choice_text\":\"Self-harm behavior (cutting, scratching, burning, etc.)\"},{\"choice_index\":2304,\"choice_text\":\"Erratic sleeping patterns\"},{\"choice_index\":2305,\"choice_text\":\"Suicidal thoughts\"},{\"choice_index\":2306,\"choice_text\":\"Suicide attempt\"},{\"choice_index\":2307,\"choice_text\":\"Difficulty concentrating\\/being more forgetful\"},{\"choice_index\":2308,\"choice_text\":\"Avoiding people, situations, or responsibilities\"},{\"choice_index\":2309,\"choice_text\":\"Unable to enjoy\\/loss of interest in activities\"},{\"choice_index\":2310,\"choice_text\":\"Feeling empty\\/Not feeling anything\"},{\"choice_index\":2311,\"choice_text\":\"Increased irritability\"},{\"choice_index\":2312,\"choice_text\":\"Crying spells\"},{\"choice_index\":2313,\"choice_text\":\"Changes in appetite (eating more or less)\"},{\"choice_index\":2314,\"choice_text\":\"No Mental\\/Physical Health Concerns\"}],\"rows\":[],\"section_index\":127},{\"id\":404,\"question\":\"ACADEMIC CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2315,\"choice_text\":\"Difficulty in adjusting to learning modality\"},{\"choice_index\":2316,\"choice_text\":\"Difficulty in meeting academic requirements\"},{\"choice_index\":2317,\"choice_text\":\"Difficulty working independently\"},{\"choice_index\":2318,\"choice_text\":\"Difficulty working in a group\\/pair\"},{\"choice_index\":2319,\"choice_text\":\"Dissatisfaction with academic performance\\/grades\"},{\"choice_index\":2320,\"choice_text\":\"Lacking effective study habits (note-taking, time management)\"},{\"choice_index\":2321,\"choice_text\":\"Difficulty overcoming distractions\"},{\"choice_index\":2322,\"choice_text\":\"Lacking motivation\"},{\"choice_index\":2323,\"choice_text\":\"Struggling with procrastination\"},{\"choice_index\":2324,\"choice_text\":\"Struggling to balance academics with extracurricular\\/non-academic activities\"},{\"choice_index\":2325,\"choice_text\":\"Test anxiety\"},{\"choice_index\":2326,\"choice_text\":\"No Academic concern\"}],\"rows\":[],\"section_index\":127},{\"id\":405,\"question\":\"PROFESSOR ISSUE CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2327,\"choice_text\":\"Favoritism\\/ unfair treatment\"},{\"choice_index\":2328,\"choice_text\":\"Inadequate background knowledge about the subjects\"},{\"choice_index\":2329,\"choice_text\":\"Unavailable most of the time\"},{\"choice_index\":2330,\"choice_text\":\"Difficult to reach or communicate with\"},{\"choice_index\":2331,\"choice_text\":\"Unethical\\/unprofessional behavior\"},{\"choice_index\":2332,\"choice_text\":\"Does not provide timely feedback\"},{\"choice_index\":2333,\"choice_text\":\"No Professor issues\\/concerns\"}],\"rows\":[],\"section_index\":127},{\"id\":406,\"question\":\"CAREER CONCERNS\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2334,\"choice_text\":\"Uncertainty about career choice\\/ wanting to shift to another program\"},{\"choice_index\":2335,\"choice_text\":\"Career choice is limited by financial resources\"},{\"choice_index\":2336,\"choice_text\":\"Unaware of strengths, abilities, or interests\"},{\"choice_index\":2337,\"choice_text\":\"Feeling lost and overwhelmed about making a career decision\"},{\"choice_index\":2338,\"choice_text\":\"Feeling pressured by peers\\/family to succeed\"},{\"choice_index\":2339,\"choice_text\":\"Need help with career planning\"},{\"choice_index\":2340,\"choice_text\":\"Dissatisfied with the present college program\"},{\"choice_index\":2341,\"choice_text\":\"Anxious about the future\\/world of work\"},{\"choice_index\":2342,\"choice_text\":\"No Career concern\"}],\"rows\":[],\"section_index\":127},{\"id\":407,\"question\":\"I have other concerns\\/questions that I want to directly consult or discuss with my counselor.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2343,\"choice_text\":\"Yes\"},{\"choice_index\":2344,\"choice_text\":\"No\"}],\"rows\":[],\"section_index\":127},{\"id\":408,\"question\":\"We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments\\/suggestions, please indicate them below:\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":127},{\"id\":409,\"question\":\"By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2345,\"choice_text\":\"I Certify\"}],\"rows\":[],\"section_index\":127},{\"id\":410,\"question\":\"I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and\\/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2346,\"choice_text\":\"Agree\"},{\"choice_index\":2347,\"choice_text\":\"Disagree\"}],\"rows\":[],\"section_index\":129},{\"id\":411,\"question\":\"Name of Father\\/Mother or Legal Guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":129},{\"id\":412,\"question\":\"Contact number of parent\\/guardian\",\"type\":\"short\",\"required\":true,\"includeOther\":false,\"options\":[],\"rows\":[],\"section_index\":129},{\"id\":413,\"question\":\"When client information is utilized on outcome research purposes, client names are not disclosed.\",\"type\":\"multiple\",\"required\":true,\"includeOther\":false,\"options\":[{\"choice_index\":2348,\"choice_text\":\"I allow the College Guidance and Counseling Center to use the data from my record for outcome research given that my identity is protected.\"},{\"choice_index\":2349,\"choice_text\":\"I do not allow the College Guidance and Counseling Center to use the data from my record for outcome research.\"}],\"rows\":[],\"section_index\":130},{\"id\":414,\"question\":\"Counseling Guidelines Please review the Counseling Guidelines through this link: https:\\/\\/bit.ly\\/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.\",\"type\":\"checkbox\",\"required\":true,\"includeOther\":true,\"options\":[{\"choice_index\":2350,\"choice_text\":\"Yes\"}],\"rows\":[],\"section_index\":130}],\"timestamp\":\"2025-05-21T10:31:18+02:00\"}', 1, '2025-05-21 08:31:18', 1);

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
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `include_other` tinyint(1) DEFAULT 0,
  `section_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `main_questions`
--

INSERT INTO `main_questions` (`main_question_index`, `form_index`, `main_question_text`, `type_index`, `is_required`, `include_other`, `section_index`) VALUES
(2, 2, 'fsdfsfd', 6, 0, 0, 2),
(415, 1, 'I understand that this form is considered an official record of De La Salle Lipa and that College Guidance and Counseling Center (CGCC) is required to keep my personal information and records until such time that these documents are due for disposal based on the DLSL data privacy retention policy. Some of the services of CGCC that would utilize this data are Counseling, Referral, and Research and Development. This form shall only be accessed by the CGCC team. CGCC shall retain the data in accordance with Document Retention Period and will be deleted upon disposal. By answering this form, you are giving CGCC consent to process and store this information. Please answer carefully and truthfully.', 4, 1, 0, 131),
(416, 1, 'SOCIAL/EMOTIONAL CONCERNS', 4, 1, 0, 132),
(417, 1, 'FAMILY & HOME CONCERNS', 4, 1, 0, 132),
(418, 1, 'MENTAL/PHYSICAL HEALTH CONCERNS', 4, 1, 0, 132),
(419, 1, 'ACADEMIC CONCERNS', 4, 1, 0, 132),
(420, 1, 'PROFESSOR ISSUE CONCERNS', 4, 1, 0, 132),
(421, 1, 'CAREER CONCERNS', 4, 1, 0, 132),
(422, 1, 'I have other concerns/questions that I want to directly consult or discuss with my counselor.', 3, 1, 0, 132),
(423, 1, 'We appreciate your feedback. Please let us know how we can best improve our CGCC Student Individual Inventory (SII) Form. If you have comments/suggestions, please indicate them below:', 1, 1, 0, 132),
(424, 1, 'By submitting this form, I certify that the above information are true and correct. FALSIFICATION of any information will be subjected to DISCIPLINARY ACTION.', 4, 1, 0, 132),
(425, 1, 'I understand the nature and limits of confidentiality stated above and accept them as part of the benefits and conditions of participating in counseling. In the event that my counselor reasonably believes that there is evidence of clear and imminent danger of harm to myself and/or others, physically or emotionally, I give consent to my counselor to contact the following persons, in addition to the school and medical personnel.', 3, 1, 0, 134),
(426, 1, 'Name of Father/Mother or Legal Guardian', 1, 1, 0, 134),
(427, 1, 'Contact number of parent/guardian', 1, 1, 0, 134),
(428, 1, 'When client information is utilized on outcome research purposes, client names are not disclosed.', 3, 1, 0, 135),
(429, 1, 'Counseling Guidelines Please review the Counseling Guidelines through this link: https://bit.ly/counselingguide By accomplishing this form you understand and agree to the guidelines set by CGCC. This document has provided the information required to address expectations about counseling. I have read and fully understand this document. All questions that I had have been answered to my satisfaction. By filling out this form, I voluntarily agree to accept counseling.', 4, 1, 1, 135);

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
(9, 2, 'BEED', 'Bachelor of Elementary Education', NULL),
(10, 2, 'BSED', 'Bachelor of Secondary Education', NULL),
(11, 2, 'AB COM', 'Bachelor of Arts in Communication', NULL),
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
(28, 4, 'ACT', 'Associate in Computer Technology', NULL),
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
(60, 'JD-1B', 30, '1');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_index` int(11) NOT NULL,
  `user_index` int(11) NOT NULL,
  `image_path` varchar(200) NOT NULL COMMENT 'Profile picture of the student',
  `student_number` varchar(255) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL COMMENT 'phone number of the student',
  `year_level` int(1) NOT NULL,
  `section_index` int(11) NOT NULL,
  `guardian_index` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_index`, `user_index`, `image_path`, `student_number`, `last_name`, `first_name`, `contact_number`, `year_level`, `section_index`, `guardian_index`) VALUES
(1, 2, '', '321421321', 'AGUSTIN', 'JOHN ANDREI', '9832918931', 1, 53, 1),
(2, 3, '', '2023360151', 'ALCANTARA', 'JANNA MIKHAELA', '9457153265', 1, 53, 2),
(3, 4, '', '213214', 'ALONZO', 'ENJEY KASHLEE', '9278558558', 1, 53, 3),
(4, 5, '', '2023363891', 'ALONZO', 'JHENELLE', '9321389210', 1, 53, 4),
(5, 6, '', '2023351801', 'BALION', 'ANGEL AMAYA', '9155167138', 1, 53, 5),
(6, 7, '', '2021310121', 'BARTE', 'ALFONSO RAFAEL', '9953011635', 1, 53, 6),
(7, 8, '', '812180', 'CADELIŇA', 'REGINA ANGELI', '9387882631', 1, 53, 7),
(8, 9, '', '312421', 'CATIBOG', 'DJAN MATTHEW', '9155141440', 1, 53, 8),
(9, 10, '', '2023350761', 'DEL ROSARIO', 'RENZ ANDREI', '9321421312', 1, 53, 9),
(10, 11, '', '2023360611', 'DELA PEŇA', 'MARC LAWRENCE', '9395720600', 1, 53, 10),
(11, 12, '', '2023350511', 'DELA VEGA', 'PRINCESS MIHAELA', '9471091401', 1, 53, 11),
(12, 13, '', '2023352471', 'DOCTOLERO', 'LYRUS LEI', '9686269099', 1, 53, 12),
(13, 14, '', '2023359741', 'DONES', 'KYLE GABRIEL', '09954010556', 1, 53, 13),
(14, 15, '', '2023348471', 'ESTRELLA', 'JUAN BENJO', '09771549349', 1, 53, 14),
(15, 16, '', '35152231', 'FEDELICIO', 'LENARD LANCE', '09533599052', 1, 53, 15),
(16, 17, '', '2023362151', 'GARCIA', 'HARRY', '09566224682', 1, 53, 16),
(17, 18, '', '2023362381', 'JAURIGUE', 'IVAN JOSEPH', '9568379291', 1, 53, 17),
(18, 19, '', '2023347681', 'KINCHASAN', 'MARK JEROME', '9667531028', 1, 53, 18),
(19, 20, '', '2023363211', 'LIQUE', 'JERIC', '9219979430', 1, 53, 19),
(20, 21, '', '2023364851', 'LIRIO', 'SEAN CALVIN THEO', '9923142591', 1, 54, 20),
(21, 22, '', '2023362901', 'LIWANAG', 'KATHERINE ANNE', '9617739701', 1, 54, 21),
(22, 23, '', '2023364391', 'MACALINTAL', 'CHESTER BORIZ', '9952071990', 1, 54, 22),
(23, 24, '', '2023352051', 'MACASAET', 'JOHN RAFHAEL STEVEN', '9202784081', 1, 54, 23),
(24, 25, '', '1500017172', 'MAGBUHAT', 'ALEXIE CHYLE', '9984264195', 1, 54, 24),
(25, 26, '', '2023361281', 'MANALO', 'JOHN AARON', '9674326323', 1, 54, 25),
(26, 27, '', '2023351631', 'MANIMTIM', 'IAN KARVEY', '9770494572', 1, 54, 26),
(27, 28, '', '2023350751', 'MARQUINEZ', 'ISIAH JOSEPH', '9473450276', 1, 54, 27),
(28, 29, '', '5124214', 'MEER', 'SEBASTIAN ANGELO', '9321984921', 1, 54, 28),
(29, 30, '', '2023365041', 'MENDEZ', 'WYETH IRISH', '9302193221', 1, 54, 29),
(30, 31, '', '811870', 'NARIO', 'JAN ERNEST PACEY', '9552861753', 1, 54, 30),
(31, 32, '', '2023362191', 'NARIO', 'KEITH JUSTIN', '9774696570', 1, 54, 31),
(32, 33, '', '1700020669', 'PANUELA', 'MICHAEL JOSH', '9566322071', 1, 54, 32),
(33, 34, '', '2023362341', 'PARAY', 'JANE ALLYSON', '9293410108', 1, 54, 33),
(34, 35, '', '2023358411', 'SAHAGUN', 'DANIEL LUIS', '9298657375', 1, 54, 34),
(35, 36, '', '2023364651', 'SIMAN', 'THOMAS ALEXANDRE', '9760811239', 1, 54, 35),
(36, 37, '', '2023359771', 'TALENS', 'XYRELLE DOMINIQUE', '9605365864', 1, 54, 36),
(37, 38, '', '2023352411', 'TENORIO', 'JHON PAULO', '9912217223', 1, 54, 37),
(38, 39, '', '1700019578', 'TORRES', 'KYAN PRINCE', '9561998634', 1, 54, 38);

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
(1, 'amybalion533@gmail.com', '$2y$10$.ugAqIwocz1sb1wE4k9p/.OQ.VQfqOiy/8YrMyXk7l1sTDNUe19s6', 'admin', '2025-04-30 07:34:49'),
(2, 'john_andrei_agustin@dlsl.edu.ph', '$2y$10$8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdYxgBZuOW', 'student', '2025-05-21 14:08:04'),
(3, 'janna_mikhaela_alcantara@dlsl.edu.ph', '$2y$10$GtA3eKsDnTqWvLlM7.hEVePZr5fHcWzT1uJvXwS0qYmOeZbUdL8Di', 'student', '2025-05-21 14:08:04'),
(4, 'enjey_kashlee_alonzo@dlsl.edu.ph', '$2y$10$7iK8sPpY.fJZV2B7zYR8ae4mXZ.b9VZ6gqNvW7hU1oLkTmS5jVzOW', 'student', '2025-05-21 14:08:04'),
(5, 'jhenelle_alonzo@dlsl.edu.ph', '$2y$10$R0vF.6Z9ZV0mTz2mFzK4Fe8sD9VZa3yZ7XwS8uJvXqNvW7hU1oLkT', 'student', '2025-05-21 14:08:04'),
(6, 'angel_amaya_balion@dlsl.edu.ph', '$2y$10$aZ3KpQvXhFmzOjUw2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5', 'student', '2025-05-21 14:08:04'),
(7, 'alfonso_rafael_barte@dlsl.edu.ph', '$2y$10$PZr5fHcWzT1uJvXqNvW7hU1oLkTmS5jVzOW8cN7C6R49VZ5Kk3Lbq', 'student', '2025-05-21 14:08:04'),
(8, 'regina_angeli_cadelina@dlsl.edu.ph', '$2y$10$VePZr5fHcWzT1uJvXqNvW7hU1oLkTmS5jVzOW8cN7C6R49VZ5Kk3L', 'student', '2025-05-21 14:08:04'),
(9, 'djan_matthew_catibog@dlsl.edu.ph', '$2y$10$zT1uJvXqNvW7hU1oLkTmS5jVzOW8cN7C6R49VZ5Kk3LbqT5CeHJpQ', 'student', '2025-05-21 14:08:04'),
(10, 'renz_andrei_delrosario@dlsl.edu.ph', '$2y$10$mzOjUw2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhF', 'student', '2025-05-21 14:08:04'),
(11, 'marc_lawrence_delapena@dlsl.edu.ph', '$2y$10$Iw2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOj', 'student', '2025-05-21 14:08:04'),
(12, 'princess_mihaela_delavega@dlsl.edu.ph', '$2y$10$9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS', 'student', '2025-05-21 14:08:04'),
(13, 'lyrus_lei_doctolero@dlsl.edu.ph', '$2y$10$gBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdYx', 'student', '2025-05-21 14:08:04'),
(14, 'kyle_gabriel_dones@dlsl.edu.ph', '$2y$10$Uw2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOj', 'student', '2025-05-21 14:08:04'),
(15, 'juan_benjo_estrella@dlsl.edu.ph', '$2y$10$oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9', 'student', '2025-05-21 14:08:04'),
(16, 'lenard_lance_fedelicio@dlsl.edu.ph', '$2y$10$xgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdY', 'student', '2025-05-21 14:08:04'),
(17, 'harry_garcia@dlsl.edu.ph', '$2y$10$w2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjU', 'student', '2025-05-21 14:08:04'),
(18, 'ivan_joseph_jaurigue@dlsl.edu.ph', '$2y$10$9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS', 'student', '2025-05-21 14:08:04'),
(19, 'mark_jerome_kinchasan@dlsl.edu.ph', '$2y$10$gBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdYx', 'student', '2025-05-21 14:08:04'),
(20, 'jeric_lique@dls.edu.ph', '$2y$10$tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2', 'student', '2025-05-21 14:08:04'),
(21, 'sean_calvin_theo_lirio@dlsl.edu.ph', '$2y$10$PdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9o', 'student', '2025-05-21 14:08:04'),
(22, 'katherine_anne_liwanag@dlsl.edu.ph', '$2y$10$YxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPd', 'student', '2025-05-21 14:08:04'),
(23, 'chester_boriz_macalintal@dlsl.edu.ph', '$2y$10$xgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdY', 'student', '2025-05-21 14:08:04'),
(24, 'john_rafhael_steven_macasaet@dlsl.edu.ph', '$2y$10$gBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdYx', 'student', '2025-05-21 14:08:04'),
(25, 'alexie_chyle_magbuhat@dlsl.edu.ph', '$2y$10$w2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjU', 'student', '2025-05-21 14:08:04'),
(26, 'john_aaron_manalo@dlsl.edu.ph', '$2y$10$IaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2t', 'student', '2025-05-21 14:08:04'),
(27, 'ian_karvey_manimtim@dlsl.edu.ph', '$2y$10$PdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9o', 'student', '2025-05-21 14:08:04'),
(28, 'isiah_joseph_marquinez@dlsl.edu.ph', '$2y$10$YxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPd', 'student', '2025-05-21 14:08:04'),
(29, 'sebastian_angelo_meer@dlsl.edu.ph', '$2y$10$xgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdY', 'student', '2025-05-21 14:08:04'),
(30, 'wyeth_irish_mendez@dlsl.edu.ph', '$2y$10$gBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdYx', 'student', '2025-05-21 14:08:04'),
(31, 'jan_ernest_pacey_nario@dlsl.edu.ph', '$2y$10$w2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjU', 'student', '2025-05-21 14:08:04'),
(32, 'keith_justin_nario@dlsl.edu.ph', '$2y$10$IaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2t', 'student', '2025-05-21 14:08:04'),
(33, 'michael_josh_panuela@dlsl.edu.ph', '$2y$10$PdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9o', 'student', '2025-05-21 14:08:04'),
(34, 'jane_allyson_paray@dlsl.edu.ph', '$2y$10$YxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPd', 'student', '2025-05-21 14:08:04'),
(35, 'daniel_luis_sahagun@dlsl.edu.ph', '$2y$10$xgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdY', 'student', '2025-05-21 14:08:04'),
(36, 'thomas_alexandre_siman@dlsl.edu.ph', '$2y$10$gBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9oPdYx', 'student', '2025-05-21 14:08:04'),
(37, 'xyrelle_dominique_talens@dlsl.edu.ph', '$2y$10$w2tIaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjU', 'student', '2025-05-21 14:08:04'),
(38, 'jhon_paulo_tenorio@dlsl.edu.ph', '$2y$10$IaS9oPdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2t', 'student', '2025-05-21 14:08:04'),
(39, 'kyan_prince_torres@dlsl.edu.ph', '$2y$10$PdYxgBZuOW8cN7C6R49VZ5Kk3LbqT5CeHJpQvXhFmzOjUw2tIaS9o', 'student', '2025-05-21 14:08:04');

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
  ADD KEY `QType_ID` (`type_index`),
  ADD KEY `section_index` (`section_index`);

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
  ADD KEY `fk1` (`user_index`),
  ADD KEY `fk_student_program` (`section_index`),
  ADD KEY `fk_student_guardian` (`guardian_index`);

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
  MODIFY `answer_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `choice_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2444;

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
  MODIFY `section_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `form_snapshots`
--
ALTER TABLE `form_snapshots`
  MODIFY `snapshot_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `grid_answers`
--
ALTER TABLE `grid_answers`
  MODIFY `grid_answer_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guardians`
--
ALTER TABLE `guardians`
  MODIFY `guardian_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `main_questions`
--
ALTER TABLE `main_questions`
  MODIFY `main_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=430;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `question_types`
--
ALTER TABLE `question_types`
  MODIFY `type_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `responses`
--
ALTER TABLE `responses`
  MODIFY `response_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `sub_questions`
--
ALTER TABLE `sub_questions`
  MODIFY `sub_question_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
  ADD CONSTRAINT `grid_answers_ibfk_1` FOREIGN KEY (`response_index`) REFERENCES `responses` (`response_index`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `fk1` FOREIGN KEY (`user_index`) REFERENCES `users` (`user_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_student_guardian` FOREIGN KEY (`guardian_index`) REFERENCES `guardians` (`guardian_index`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_student_section` FOREIGN KEY (`section_index`) REFERENCES `sections` (`section_index`) ON DELETE CASCADE;

--
-- Constraints for table `sub_questions`
--
ALTER TABLE `sub_questions`
  ADD CONSTRAINT `sub_questions_ibfk_1` FOREIGN KEY (`main_question_index`) REFERENCES `main_questions` (`main_question_index`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
