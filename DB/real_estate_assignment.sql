-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 20, 2024 at 12:26 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `real_estate_assignment`
--

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image` varchar(150) NOT NULL,
  `ID` int(11) NOT NULL,
  `unit_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image`, `ID`, `unit_ID`) VALUES
('https://github.com/Younisonly/Real-Eastate/blob/main/minimalist-kitchen-interior-design.jpg', 1, 1),
('https://github.com/Younisonly/Real-Eastate/blob/main/minimalist-kitchen-interior-design.jpg', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `ID` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `annual_price` int(11) DEFAULT NULL,
  `price_currency` varchar(10) DEFAULT NULL,
  `rooms` int(11) DEFAULT NULL,
  `halls` int(11) DEFAULT NULL,
  `parking_spot` int(11) DEFAULT NULL,
  `features` text DEFAULT NULL,
  `location_description` text DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `latitude` decimal(8,6) DEFAULT NULL,
  `renting_conditions` text DEFAULT NULL,
  `bathroom` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`ID`, `type`, `annual_price`, `price_currency`, `rooms`, `halls`, `parking_spot`, `features`, `location_description`, `longitude`, `latitude`, `renting_conditions`, `bathroom`) VALUES
(1, 'بيت', 20000, 'ر.س', 6, 3, 1, 'تصميم الشقة:\n شقة بتصميم فريد يجمع بين الطابع الكلاسيكي واللمسات الحديثة. \nالمساحة الكبيرة و النوافذ الكبيرة تخلق اجواء مشرقة وودية.\n المطبخ مجهز باحدث التقنيات والاجهزة،مع مساحة لتناول الطعام.\n تجهيزات فاخرة:\n الارضيات الرخامية والتشطيبات الفاخرةتضفي لمسة من الفخامة.\n نظام تدفئة وتبريد مركزي   ', 'يقع هذا المنزل الفاخر في حي هادئ ومأهول بالأشجار، على مقربة من المدارس والمتنزهات ومراكز التسوق.\n', '44.206670', '15.354720', 'الإيجار والتأمين:\nالمبلغ السنوي للإيجار: 20000 ريال سعودي.\nتأمين مسترد قابل للتجديد بقيمة [10000] ريال سعودي.\nالمدة الزمنية:\nبداية العقد: 1/1/2024\nنهاية العقد: 1/1/2025\nالمسؤوليات المالية:\nالمستأجر مسؤول عن سداد جميع الفواتير المتعلقة بالمرافق (كهرباء، ماء، غاز).\nالاستخدام السكني:\nالشقة مخصصة للاستخدام السكني فقط ويجب استخدامها بطريقة قانونية وآمنة.\nالصيانة والإصلاحات:\nالشركة مسؤولة عن الصيانة الأساسية، والمستأجر مسؤول عن الصيانة اليومية وأية إصلاحات تكون ناتجة عن سوء استخدامه.\n\nشروط الإلغاء:\nيمكن لأي طرف إلغاء العقد بإشعار مسبق بـ شهر، ويتم تحديد غرامة5000 ر.س في حالة إلغاء المستأجر قبل انتهاء فترة العقد.\n\nالصفة السكنية:\nيسمح بالسكن لعدد 6 أشخاص فقط.\nتأكيد بالكتاب:\nيجب على الطرفين تأكيد العقد بتوقيعهما بصفة رسمية.\n', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
