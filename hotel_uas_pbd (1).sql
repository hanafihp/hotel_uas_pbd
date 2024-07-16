-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2024 at 09:48 AM
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
-- Database: `hotel_uas_pbd`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllRooms` ()   BEGIN
	SELECT kamar.id, detail_kamar.kamar_id AS detail_kamar_id, kamar.nama, fasilitas_kamar.id AS detail_fasilitas_kamar_id, detail_kamar.fasilitas_kamar_id, fasilitas_kamar.nama, kamar.harga 
FROM kamar 
JOIN detail_kamar ON 
kamar.id = detail_kamar.kamar_id 
JOIN fasilitas_kamar ON 
detail_kamar.fasilitas_kamar_id = fasilitas_kamar.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPriceMinimum` (IN `MinPrice` INT, IN `MaxPrice` INT)   BEGIN
    DECLARE harga INT;
  
    SELECT harga FROM kamar WHERE harga >= MinPrice AND harga < MaxPrice;
    
    IF harga >= 99000 AND harga < 100000 THEN
        SELECT * FROM kamar WHERE harga >= MinPrice AND harga < MaxPrice;
    ELSEIF harga >= 100000 AND harga < 150000 THEN
        SELECT * FROM kamar WHERE harga >= MinPrice AND harga < MaxPrice;
     ELSEIF harga >= 100000 AND harga < 200000 THEN
        SELECT * FROM kamar WHERE harga >= MinPrice AND harga < MaxPrice;
    ELSE
        SELECT * FROM kamar WHERE harga >= MinPrice AND harga < MaxPrice;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getRoomCount` () RETURNS INT(11)  BEGIN
    DECLARE jumlah_kamar INT;
    SELECT COUNT(*) INTO jumlah_kamar FROM kamar;
    RETURN jumlah_kamar;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getRoomPrice` (`room_id` INT, `nights` INT) RETURNS INT(11)  BEGIN
    DECLARE harga_kamar INT;
    SELECT harga INTO harga_kamar FROM kamar WHERE id = room_id;
    RETURN harga_kamar * nights;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_kamar`
--

CREATE TABLE `detail_kamar` (
  `id` int(20) NOT NULL,
  `kamar_id` int(20) DEFAULT NULL,
  `fasilitas_kamar_id` int(20) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_kamar`
--

INSERT INTO `detail_kamar` (`id`, `kamar_id`, `fasilitas_kamar_id`, `created_at`, `updated_at`) VALUES
(2, 8, 1, '2024-06-24', '2024-06-24'),
(3, 8, 6, '2024-06-24', '2024-06-24'),
(4, 7, 1, '2024-06-24', '2024-06-24'),
(5, 7, 5, '2024-06-24', '2024-06-24'),
(6, 7, 6, '2024-06-24', '2024-06-24'),
(8, 10, 5, '2024-06-24', '2024-06-24');

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas_hotel`
--

CREATE TABLE `fasilitas_hotel` (
  `id` int(20) NOT NULL,
  `nama` text DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fasilitas_hotel`
--

INSERT INTO `fasilitas_hotel` (`id`, `nama`, `created_at`, `updated_at`, `deskripsi`) VALUES
(6, 'Kolam Renang', '2024-06-24', '2024-06-24', 'Fasilitas kolam renang dengan pemandangan indah.'),
(7, 'Restoran', '2024-06-24', '2024-06-24', 'Restoran dengan menu internasional dan lokal.'),
(8, 'Gym', '2024-06-24', '2024-06-24', 'Gym lengkap dengan peralatan modern.'),
(9, 'Layanan Spa', '2024-06-24', '2024-06-24', 'Spa dengan layanan pijat dan perawatan tubuh.'),
(10, 'Parkir', '2024-06-24', '2024-06-24', 'Area parkir yang luas dan aman.');

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas_kamar`
--

CREATE TABLE `fasilitas_kamar` (
  `id` int(20) NOT NULL,
  `nama` text DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fasilitas_kamar`
--

INSERT INTO `fasilitas_kamar` (`id`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'Kamar Mandi', '2024-06-22', '2024-06-24'),
(4, 'Shower', '2024-06-24', '2024-06-24'),
(5, 'TV', '2024-06-24', '2024-06-24'),
(6, 'AC', '2024-06-24', '2024-06-24');

