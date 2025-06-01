-- Create counselor_programs table for many-to-many relationship
CREATE TABLE IF NOT EXISTS `counselor_programs` (
  `counselor_program_index` int(11) NOT NULL AUTO_INCREMENT,
  `counselor_index` int(11) NOT NULL,
  `program_index` int(11) NOT NULL,
  PRIMARY KEY (`counselor_program_index`),
  UNIQUE KEY `unique_counselor_program` (`counselor_index`, `program_index`),
  FOREIGN KEY (`counselor_index`) REFERENCES `counselors` (`counselor_index`) ON DELETE CASCADE,
  FOREIGN KEY (`program_index`) REFERENCES `programs` (`program_index`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Remove counselor_index from programs table if it exists
ALTER TABLE `programs` DROP COLUMN IF EXISTS `counselor_index`; 