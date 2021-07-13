-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2021 at 03:37 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rentall`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id_booking` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `date` date NOT NULL,
  `rent_start` date NOT NULL,
  `rent_end` date NOT NULL,
  `total_fee` decimal(10,0) NOT NULL,
  `payment_type` enum('DANA','OVO','SPAY','MBANKING') NOT NULL,
  `notes` varchar(50) NOT NULL,
  `reviewed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id_booking`, `id_user`, `id_product`, `date`, `rent_start`, `rent_end`, `total_fee`, `payment_type`, `notes`, `reviewed`) VALUES
(9, 2, 1, '2021-06-15', '2021-06-30', '2021-07-30', '200', 'MBANKING', 'booked', 0),
(10, 1, 1, '2021-06-16', '2021-06-17', '2021-07-17', '200', 'MBANKING', 'pending', 0),
(11, 39, 1, '2021-06-23', '2021-06-26', '2022-03-23', '1800', 'OVO', 'booked', 0),
(12, 39, 1, '2021-06-23', '2021-06-26', '2022-03-23', '1800', 'OVO', 'booked', 0),
(13, 39, 1, '2021-06-23', '2021-06-26', '2022-03-23', '1800', 'OVO', 'booked', 0),
(14, 40, 1, '2021-06-23', '2021-06-23', '2021-08-22', '400', 'MBANKING', 'booked', 0),
(15, 41, 1, '2021-06-23', '2021-07-01', '2021-12-28', '1200', 'OVO', 'booked', 0),
(16, 40, 2, '2021-06-24', '2021-06-24', '2021-12-21', '126', 'MBANKING', 'booked', 0),
(17, 40, 2, '2021-06-24', '2021-06-24', '2022-03-21', '189', 'MBANKING', 'booked', 0),
(18, 40, 3, '2021-06-24', '2021-06-24', '2021-08-05', '72', 'MBANKING', 'booked', 0),
(19, 40, 4, '2021-06-24', '2021-06-30', '2021-08-18', '56', 'MBANKING', 'booked', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id_products` int(11) NOT NULL,
  `brand` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `image` varchar(100) NOT NULL,
  `type` enum('car','bike') NOT NULL,
  `details` text NOT NULL,
  `location` varchar(50) NOT NULL,
  `rental_type` enum('daily','weekly','monthly') NOT NULL,
  `price` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id_products`, `brand`, `name`, `image`, `type`, `details`, `location`, `rental_type`, `price`) VALUES
(1, 'tesla', 'model 3', 'tesla.jpg;', 'car', 'Model 3 comes with the option of dual motor all-wheel drive, 20” Überturbine Wheels and Performance Brakes and lowered suspension for total control, in all weather conditions. And a carbon fiber spoiler improves stability at high speeds, all allowing Model 3 to accelerate from 0-100 km/h* in as little as 3.3 seconds.', 'karawang', 'monthly', 200),
(2, 'citroen', 'cit', 'citroen_0.png;citroen_1.png;citroen_2.png', 'car', 'lorem ipsum dolor sit amet', 'jakarta', 'monthly', 21),
(3, 'kawasaki', 'klx 150', 'klx1.jpg;klx2.jpg', 'bike', 'lorem ipsum dolor sit amet lecture elit', 'jakarta', 'weekly', 12),
(4, 'honda', 'beat', 'beat.jpg;beat2.jpg', 'bike', 'lorem ipsum dolor sit amet elit lactobacillus elit emit emit ', 'batam', 'weekly', 8);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id_booking` int(11) NOT NULL,
  `review` varchar(150) NOT NULL,
  `rate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id_booking`, `review`, `rate`) VALUES
(9, 'good service', 3),
(10, 'good sir when og', 3),
(14, 'mobil nyaman guys', 5),
(16, 'good sir comfortable', 3),
(17, 'nyamaaaaaaaaaan', 5),
(19, 'comfortable bike', 5);

-- --------------------------------------------------------

--
-- Table structure for table `spec`
--

CREATE TABLE `spec` (
  `id_products` int(11) NOT NULL,
  `Color` varchar(20) NOT NULL,
  `Seat` int(11) NOT NULL,
  `Gear Box` varchar(20) NOT NULL,
  `Motor` varchar(30) NOT NULL,
  `Speed(0-100)` varchar(20) NOT NULL,
  `Top Speed` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `spec`
--

INSERT INTO `spec` (`id_products`, `Color`, `Seat`, `Gear Box`, `Motor`, `Speed(0-100)`, `Top Speed`) VALUES
(1, 'red', 4, 'Automatic', 'motor v2.1', '3.2 sec', '120mph'),
(2, 'red', 4, 'Automatic', 'motor v2.1', '5sec', '100mph'),
(3, 'green', 2, 'manual', 'motor v2.1', '3.2 sec', '180mph'),
(4, 'red', 2, 'automatic', 'v1.02', '5sec', '100mph');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `name`, `email`, `password`) VALUES
(1, 'febri', 'febri9299@gmail.com', 'batam'),
(2, 'erwin', 'erwin@gmail.com', 'erwin'),
(3, 'feri', 'feri@gmail.com', 'agustus'),
(31, '', 'shashas@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(32, '', 'shasas@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(33, '', 'shasa@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(34, 'ses', 'ses@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(35, 'sisa', 'sisa@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(36, '1223', '1223', '8cb2237d0679ca88db6464eac60da96345513964'),
(37, 'sdsd', 'sdsd', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(38, 'shima', 'shima@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(39, 'shiii', 'shiii@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(40, 'shiii', 'shiii2@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b'),
(41, 'kimi', 'kurami@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`),
  ADD KEY `id_account` (`id_user`),
  ADD KEY `id_field` (`id_product`),
  ADD KEY `id_field_2` (`id_product`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_products`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD UNIQUE KEY `id_booking_2` (`id_booking`),
  ADD KEY `id_booking` (`id_booking`);

--
-- Indexes for table `spec`
--
ALTER TABLE `spec`
  ADD UNIQUE KEY `id_products_2` (`id_products`),
  ADD KEY `id_products` (`id_products`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_booking` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id_products` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_products`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`id_booking`) REFERENCES `booking` (`id_booking`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `spec`
--
ALTER TABLE `spec`
  ADD CONSTRAINT `spec_ibfk_1` FOREIGN KEY (`id_products`) REFERENCES `product` (`id_products`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