--
-- Triggers `fasilitas_kamar`
--
DELIMITER $$
CREATE TRIGGER `beforeDeleteRoomFacilitiesOnDetailRoom` BEFORE DELETE ON `fasilitas_kamar` FOR EACH ROW BEGIN
DELETE FROM detail_kamar WHERE fasilitas_kamar_id = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `horizontal_view`
-- (See below for the actual view)
--
CREATE TABLE `horizontal_view` (
`room_id` int(20)
,`room_name` varchar(255)
,`room_price` int(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id` int(20) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `path_gambar` text DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `harga` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id`, `nama`, `path_gambar`, `created_at`, `updated_at`, `harga`) VALUES
(7, 'Deluxe Double Bed', 'assets/rooms/110050220-room-deluxe-twin.jpg', '2024-06-23', '2024-06-24', 120000),
(8, 'Superior Single Bed', 'assets/rooms/374187636-room-superior.jpg', '2024-06-24', '2024-06-24', 99000),
(9, 'Superior Double Bed', 'assets/rooms/414799338-room-superior-twin.jpg', '2024-06-24', '2024-06-24', 110000),
(10, 'Deluxe Single Bed', 'assets/rooms/1039846972-room-deluxe.jpg', '2024-06-24', '2024-06-24', 229000),
(11, 'Suite Room', NULL, NULL, NULL, 150000);

--
-- Triggers `kamar`
--
DELIMITER $$
CREATE TRIGGER `beforeUpdateRoomPrice` BEFORE UPDATE ON `kamar` FOR EACH ROW BEGIN
IF NEW.harga < 60000 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Harga Kamar per Malam tidak boleh kurang dari Rp. 60,000';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservasi`
--

CREATE TABLE `reservasi` (
  `id` int(20) NOT NULL,
  `user_id` int(20) DEFAULT NULL,
  `nama_users` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `kamar_id` int(20) DEFAULT NULL,
  `nama_kamar` varchar(255) DEFAULT NULL,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservasi`
--

INSERT INTO `reservasi` (`id`, `user_id`, `nama_users`, `email`, `kamar_id`, `nama_kamar`, `check_in`, `check_out`) VALUES
(1, 1, 'Marviz Axl', 'axl@contoh.com', 8, 'Superior Single Bed', '2024-07-01', '2024-07-03'),
(2, 2, 'Developer Tester', 'developertester@gmail.com', 7, 'Deluxe Double Bed', '2024-07-05', '2024-07-08'),
(3, 3, 'Gillas GT', 'gillasgt@gmail.com', 10, 'Deluxe Single Bed', '2024-07-02', '2024-07-04'),
(4, 4, 'Yudha', 'yudha@gmail.com', 7, 'Deluxe Double Bed', '2024-07-10', '2024-07-12'),
(5, 6, 'Ryo Agata', 'ryoagta@gmail.com', 10, 'Deluxe Single Bed', '2024-07-15', '2024-07-17');

--
-- Triggers `reservasi`
--
DELIMITER $$
CREATE TRIGGER `beforeInsertReservation` BEFORE INSERT ON `reservasi` FOR EACH ROW BEGIN
IF new.check_out <= new.check_in THEN 
SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Tanggal Check Harus Lebih dari Tanggal Check-in";
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteHistoryReservation` AFTER DELETE ON `reservasi` FOR EACH ROW BEGIN
INSERT reservasi_history(reservasi_id, nama_user, email, nama_kamar, check_in, check_out, aksi) VALUES(OLD.id, OLD.nama_users, OLD.email, OLD.nama_kamar, OLD.check_in, OLD.check_out, "Hapus");
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertHistoryReservation` AFTER INSERT ON `reservasi` FOR EACH ROW BEGIN
INSERT reservasi_history(reservasi_id, nama_user, email, nama_kamar, check_in, check_out, aksi) VALUES(NEW.id, NEW.nama_users, NEW.email, NEW.nama_kamar, NEW.check_in, NEW.check_out, "Tambah");
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateHistoryReservation` AFTER UPDATE ON `reservasi` FOR EACH ROW BEGIN
INSERT reservasi_history(reservasi_id, nama_user, email, nama_kamar, check_in, check_out, aksi) VALUES(NEW.id, NEW.nama_users, NEW.email, NEW.nama_kamar, NEW.check_in, NEW.check_out, "Update");
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservasi_history`
--

CREATE TABLE `reservasi_history` (
  `id` int(11) NOT NULL,
  `reservasi_id` int(11) NOT NULL,
  `nama_user` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nama_kamar` varchar(255) DEFAULT NULL,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL,
  `aksi` char(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(20) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '2024-06-07', '2024-06-07'),
(2, 'Staff', '2024-06-07', '2024-06-07'),
(3, 'User', '2024-06-18', '2024-06-18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(20) NOT NULL,
  `roles_id` int(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nama_depan` varchar(255) DEFAULT NULL,
  `nama_belakang` varchar(255) DEFAULT NULL,
  `nama_lengkap` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `roles_id`, `email`, `nama_depan`, `nama_belakang`, `nama_lengkap`, `password`, `created_at`, `updated_at`) VALUES
(1, 1, 'axl@contoh.com', 'Marviz', 'Axl', 'Marviz Axl', '12345', '2024-06-18', '2024-06-18'),
(2, 1, 'developerTester@gmail.com', 'Developer', 'Tester', 'Developer Tester', 'developerTester12345', '2024-06-18', '2024-06-18'),
(3, 2, 'gillasGT@gmail.com', NULL, NULL, NULL, 'gillasgt12', '2024-06-18', '2024-06-18'),
(4, 2, 'yudha@gmail.com', NULL, NULL, NULL, 'yudha12345', '2024-06-18', '2024-06-18'),
(6, 2, 'ryoagta@gmail.com', 'Ryo', 'Agata', 'Ryo Agata', 'Ryo12345', '2024-06-24', '2024-06-24');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vertical_view`
-- (See below for the actual view)
--
CREATE TABLE `vertical_view` (
`attribute` varchar(10)
,`value` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_inside_view`
-- (See below for the actual view)
--
CREATE TABLE `view_inside_view` (
`id` int(20)
,`nama` varchar(255)
,`harga` int(20)
);

-- --------------------------------------------------------

--
-- Structure for view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS SELECT `kamar`.`id` AS `room_id`, `kamar`.`nama` AS `room_name`, `kamar`.`harga` AS `room_price` FROM `kamar` ;

-- --------------------------------------------------------

--
-- Structure for view `vertical_view`
--
DROP TABLE IF EXISTS `vertical_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_view`  AS SELECT 'Room ID' AS `attribute`, `kamar`.`id` AS `value` FROM `kamar`union all select 'Room Name' AS `attribute`,`kamar`.`nama` AS `value` from `kamar` union all select 'Room Price' AS `attribute`,`kamar`.`harga` AS `value` from `kamar`  ;

-- --------------------------------------------------------

--
-- Structure for view `view_inside_view`
--
DROP TABLE IF EXISTS `view_inside_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_inside_view`  AS SELECT `kamar`.`id` AS `id`, `kamar`.`nama` AS `nama`, `kamar`.`harga` AS `harga` FROM `kamar` WHERE `kamar`.`harga` >= 100000WITH CASCADEDCHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_kamar`
--
ALTER TABLE `detail_kamar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kamar_id` (`kamar_id`),
  ADD KEY `fasilitas_kamar_id` (`fasilitas_kamar_id`);

--
-- Indexes for table `fasilitas_hotel`
--
ALTER TABLE `fasilitas_hotel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fasilitas_kamar`
--
ALTER TABLE `fasilitas_kamar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_room_price` (`harga`,`nama`),
  ADD KEY `idx_created_updated` (`created_at`,`updated_at`),
  ADD KEY `idx_path_gambar_nama` (`path_gambar`(100),`nama`);

--
-- Indexes for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `kamar_id` (`kamar_id`);

--
-- Indexes for table `reservasi_history`
--
ALTER TABLE `reservasi_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservasi_id` (`reservasi_id`) USING BTREE;

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_id` (`roles_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_kamar`
--
ALTER TABLE `detail_kamar`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `fasilitas_hotel`
--
ALTER TABLE `fasilitas_hotel`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `fasilitas_kamar`
--
ALTER TABLE `fasilitas_kamar`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `reservasi`
--
ALTER TABLE `reservasi`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reservasi_history`
--
ALTER TABLE `reservasi_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_kamar`
--
ALTER TABLE `detail_kamar`
  ADD CONSTRAINT `detail_kamar_ibfk_1` FOREIGN KEY (`kamar_id`) REFERENCES `kamar` (`id`),
  ADD CONSTRAINT `detail_kamar_ibfk_2` FOREIGN KEY (`fasilitas_kamar_id`) REFERENCES `fasilitas_kamar` (`id`);

--
-- Constraints for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD CONSTRAINT `reservasi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reservasi_ibfk_2` FOREIGN KEY (`kamar_id`) REFERENCES `kamar` (`id`);

--
-- Constraints for table `reservasi_history`
--
ALTER TABLE `reservasi_history`
  ADD CONSTRAINT `reservasi_history_ibfk_1` FOREIGN KEY (`reservasi_id`) REFERENCES `reservasi` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
