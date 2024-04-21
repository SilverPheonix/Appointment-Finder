-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2024 at 12:08 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `appointment-finder`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `a_id` int(11) NOT NULL,
  `a_title` varchar(45) DEFAULT NULL,
  `a_place` varchar(45) DEFAULT NULL,
  `a_exdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`a_id`, `a_title`, `a_place`, `a_exdate`) VALUES
(1, 'Mathe Tutorium', 'FH Technikum', '2024-05-30'),
(2, 'Klassentreffen', 'Prater', '2024-06-03'),
(3, 'Bubble Tea', 'Mariahilferstraße', '2024-04-27'),
(4, 'Bowling', 'Millennium City', '2024-03-29');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `c_id` int(11) NOT NULL,
  `c_content` varchar(125) DEFAULT NULL,
  `c_appointment` int(11) NOT NULL,
  `c_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`c_id`, `c_content`, `c_appointment`, `c_user`) VALUES
(11, 'Wo würden wir dann essen?', 1, 2),
(12, 'Kommt auch unser Klassenvorstand?', 2, 7),
(13, 'Treffen wir uns bei der U-Bahn?', 2, 7),
(14, 'Nice!', 3, 6),
(15, 'miau', 2, 8),
(16, 'miau', 4, 8);

-- --------------------------------------------------------

--
-- Table structure for table `option`
--

CREATE TABLE `option` (
  `o_id` int(11) NOT NULL,
  `o_date` date DEFAULT NULL,
  `o_from` time DEFAULT NULL,
  `o_to` time DEFAULT NULL,
  `o_appointment` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `option`
--

INSERT INTO `option` (`o_id`, `o_date`, `o_from`, `o_to`, `o_appointment`) VALUES
(1, '2024-06-01', '16:00:00', '18:00:00', 1),
(2, '2024-06-01', '15:00:00', '17:00:00', 1),
(3, '2024-06-01', '09:00:00', '11:00:00', 1),
(4, '2024-06-02', '13:00:00', '15:00:00', 1),
(5, '2024-06-07', '13:30:00', '19:00:00', 2),
(6, '2024-06-08', '13:30:00', '19:00:00', 2),
(7, '2024-06-09', '13:30:00', '19:00:00', 2),
(8, '2024-04-29', '13:30:00', '14:30:00', 3),
(9, '2024-04-29', '17:30:00', '18:30:00', 3),
(10, '2024-05-01', '13:30:00', '14:30:00', 3),
(11, '2024-05-02', '13:30:00', '14:30:00', 3),
(12, '2024-03-29', '17:30:00', '18:30:00', 4),
(13, '2024-03-29', '13:30:00', '14:30:00', 4),
(14, '2024-04-29', '13:30:00', '14:30:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `selected`
--

CREATE TABLE `selected` (
  `s_id` int(11) NOT NULL,
  `s_option` int(11) NOT NULL,
  `s_appointment` int(11) NOT NULL,
  `s_value` tinyint(4) DEFAULT NULL,
  `s_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `selected`
--

INSERT INTO `selected` (`s_id`, `s_option`, `s_appointment`, `s_value`, `s_user`) VALUES
(57, 1, 1, 1, 1),
(58, 2, 1, 0, 1),
(59, 3, 1, 1, 1),
(60, 4, 1, 0, 1),
(61, 1, 1, 1, 2),
(62, 2, 1, 1, 2),
(63, 3, 1, 1, 2),
(64, 4, 1, 0, 2),
(65, 5, 2, 1, 3),
(66, 6, 2, 0, 3),
(67, 7, 2, 0, 3),
(68, 5, 2, 1, 4),
(69, 6, 2, 1, 4),
(70, 7, 2, 1, 4),
(71, 8, 3, 0, 5),
(72, 9, 3, 0, 5),
(73, 10, 3, 1, 5),
(74, 11, 3, 1, 5),
(75, 8, 3, 0, 6),
(76, 9, 3, 1, 6),
(77, 10, 3, 0, 6),
(78, 11, 3, 1, 6),
(79, 5, 2, 0, 8),
(80, 6, 2, 1, 8),
(81, 7, 2, 0, 8),
(82, 12, 4, 0, 7),
(83, 13, 4, 1, 7),
(84, 14, 4, 0, 7);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `u_id` int(11) NOT NULL,
  `u_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`u_id`, `u_name`) VALUES
(1, 'Emma'),
(2, 'Marie'),
(3, 'Stefan'),
(4, 'Ava'),
(5, 'Fiona'),
(6, 'Karola'),
(7, 'Toni'),
(8, 'mina');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`a_id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`c_id`,`c_appointment`),
  ADD KEY `fk_Comment_Appointment1_idx` (`c_appointment`),
  ADD KEY `fk_comment_user1_idx` (`c_user`);

--
-- Indexes for table `option`
--
ALTER TABLE `option`
  ADD PRIMARY KEY (`o_id`,`o_appointment`),
  ADD KEY `fk_Options_Appointment_idx` (`o_appointment`);

--
-- Indexes for table `selected`
--
ALTER TABLE `selected`
  ADD PRIMARY KEY (`s_id`,`s_option`,`s_appointment`),
  ADD KEY `fk_Selected_Option1_idx` (`s_option`,`s_appointment`),
  ADD KEY `fk_selected_user1_idx` (`s_user`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`u_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `option`
--
ALTER TABLE `option`
  MODIFY `o_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `selected`
--
ALTER TABLE `selected`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `fk_Comment_Appointment1` FOREIGN KEY (`c_appointment`) REFERENCES `appointment` (`a_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comment_user1` FOREIGN KEY (`c_user`) REFERENCES `user` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `option`
--
ALTER TABLE `option`
  ADD CONSTRAINT `fk_Options_Appointment` FOREIGN KEY (`o_appointment`) REFERENCES `appointment` (`a_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `selected`
--
ALTER TABLE `selected`
  ADD CONSTRAINT `fk_Selected_Option1` FOREIGN KEY (`s_option`,`s_appointment`) REFERENCES `option` (`o_id`, `o_appointment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_selected_user1` FOREIGN KEY (`s_user`) REFERENCES `user` (`u_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
