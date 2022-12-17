-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2022 at 10:31 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

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
-- Table structure for table `bill_has_goods`
--

CREATE TABLE `bill_has_goods` (
  `Export_Bill_ID` int(11) NOT NULL,
  `Goods_ID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Total_cost` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill_has_goods`
--

INSERT INTO `bill_has_goods` (`Export_Bill_ID`, `Goods_ID`, `Quantity`, `Total_cost`) VALUES
(120, 1, 28, 420000),
(121, 1, 12, 180000),
(121, 8, 1, 11690000);

--
-- Triggers `bill_has_goods`
--
DELIMITER $$
CREATE TRIGGER `bill_has_goods_negative_quantity` AFTER INSERT ON `bill_has_goods` FOR EACH ROW IF NEW.Quantity < 0 THEN
	SIGNAL sqlstate '45000' set message_text =  "Error: Trying to insert or update a \tnegative value";
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `store_export_trigger` BEFORE INSERT ON `bill_has_goods` FOR EACH ROW IF EXISTS(SELECT store.Goods_ID FROM store, export_bill, employee WHERE store.Goods_ID = NEW.Goods_ID AND export_bill.Cashier_ID = employee.ID AND store.Supermarket_Scode = employee.Supermarket_Scode) THEN 
 UPDATE store, export_bill, employee SET store.Quantity = 	store.Quantity - NEW.Quantity
 WHERE store.Goods_ID = NEW.Goods_ID AND export_bill.Cashier_ID = employee.ID AND
store.Supermarket_Scode = employee.Supermarket_Scode;
ELSE
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Goods is not available';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart_list`
--

CREATE TABLE `cart_list` (
  `ID` int(11) NOT NULL,
  `GoodsID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `DateTimeOrdered` datetime DEFAULT NULL,
  `Export_bill_ID` int(11) NOT NULL,
  `Supermarket_Scode_in` int(11) NOT NULL,
  `Customer_ID` int(11) NOT NULL,
  `Total_cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart_list`
--

INSERT INTO `cart_list` (`ID`, `GoodsID`, `Quantity`, `Status`, `DateTimeOrdered`, `Export_bill_ID`, `Supermarket_Scode_in`, `Customer_ID`, `Total_cost`) VALUES
(69, 1, 12, 1, '2022-12-16 06:52:19', 121, 70000, 2, 180000),
(70, 8, 1, 1, '2022-12-16 06:52:59', 121, 70000, 2, 11690000),
(71, 1, 12, 1, '2022-12-16 06:58:16', 120, 70000, 2, 420000),
(72, 1, 12, 0, '2022-12-16 07:00:12', 119, 70000, 2, 15000);

--
-- Triggers `cart_list`
--
DELIMITER $$
CREATE TRIGGER `quantity_cart_list` BEFORE INSERT ON `cart_list` FOR EACH ROW IF NEW.Quantity < 0 THEN
	SIGNAL sqlstate '45000' set message_text =  "Error: Trying to insert or update a \tnegative value";
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `total_cost_cart_list` BEFORE INSERT ON `cart_list` FOR EACH ROW SET NEW.Total_cost = NEW.Quantity * calculate_total_cost(NEW.GoodsID)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cashier`
--

CREATE TABLE `cashier` (
  `ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cashier`
--

INSERT INTO `cashier` (`ID`) VALUES
(111111111),
(123456789),
(134827512),
(213456421),
(228888999),
(235651232),
(238511292),
(334444555),
(723152681),
(871234123),
(898834123);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `ID` int(11) NOT NULL,
  `First_name` varchar(45) DEFAULT NULL,
  `Last_name` varchar(45) DEFAULT NULL,
  `Gender` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Phone_number` varchar(45) DEFAULT NULL,
  `Date_of_birth` datetime DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`ID`, `First_name`, `Last_name`, `Gender`, `Address`, `Phone_number`, `Date_of_birth`, `Type`) VALUES
(1, 'Duc', 'Pham', 'Male', '121 Lu Gia, Ho Chi Minh', '0912939987', '2002-04-03 00:00:00', 'VIP'),
(2, 'Vinh', 'Luu', 'Male', '32 Ba Hat, Ho Chi Minh', '0938227817', '2002-08-26 00:00:00', 'Gold'),
(3, 'Tai', 'Thai', 'Male', '123 Nguyen Xuan Khoat, Ho Chi Minh', '0987172817', '2002-12-31 00:00:00', 'Silver'),
(4, 'Chuan', 'Nguyen', 'Male', '268 Ly Thuong Kiet, Ho Chi Minh', '0912311838', '2002-11-09 00:00:00', 'Normal'),
(5, 'Thanh', 'Pham', 'Male', '151 Hoang Dieu, Ha Noi', '0902123717', '2002-11-23 00:00:00', 'Silver'),
(6, 'Bao', 'Ho', 'Female', '139 Phan Dinh Phung, Ha Noi', '0903214212', '1999-12-24 00:00:00', 'VIP'),
(7, 'Hoa', 'Nguyen', 'Female', '167 Yet Kieu, Da Nang', '0902781232', '1998-07-08 00:00:00', 'Gold');

-- --------------------------------------------------------

--
-- Table structure for table `customer_card`
--

CREATE TABLE `customer_card` (
  `Customer_ID` int(11) NOT NULL,
  `Issue_date` date DEFAULT NULL,
  `Saving_point` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_card`
--

INSERT INTO `customer_card` (`Customer_ID`, `Issue_date`, `Saving_point`) VALUES
(1, '2022-01-01', 100),
(2, '2022-04-05', 200),
(3, '2020-12-12', 500),
(4, '2018-12-06', 1100),
(5, '2019-02-28', 600),
(6, '2021-01-31', 300),
(7, '2022-02-27', 200);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `ID` int(11) NOT NULL,
  `Phone_number` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `First_name` varchar(45) DEFAULT NULL,
  `Last_name` varchar(45) DEFAULT NULL,
  `Start_date` date DEFAULT NULL,
  `Salary` int(11) DEFAULT NULL,
  `Role` varchar(45) DEFAULT NULL,
  `Gender` varchar(45) DEFAULT NULL,
  `Date_of_birth` date DEFAULT NULL,
  `Supermarket_Scode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`ID`, `Phone_number`, `Address`, `First_name`, `Last_name`, `Start_date`, `Salary`, `Role`, `Gender`, `Date_of_birth`, `Supermarket_Scode`) VALUES
(111111111, '0902738123', '123 Nguyen Dinh Chieu', 'Loi', 'Nguyen', '2010-01-03', 5000000, 'Cashier', 'Male', '1998-04-15', 70000),
(123456789, '0902134234', '182 Ba Hat Phuong 9 Quan 10', 'Thuan', 'Le', '2013-09-01', 8000000, 'Manager', 'Male', '1989-01-15', 70000),
(134827512, '0902049391', '356 Hai Ba Trung, Hoan Kiem', 'Thuy', 'Luu', '2013-01-01', 4000000, 'Cashier', 'Female', '2000-12-15', 15000),
(213456421, '0902456712', '135 Le Duc Tho, Son Tra', 'Tu', 'Ha', '2018-06-19', 5000000, 'Cashier', 'Female', '1995-06-15', 50506),
(228888999, '0904231222', '156 Ly Thuong Kiet', 'Thanh', 'Le', '2014-02-27', 4000000, 'Cashier', 'Male', '1999-03-03', 70000),
(235651232, '0903201031', '145 Le Dinh Ly, Thanh Khe', 'Nam', 'Nguyen', '2020-01-12', 5000000, 'Cashier', 'Male', '1998-12-12', 50506),
(238511292, '0908212341', '154 Cao Thang, Hai Chau ', 'Manh', 'Nguyen', '2019-12-12', 8000000, 'Manager', 'Male', '1990-09-01', 50506),
(334444555, '0903671671', '131 Nguyen Tri Phuong', 'Nu', 'Hoang', '2018-08-18', 4000000, 'Cashier', 'Female', '1995-12-31', 70000),
(723152681, '0901012421', '145 Nha Chung, Hoan Kiem', 'Quang', 'Ho', '2000-09-19', 4000000, 'Cashier', 'Male', '1989-12-12', 15000),
(871234123, '0907123456', '156 Ton Duc Thang, Lien Chieu', 'Tran', 'Vuong', '2018-09-17', 5000000, 'Cashier', 'Female', '1997-08-12', 50506),
(898834123, '0908172871', '321 Tue Tinh, Dong Da', 'Trang', 'Luu', '2019-12-23', 8000000, 'Manager', 'Female', '1997-08-12', 15000);

-- --------------------------------------------------------

--
-- Table structure for table `export_bill`
--

CREATE TABLE `export_bill` (
  `ID` int(11) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Cashier_ID` int(11) DEFAULT NULL,
  `Customer_ID` int(11) DEFAULT NULL,
  `Saving_point_policy_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `export_bill`
--

INSERT INTO `export_bill` (`ID`, `Date`, `Name`, `Cashier_ID`, `Customer_ID`, `Saving_point_policy_ID`) VALUES
(120, '2022-12-16 06:58:28', 'Bill', 123456789, 2, 134),
(121, '2022-12-16 06:53:43', 'Bill', 123456789, 2, 134);

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE `goods` (
  `ID` int(11) NOT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `imgurl` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `goods`
--

INSERT INTO `goods` (`ID`, `Brand`, `Name`, `Price`, `Type`, `Description`, `imgurl`) VALUES
(1, 'PepsiCo', 'Pepsi Can', 15000, 'Foods and Beverages', '1 can of Pepsi contains 320ml of pepsi', 'images\\1.png'),
(2, 'Coca-Cola', 'Coca-cola', 10600, 'Foods and Beverages', '1 can of Coca-Cola contains 320ml.', 'images\\2.png'),
(3, 'BreadTalk', 'Sweet Bread', 15000, 'Foods and Beverages', '1 loaf of bread', 'images\\3.png'),
(4, 'Vietgap', 'Broccoli', 45000, 'Foods And Beverages', '300g of Broccoli', 'images\\4.png'),
(5, 'Vietgap', 'Kale', 46500, 'Foods And Beverages', '500g of Kale', 'images\\5.png'),
(6, 'Acer', 'Acer Nitro 5 Gaming AN515', 19600000, 'Electronics', 'This laptop contains 8GB RAM, AMD Ryzen 5 chip.', 'images\\6.png'),
(7, 'Apple', 'MacBook Air M1', 29290000, 'Electronics', 'This laptop contains 7-core GPU, SSD 256GB, chip M', 'images\\7.png'),
(8, 'Apple', 'Iphone 11', 11690000, 'Electronics', 'This iphone contains chip Apple 13 Bionic; memory ', 'images\\8.png'),
(9, 'Decathlon', 'Tennis Racket TR160', 825000, 'Sports', 'Tennis Rackets for Adults', 'images\\9.png'),
(10, 'Addidas', 'Ultra 4DFWD', 6000000, 'Sports', 'Running shoes', 'images\\10.png'),
(11, 'Uniqlo', 'Disney Long Sleeve Sweatshirt', 686000, 'Clothes', 'Sweatshirt', 'images\\11.png'),
(12, 'Uniqlo', 'Peanuts Long Sleeve Sweatshirt', 784000, 'Clothes', 'Sweatshirt', 'images\\12.png'),
(13, 'Uniqlo', 'AIRism Cotton Crew Neck Oversized T-Shirt', 391000, 'Clothes', 'T-Shirt', 'images\\13.png'),
(14, 'Decathlon', 'Riverside 500 Bicycle', 9995000, 'Sports', 'Bicycles', 'images\\14.png'),
(15, 'Dove', 'Dove Men+ Care Body Wash for Men Skin Care', 635789, 'Health and Personal Care', 'This bottle contains 532.324 ml of solution.', 'images\\15.png'),
(16, 'Berroca', 'Berroca C effervescent tablet', 63000, 'Heath and Personal Care', 'This tube contains 10 effervescent tablets', 'images\\16.png'),
(17, 'Colgate', 'Colgate Electric Toothbrush Sonic 360 Charcoal', 359000, 'Heath and Personal Care', 'This electric toothbrush is for adults, use batter', 'images\\17.png'),
(18, 'Decathlon', 'Football ball France', 135000, 'Sports', 'This ball is very stable and durable, drawn inspir', 'images\\18.png'),
(19, 'Decathlon', 'Hiking Bag NH100 10L', 63000, 'Sports', 'This bag is designed for every age and for hiking ', 'images\\19.png'),
(20, 'YaMe', 'T-Shirt Round Neck Anubis Ver11', 227000, 'Clothes', 'This bag is designed comfortability, durability. A', 'images\\20.png'),
(21, 'Canifa', 'Shealth Dress for Woman', 299000, 'Clothes', 'This dress is made of cotton, is tight and great f', 'images\\21.png'),
(22, 'Canifa', 'Pajama for Women 6LS22W010', 449000, 'Clothes', 'This pajama is made for comfortable use at home an', 'images\\22.png'),
(23, 'Kanen', 'Kanen K6 Headphone', 480000, 'Electronics', 'This headphone uses bluetooth technology but can a', 'images\\23.png'),
(24, 'Orihiro Japan', 'Shark Fin Tablet Squalene Orihiro', 570000, 'Health and Personal Care', 'This bottle contains 360 capsules, and ingested by', 'images\\24.png'),
(25, 'Pharmekal', 'Omega-3 Fish Oil', 175000, 'Health and Personal Care', 'This bottle contains 100 softgels, contains 3 type', 'images\\25.png');

-- --------------------------------------------------------

--
-- Table structure for table `import_bill`
--

CREATE TABLE `import_bill` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Supplier_ID` int(11) DEFAULT NULL,
  `Supermarket_Scode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `import_bill`
--

INSERT INTO `import_bill` (`ID`, `Name`, `Date`, `Supplier_ID`, `Supermarket_Scode`) VALUES
(22010211, 'Import_Bill_0102_1', '2022-01-02 00:00:00', 1, 70000);

-- --------------------------------------------------------

--
-- Table structure for table `import_goods`
--

CREATE TABLE `import_goods` (
  `Import_Bill_ID` int(11) NOT NULL,
  `Goods_ID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Total_cost` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `import_goods`
--

INSERT INTO `import_goods` (`Import_Bill_ID`, `Goods_ID`, `Quantity`, `Total_cost`) VALUES
(22010211, 1, 1000, 15000000),
(22010211, 2, 2, 21200),
(22010211, 3, 1000, 15000000),
(22010211, 4, 1000, 45000000),
(22010211, 5, 1000, 46500000),
(22010211, 6, 50, 980000000),
(22010211, 7, 30, 878700000),
(22010211, 8, 50, 584500000),
(22010211, 9, 1000, 825000000),
(22010211, 10, 50, 300000000),
(22010211, 11, 1000, 686000000),
(22010211, 12, 1000, 784000000),
(22010211, 13, 1000, 391000000),
(22010211, 14, 50, 499750000),
(22010211, 15, 1000, 635789000),
(22010211, 16, 1000, 63000000),
(22010211, 17, 1000, 359000000),
(22010211, 18, 1000, 135000000),
(22010211, 19, 1000, 63000000),
(22010211, 20, 1000, 227000000),
(22010211, 21, 1000, 299000000),
(22010211, 22, 1000, 499000000),
(22010211, 23, 1000, 480000000),
(22010211, 24, 1000, 570000000),
(22010211, 25, 1000, 175000000);

--
-- Triggers `import_goods`
--
DELIMITER $$
CREATE TRIGGER `store_import_trigger` BEFORE INSERT ON `import_goods` FOR EACH ROW IF EXISTS(SELECT store.Goods_ID FROM store, import_bill
WHERE store.Goods_ID = NEW.Goods_ID AND import_bill.Supermarket_Scode = store.Supermarket_Scode 
AND NEW.Import_bill_ID = import_bill.ID) THEN 
 UPDATE store, import_bill SET store.Quantity = store.Quantity + NEW.Quantity
WHERE store.Goods_ID = NEW.Goods_ID AND import_bill.Supermarket_Scode = store.Supermarket_Scode AND
NEW.Import_bill_ID = import_bill.ID;
ELSE
 INSERT INTO store(Supermarket_Scode, Goods_ID, Quantity) SELECT import_bill.Supermarket_Scode,
NEW.Goods_ID, NEW.Quantity FROM import_bill WHERE import_bill.ID = NEW.Import_bill.ID;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `ID` int(11) NOT NULL,
  `Scode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `manager`
--

INSERT INTO `manager` (`ID`, `Scode`) VALUES
(898834123, 15000),
(238511292, 50506),
(123456789, 70000);

-- --------------------------------------------------------

--
-- Table structure for table `offer`
--

CREATE TABLE `offer` (
  `Supermarket_Scode` int(11) NOT NULL,
  `Sale_promo_ID` int(11) NOT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `offer`
--

INSERT INTO `offer` (`Supermarket_Scode`, `Sale_promo_ID`, `Start_date`, `End_date`) VALUES
(15000, 15100001, '2022-11-25', '2022-12-27'),
(15000, 15200001, '2022-11-25', '2022-12-27'),
(15000, 15300001, '2022-11-25', '2022-12-27'),
(15000, 15400001, '2022-11-25', '2022-12-27'),
(50506, 50100001, '2022-11-25', '2022-12-27'),
(50506, 50200001, '2022-11-25', '2022-12-27'),
(50506, 50300001, '2022-11-25', '2022-12-27'),
(50506, 50400001, '2022-11-25', '2022-12-27'),
(70000, 70100001, '2022-11-25', '2022-12-27'),
(70000, 70200001, '2022-11-25', '2022-12-27'),
(70000, 70300001, '2022-11-25', '2022-12-27'),
(70000, 70400001, '2022-11-25', '2022-12-27');

-- --------------------------------------------------------

--
-- Table structure for table `sales_promotion`
--

CREATE TABLE `sales_promotion` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales_promotion`
--

INSERT INTO `sales_promotion` (`ID`, `Name`) VALUES
(15100001, 'Ha Noi - Black Friday - VIP member'),
(15200001, 'Ha Noi - Black Friday - Gold member'),
(15300001, 'Ha Noi - Black Friday - Silver member'),
(15400001, 'Ha Noi - Black Friday - Normal member'),
(50100001, 'Da Nang - Black Friday - VIP member'),
(50200001, 'Da Nang - Black Friday - Gold member'),
(50300001, 'Da Nang - Black Friday - Silver member'),
(50400001, 'Da Nang - Black Friday - Normal member'),
(70100001, 'Ho Chi Minh - Black Friday - VIP member'),
(70200001, 'Ho Chi Minh - Black Friday - Gold member'),
(70300001, 'Ho Chi Minh - Black Friday - Silver member'),
(70400001, 'Ho Chi Minh - Black Friday - Normal member');

-- --------------------------------------------------------

--
-- Table structure for table `sales_promotion_condition`
--

CREATE TABLE `sales_promotion_condition` (
  `ID` int(11) NOT NULL,
  `Discount_rate` int(11) DEFAULT NULL,
  `Customer_Type` varchar(45) DEFAULT NULL,
  `Cost_Threshold` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales_promotion_condition`
--

INSERT INTO `sales_promotion_condition` (`ID`, `Discount_rate`, `Customer_Type`, `Cost_Threshold`) VALUES
(15100001, 20, 'VIP', 3000000),
(15200001, 15, 'Gold', 3000000),
(15300001, 10, 'Silver', 3000000),
(15400001, 5, 'Normal', 3000000),
(50100001, 20, 'VIP', 2500000),
(50200001, 15, 'Gold', 2500000),
(50300001, 10, 'Silver', 2500000),
(50400001, 5, 'Normal', 2500000),
(70100001, 20, 'VIP', 4000000),
(70200001, 15, 'Gold', 4000000),
(70300001, 10, 'Silver', 4000000),
(70400001, 5, 'Normal', 4000000);

-- --------------------------------------------------------

--
-- Table structure for table `saving_point_policy`
--

CREATE TABLE `saving_point_policy` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Percentage` int(11) DEFAULT NULL,
  `Start_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `saving_point_policy`
--

INSERT INTO `saving_point_policy` (`ID`, `Name`, `Percentage`, `Start_date`) VALUES
(123, 'VIP Discount', 20, '2022-01-01 00:00:00'),
(134, 'Gold Discount', 10, '2022-01-01 00:00:00'),
(145, 'Silver Discount', 5, '2022-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `Supermarket_Scode` int(11) NOT NULL,
  `Goods_ID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`Supermarket_Scode`, `Goods_ID`, `Quantity`) VALUES
(15000, 1, NULL),
(15000, 2, NULL),
(15000, 3, NULL),
(15000, 4, NULL),
(15000, 5, NULL),
(15000, 6, NULL),
(15000, 7, NULL),
(15000, 8, NULL),
(15000, 9, NULL),
(15000, 10, NULL),
(15000, 11, NULL),
(15000, 12, NULL),
(15000, 13, NULL),
(15000, 14, NULL),
(15000, 15, NULL),
(50506, 1, NULL),
(50506, 2, NULL),
(50506, 3, NULL),
(50506, 4, NULL),
(50506, 5, NULL),
(50506, 6, NULL),
(50506, 7, NULL),
(50506, 8, NULL),
(50506, 9, NULL),
(50506, 10, NULL),
(50506, 11, NULL),
(50506, 12, NULL),
(50506, 13, NULL),
(50506, 14, NULL),
(50506, 15, NULL),
(70000, 1, 900),
(70000, 2, 861),
(70000, 3, 1000),
(70000, 4, 1000),
(70000, 5, 1000),
(70000, 6, 49),
(70000, 7, 29),
(70000, 8, 48),
(70000, 9, 988),
(70000, 10, 50),
(70000, 11, 1000),
(70000, 12, 1000),
(70000, 13, 1000),
(70000, 14, 49),
(70000, 15, 1000),
(70000, 16, 1000),
(70000, 17, 1000),
(70000, 18, 1000),
(70000, 19, 1000),
(70000, 20, 1000),
(70000, 21, 1000),
(70000, 22, 1000),
(70000, 23, 1000),
(70000, 24, 1000),
(70000, 25, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `supermarket`
--

CREATE TABLE `supermarket` (
  `SCode` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Location` varchar(45) DEFAULT NULL,
  `Number_of_employees` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supermarket`
--

INSERT INTO `supermarket` (`SCode`, `Name`, `Location`, `Number_of_employees`) VALUES
(15000, 'Ha Noi Satra', 'Ha Noi', '2000'),
(50506, 'Da Nang co-op', 'Da Nang', '1000'),
(70000, 'Ho Chi Minh Co-op', 'Ho Chi Minh city', '3000');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `ID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Location` varchar(45) DEFAULT NULL,
  `Email_address` varchar(45) DEFAULT NULL,
  `Phone_number` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`ID`, `Name`, `Location`, `Email_address`, `Phone_number`) VALUES
(1, 'Ha Noi Retailers', 'Ha Noi', 'hanoifoods@gmail.com', '0902034712'),
(2, 'Da Nang wholesale', 'Da Nang', 'danangwholesale@gmail.com', '0903765189'),
(3, 'Ho Chi Minh Coop', 'Ho Chi Minh', 'hochiminhcoop@gmail.com', '0903782642'),
(4, 'Ha Noi Electronics', 'Ha Noi', 'hanoielectron@gmail.com', '0902742123'),
(5, 'Da Nang Fresh', 'Da Nang', 'danangfresh@gmail.com', '0903651521'),
(6, 'Ho Chi Minh market', 'Ho Chi Minh', 'hochiminhmart@gmail.com', '0902456128');

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
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin', 'admin'),
(2, 'vinh', 'vinh', 'user'),
(3, 'tai', 'tai', 'Male'),
(4, 'chuan', 'chuan', 'Male'),
(5, 'thanh', 'thanh', 'Male'),
(6, 'bao', 'bao', 'Female'),
(7, 'hoa', 'hoa', 'Female');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill_has_goods`
--
ALTER TABLE `bill_has_goods`
  ADD PRIMARY KEY (`Export_Bill_ID`,`Goods_ID`),
  ADD KEY `Goods_ID` (`Goods_ID`);

--
-- Indexes for table `cart_list`
--
ALTER TABLE `cart_list`
  ADD PRIMARY KEY (`ID`,`GoodsID`,`Export_bill_ID`);

--
-- Indexes for table `cashier`
--
ALTER TABLE `cashier`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `customer_card`
--
ALTER TABLE `customer_card`
  ADD PRIMARY KEY (`Customer_ID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Supermarket_Scode` (`Supermarket_Scode`);

--
-- Indexes for table `export_bill`
--
ALTER TABLE `export_bill`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Cashier_ID` (`Cashier_ID`),
  ADD KEY `Customer_ID` (`Customer_ID`),
  ADD KEY `Saving_point_policy_ID` (`Saving_point_policy_ID`);

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `import_bill`
--
ALTER TABLE `import_bill`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Supermarket_Scode` (`Supermarket_Scode`),
  ADD KEY `Supplier_ID` (`Supplier_ID`);

--
-- Indexes for table `import_goods`
--
ALTER TABLE `import_goods`
  ADD PRIMARY KEY (`Import_Bill_ID`,`Goods_ID`),
  ADD KEY `Goods_ID` (`Goods_ID`);

--
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Scode` (`Scode`);

--
-- Indexes for table `offer`
--
ALTER TABLE `offer`
  ADD PRIMARY KEY (`Supermarket_Scode`,`Sale_promo_ID`),
  ADD KEY `Sale_promo_ID` (`Sale_promo_ID`);

--
-- Indexes for table `sales_promotion`
--
ALTER TABLE `sales_promotion`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `sales_promotion_condition`
--
ALTER TABLE `sales_promotion_condition`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `saving_point_policy`
--
ALTER TABLE `saving_point_policy`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`Supermarket_Scode`,`Goods_ID`),
  ADD KEY `Goods_ID` (`Goods_ID`);

--
-- Indexes for table `supermarket`
--
ALTER TABLE `supermarket`
  ADD PRIMARY KEY (`SCode`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`ID`);

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
-- AUTO_INCREMENT for table `bill_has_goods`
--
ALTER TABLE `bill_has_goods`
  MODIFY `Export_Bill_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- AUTO_INCREMENT for table `cart_list`
--
ALTER TABLE `cart_list`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `export_bill`
--
ALTER TABLE `export_bill`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- AUTO_INCREMENT for table `goods`
--
ALTER TABLE `goods`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill_has_goods`
--
ALTER TABLE `bill_has_goods`
  ADD CONSTRAINT `bill_has_goods_ibfk_1` FOREIGN KEY (`Export_Bill_ID`) REFERENCES `export_bill` (`ID`),
  ADD CONSTRAINT `bill_has_goods_ibfk_2` FOREIGN KEY (`Goods_ID`) REFERENCES `goods` (`ID`);

--
-- Constraints for table `cashier`
--
ALTER TABLE `cashier`
  ADD CONSTRAINT `cashier_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `employee` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `customer_card`
--
ALTER TABLE `customer_card`
  ADD CONSTRAINT `customer_card_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`ID`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Supermarket_Scode`) REFERENCES `supermarket` (`SCode`);

--
-- Constraints for table `export_bill`
--
ALTER TABLE `export_bill`
  ADD CONSTRAINT `export_bill_ibfk_1` FOREIGN KEY (`Cashier_ID`) REFERENCES `cashier` (`ID`),
  ADD CONSTRAINT `export_bill_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`ID`),
  ADD CONSTRAINT `export_bill_ibfk_3` FOREIGN KEY (`Saving_point_policy_ID`) REFERENCES `saving_point_policy` (`ID`);

--
-- Constraints for table `import_bill`
--
ALTER TABLE `import_bill`
  ADD CONSTRAINT `import_bill_ibfk_1` FOREIGN KEY (`Supermarket_Scode`) REFERENCES `supermarket` (`SCode`),
  ADD CONSTRAINT `import_bill_ibfk_2` FOREIGN KEY (`Supplier_ID`) REFERENCES `supplier` (`ID`);

--
-- Constraints for table `import_goods`
--
ALTER TABLE `import_goods`
  ADD CONSTRAINT `import_goods_ibfk_1` FOREIGN KEY (`Goods_ID`) REFERENCES `goods` (`ID`),
  ADD CONSTRAINT `import_goods_ibfk_2` FOREIGN KEY (`Import_Bill_ID`) REFERENCES `import_bill` (`ID`);

--
-- Constraints for table `manager`
--
ALTER TABLE `manager`
  ADD CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `employee` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `manager_ibfk_2` FOREIGN KEY (`Scode`) REFERENCES `supermarket` (`SCode`);

--
-- Constraints for table `offer`
--
ALTER TABLE `offer`
  ADD CONSTRAINT `offer_ibfk_1` FOREIGN KEY (`Sale_promo_ID`) REFERENCES `sales_promotion` (`ID`),
  ADD CONSTRAINT `offer_ibfk_2` FOREIGN KEY (`Supermarket_Scode`) REFERENCES `supermarket` (`SCode`);

--
-- Constraints for table `sales_promotion_condition`
--
ALTER TABLE `sales_promotion_condition`
  ADD CONSTRAINT `Sales_promotion_condition_ID` FOREIGN KEY (`ID`) REFERENCES `sales_promotion` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `store_ibfk_1` FOREIGN KEY (`Goods_ID`) REFERENCES `goods` (`ID`),
  ADD CONSTRAINT `store_ibfk_2` FOREIGN KEY (`Supermarket_Scode`) REFERENCES `supermarket` (`SCode`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
store
