-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2022 at 03:37 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `weblab`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--
CREATE DATABASE weblab;
USE weblab;
CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `price` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `imgurl` text NOT NULL DEFAULT 'https://i.pinimg.com/236x/6f/21/47/6f2147c359f1ab834f00b4cbac5d6817.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(6) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;
COMMIT;

--
-- Dumping data for table `users`
--

INSERT INTO `products` ( `name`, `category`, `price`, `imgurl`) VALUES
('Avatar', 'movie', 123, './images/avatar.jpg'),
('Shawshank Redemption', 'movie', 132, './images/shawshank.jpg'),
('Forrest Gump', 'movie', 23, './images/forrest.jpg'),
('The Godfather', 'movie', 34, './images/godfather.jpg'),
('Lord of the rings', 'movie', 1234, './images/lotr.jpg'),
('Inception', 'movie', 3, './images/inception.jpg'),
('Les Miserable', 'book', 412, './images/les.jpg'),
('Saving Private Ryan', 'movie', 4123, './images/ryan.jpg'),
('Hamlet', 'book', 421, './images/hamlet.jpg'),
('The adventure of Huckleberry Finn', 'book', 421, './images/finn.jpg'),
('One thousand and one nights', 'book', 134, './images/one.jpg'),
('Interstellar', 'movie', 5312, './images/inter.jpg');


INSERT INTO `users` (`username`, `password`, `role`) VALUES
('admin@gmail.com', 'Admindeptrai123', 'admin'),
('user@gmail.com', 'Userdepgai123', 'user');
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
