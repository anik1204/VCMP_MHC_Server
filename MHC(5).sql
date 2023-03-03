-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 12, 2017 at 10:18 PM
-- Server version: 5.5.55-0+deb8u1
-- PHP Version: 5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `MHC`
--

-- --------------------------------------------------------

--
-- Table structure for table `clans`
--

CREATE TABLE `clans` (
  `Name` text,
  `Tag` text,
  `Car` int(11) DEFAULT NULL,
  `Kills` int(11) DEFAULT NULL,
  `Deaths` int(11) DEFAULT NULL,
  `Cash` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clans`
--

INSERT INTO `clans` (`Name`, `Tag`, `Car`, `Kills`, `Deaths`, `Cash`) VALUES
('[DS]', '[DS]', 0, 14, 2, 0),
('[VU]', '[VU]', 0, 0, 0, 0),
('[ON]', '[ON]', 0, 0, 0, 0),
('[CF]', '[CF]', 0, 0, 0, 0),
('[OSK]', '[OSK]', 0, 0, 0, 0),
('[MK]', '[MK]', 0, 0, 0, 0),
('[AF]', '[AF]', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `clan_leaders`
--

CREATE TABLE `clan_leaders` (
  `Tag` text,
  `Leaders` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clan_leaders`
--

INSERT INTO `clan_leaders` (`Tag`, `Leaders`) VALUES
('[DS]', '[DS]Anik');

-- --------------------------------------------------------

--
-- Table structure for table `clan_members`
--

CREATE TABLE `clan_members` (
  `Tag` text,
  `Members` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invalidnicks`
--

CREATE TABLE `invalidnicks` (
  `Name` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invalidnicks`
--

INSERT INTO `invalidnicks` (`Name`) VALUES
('none');

-- --------------------------------------------------------

--
-- Table structure for table `mhc_accounts`
--

CREATE TABLE `mhc_accounts` (
  `ID` int(11) DEFAULT NULL,
  `Name` text,
  `NameLower` text,
  `IP` varchar(255) DEFAULT NULL,
  `UID` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Level` int(11) DEFAULT NULL,
  `Kills` int(11) DEFAULT NULL,
  `Deaths` int(11) DEFAULT NULL,
  `Cash` int(11) DEFAULT NULL,
  `Bank` int(11) DEFAULT NULL,
  `AutoLogin` tinyint(1) DEFAULT '1',
  `LoggedIn` tinyint(1) DEFAULT '0',
  `DateRegistered` varchar(255) DEFAULT NULL,
  `LastJoin` int(11) DEFAULT NULL,
  `nogoto` varchar(4) DEFAULT 'off',
  `PASS` varchar(255) DEFAULT NULL,
  `LogTime` int(255) NOT NULL,
  `Clan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mhc_accounts`
--

INSERT INTO `mhc_accounts` (`ID`, `Name`, `NameLower`, `IP`, `UID`, `Password`, `Level`, `Kills`, `Deaths`, `Cash`, `Bank`, `AutoLogin`, `LoggedIn`, `DateRegistered`, `LastJoin`, `nogoto`, `PASS`, `LogTime`, `Clan`) VALUES
(1, 'Anik', 'anik', '0.0.0.0', 'b39d5ae73ca6dd6d0ed4f9226e032e7acb558c32', '3434B09B087F0402F8FE0DD4EC7D8D34139503B0A034605DD57045C8F66F8EE3', 10, 0, 0, 0, 0, 1, 1, '9:38:8 PM, 5/12/2017 (May/Friday/2017)', 1494607084, 'off', ' ', 438, 'none'),
(2, 'K.D.M', 'k.d.m', '0.0.0.0', '99223160cd071eec85bbefe2eb9d1c09b0dbd2a9', '7F9B109648D1825D11CDF375A851B51BD69EC753DB8C0AF50C84209C3782E66B', 0, 0, 0, 0, 0, 1, 1, '10:5:24 PM, 5/12/2017 (May/Friday/2017)', 1494607095, 'off', ' ', 163, 'K.D.');

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `rowid` int(11) NOT NULL,
  `Interior` text NOT NULL,
  `Model` text NOT NULL,
  `ID` text NOT NULL,
  `Robcash` text NOT NULL,
  `Name` text NOT NULL,
  `Label` text NOT NULL,
  `Cost` text NOT NULL,
  `Owner` text NOT NULL,
  `Shared` text NOT NULL,
  `Pos` text NOT NULL,
  `Locked` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`rowid`, `Interior`, `Model`, `ID`, `Robcash`, `Name`, `Label`, `Cost`, `Owner`, `Shared`, `Pos`, `Locked`) VALUES
(0, '8', '406', '0', '', 'Anik\'s Mansion', 'None', '90000000', 'Anik.', 'None', '-378.677 -545.05 17.283', 0),
(1, '20', '406', '1', '', 'Starfish Estate #1', 'None', '9000000', 'Anik', 'None', '-227.1 -425.124 11.289', 0),
(2, '8', '406', '2', '', 'Starfish House #1', 'None', '4000000', 'None', 'None', '-249.587 -328.255 10.1871', 0),
(3, '8', '406', '3', '', 'Starfish house #2', 'None', '5000000', 'None', 'None', '-368.688 -425.384 9.82905', 0),
(4, '19', '406', '4', '', 'Starfish House #3', 'None', '4000000', 'None', 'None', '-568.011 -540.239 10.6139', 0),
(5, '17', '406', '5', '', 'Starfish Estate #2', 'None', '10000000', 'None', 'None', '-575.369 -460.078 11.2869', 0),
(6, '17', '406', '6', '', 'Starfish Estate #3', 'None', '8000000', 'None', 'None', '-635.963 -514.283 10.4088', 0),
(7, '3', '406', '7', '', 'Starfish House #4', 'None', '5000000', 'None', 'None', '-633.446 -305.446 12.053', 0),
(8, '17', '406', '8', '', 'Starfish House #5', 'None', '4000000', 'None', 'None', '-526.09 -300.843 10.801', 0),
(9, '4', '406', '9', '', 'Vice Point House #1', 'None', '2000000', 'None', 'None', '217.537 -257.612 11.6799', 0),
(10, '9', '406', '10', '', 'Vice Point House #2', 'None', '2000000', 'None', 'None', '233.188 -225.76 11.8356', 0),
(11, '9', '406', '11', '', 'Vice Point House #3', 'None', '2000000', 'None', 'None', '249.823 -190.49 11.8356', 0),
(12, '9', '406', '12', '', 'Vice Point House #4', 'None', '2000000', 'None', 'None', '266.838 -155.334 11.8353', 0),
(13, '10', '406', '13', '', 'Vice Point House #5', 'None', '5000000', 'None', 'None', '312.839 -23.8823 11.4942', 0),
(14, '10', '406', '14', '', 'Vice Point House #6', 'None', '5000000', 'None', 'None', '317.225 5.28072 10.9718', 0),
(15, '10', '406', '15', '', 'Vice Point House #7', 'None', '5000000', 'None', 'None', '276.629 9.3033 11.0712', 0),
(16, '10', '406', '16', '', 'Vice Point House #8', 'None', '5000000', 'None', 'None', '267.829 46.9573 10.848', 0),
(17, '16', '406', '17', '', 'Vice Point House #9', 'None', '3000000', 'None', 'None', '292.579 -5.21216 11.5608', 0),
(18, '16', '406', '18', '', 'Vice Point House #10', 'None', '3000000', 'None', 'None', '300.85 16.9277 11.7104', 0),
(19, '14', '406', '19', '', 'Vice Point House #11', 'None', '3000000', 'None', 'None', '285.806 31.0233 11.7104', 0),
(20, '4', '406', '20', '', 'Vice Point Estate #1', 'None', '7000000', 'None', 'None', '444.033 529.881 11.6372', 0),
(21, '8', '406', '21', '', 'Vice Point Mansion #1', 'None', '8000000', 'None', 'None', '428.258 607.082 12.714', 0),
(22, 'None', '406', '22', '', 'Little Haiti House #1', 'None', '1000000', 'None', 'None', '-962.651 143.721 9.39548', 0),
(23, '16', '406', '23', '', 'Little Havana House #1', 'None', '3000000', 'None', 'None', '-1132.15 -355.194 15.0355', 0),
(24, '10', '406', '24', '', 'Little Havana House #2', 'None', '2000000', 'None', 'None', '-1164.52 -357.013 10.9136', 0),
(25, '2', '406', '25', '', 'Little Havana House #3', 'None', '2000000', 'None', 'None', '-1196.77 -372.019 10.907', 0),
(26, '2', '406', '26', '', 'Little Havana House #4', 'None', '2000000', 'None', 'None', '-1217.42 -394.274 10.8927', 0),
(27, '10', '406', '27', '', 'Little Havana House #5', 'None', '2000000', 'None', 'None', '-1191.43 -503.404 10.7981', 0),
(28, '10', '406', '28', '', 'Little Havana House #6', 'None', '2000000', 'None', 'None', '-1142.42 -508.119 10.9887', 0),
(29, '10', '406', '29', '', 'Little Havana House #7', 'None', '2000000', 'None', 'None', '-1105.53 -471.819 10.6386', 0),
(30, '10', '406', '30', '', 'Little Havana House #8', 'None', '2000000', 'None', 'None', '-1116.78 -389.558 10.7722', 0),
(31, '16', '406', '31', '', 'Little Havana House #9', 'None', '1500000', 'None', 'None', '-1193.13 -392.581 10.8042', 0),
(32, '18', '406', '32', '', 'Little Havana House #10', 'None', '1500000', 'None', 'None', '-1214.5 -414.316 11.71', 0),
(33, '16', '406', '33', '', 'Little Havana House #11', 'None', '1500000', 'None', 'None', '-1213.4 -434.616 11.71', 0),
(34, '16', '406', '34', '', 'Little Havana House #12', 'None', '1500000', 'None', 'None', '-1183.8 -447.28 11.71', 0),
(35, '16', '406', '35', '', 'Little Havana House #13', 'None', '1500000', 'None', 'None', '-1207.16 -476.739 11.71', 0),
(36, '10', '406', '36', '', 'Little Havana House #14', 'None', '2000000', 'None', 'None', '-1180.64 -475.656 10.8885', 0),
(37, '10', '406', '37', '', 'Little Havana House #15', 'None', '2000000', 'None', 'None', '-1212.7 -463.365 10.8196', 0),
(38, '2', '406', '38', '', 'Little Havana House #16', 'None', '1500000', 'None', 'None', '-1160.89 -515.097 11.7102', 0),
(39, '16', '406', '39', '', 'Little Havana House #17', 'None', '1500000', 'None', 'None', '-1141.77 -485.012 11.71', 0),
(40, '16', '406', '40', '', 'Little Havana House #18', 'None', '1500000', 'None', 'None', '-1111.38 -451.658 10.4393', 0),
(41, '2', '406', '41', '', 'Little Havana House #19', 'None', '1500000', 'None', 'None', '-1117.4 -423.858 11.5151', 0),
(42, '9', '406', '42', '', 'Vice Port Estates #1', 'None', '3000000', 'None', 'None', '-801.845 -1201.91 11.1012', 0),
(43, '3', '406', '43', '', 'Vice Port Estates #2', 'None', '3000000', 'None', 'None', '-809.227 -1180.43 11.1045', 0),
(44, '9', '406', '44', '', 'Vice Port Estates #3', 'None', '3000000', 'None', 'None', '-816.239 -1161.94 11.1021', 0),
(45, '9', '406', '45', '', 'Vice Port Estates #4', 'None', '3000000', 'None', 'None', '-819.819 -1143.94 11.1048', 0),
(46, '9', '406', '46', '', 'Vice Port Estates #5', 'None', '3000000', 'None', 'None', '-831.52 -1108.69 11.1067', 0),
(47, '9', '406', '47', '', 'Vice Port Estates #6', 'None', '3000000', 'None', 'None', '-839.803 -1073.87 11.1012', 0),
(48, '8', '406', '48', '', 'Vice Point Estates #10', 'None', '1100000', 'None', 'None', '342.624 -61.701 11.7481', 0),
(49, '8', '406', '49', '', 'Vice Point Estates #11', 'None', '1100000', 'None', 'None', '333.364 -110.203 11.7481', 0),
(50, '8', '406', '50', '', 'Vice Point Estates #12', 'None', '1100000', 'None', 'None', '313.057 -159.054 11.7481', 0),
(51, '1', '406', '51', '', 'Vice Point Estates #22', 'None', '4000000', 'None', 'None', '480.342 146.807 11.2381', 0),
(52, '1', '406', '52', '', 'Vice Point Estates #23', 'None', '4000000', 'None', 'None', '478.276 191.663 11.3901', 0),
(53, '1', '406', '53', '', 'Vice Point Estates #24', 'None', '4000000', 'None', 'None', '427.624 219.761 11.9791', 0),
(54, '1', '406', '54', '', 'Vice Point Estates #25', 'None', '4000000', 'None', 'None', '416.756 186.65 11.9791', 0),
(55, '1', '406', '55', '', 'Vice Point Estates #26', 'None', '4000000', 'None', 'None', '439.253 122.507 11.2381', 0),
(56, '1', '406', '56', '', 'Vice Point Estates #27', 'None', '4000000', 'None', 'None', '460.388 108.052 11.2381', 0),
(57, '4', '406', '57', '', 'Vice Point Motel', 'None', '4000000', 'None', 'None', '313.026 356.974 13.2167', 0),
(58, '3', '406', '58', '', 'Washington Beach Estates #1', 'None', '4000000', 'None', 'None', '17.9594 -1330.3 10.4633', 0),
(59, '10', '406', '59', '', 'Little Haiti House #45', 'None', '800000', 'None', 'None', '-994.007 -17.4023 10.7243', 0),
(60, '11', '406', '60', '', 'Little Haiti House #46', 'None', '300000', 'None', 'None', '-969.965 4.31794 10.86', 0),
(61, '12', '406', '61', '', 'Little Haiti House #47', 'None', '300000', 'None', 'None', '-968.325 -6.75545 10.9323', 0),
(62, '14', '406', '62', '', 'Little Haiti House #48', 'None', '300000', 'None', 'None', '-970.448 -22.3075 10.7482', 0),
(63, '13', '406', '63', '', 'Little Haiti House #49', 'None', '300000', 'None', 'None', '-970.958 -40.0113 10.8337', 0),
(64, '14', '406', '64', '', 'Little Haiti House #50', 'None', '300000', 'None', 'None', '-971.121 -56.0633 10.8397', 0),
(65, '16', '406', '65', '', 'Little Haiti House #51', 'None', '300000', 'None', 'None', '-970.189 -72.1809 10.8486', 0),
(66, '13', '406', '66', '', 'Little Haiti House #52', 'None', '300000', 'None', 'None', '-969.505 -90.2285 10.8216', 0),
(67, '15', '406', '67', '', 'Little Haiti House #53', 'None', '300000', 'None', 'None', '-970.031 -105.739 11.5131', 0),
(68, '15', '406', '68', '', 'Little Haiti House #54', 'None', '300000', 'None', 'None', '-970.429 -124.89 11.3613', 0),
(69, '16', '406', '69', '', 'Little Haiti House #55', 'None', '300000', 'None', 'None', '-970.44 -141.665 11.003', 0),
(70, '13', '406', '70', '', 'Little Haiti House #56', 'None', '300000', 'None', 'None', '-969.897 -159.678 10.8848', 0),
(71, '15', '406', '71', '', 'Little Haiti House #57', 'None', '300000', 'None', 'None', '-970.291 -175.825 11.5131', 0),
(72, '15', '406', '72', '', 'Little Haiti House #58', 'None', '300000', 'None', 'None', '-970.565 -194.024 11.2134', 0),
(73, '12', '406', '73', '', 'Little Haiti House #59', 'None', '300000', 'None', 'None', '-973.387 -208.39 10.8561', 0),
(74, '15', '406', '74', '', 'Little Haiti House #60', 'None', '300000', 'None', 'None', '-972.061 -225.664 10.8622', 0),
(75, '13', '406', '75', '', 'Little Haiti House #61', 'None', '300000', 'None', 'None', '-972.342 -243.04 10.7824', 0),
(76, '10', '406', '76', '', 'Little Haiti House #62', 'None', '800000', 'None', 'None', '-995.74 -237.994 10.852', 0),
(77, '13', '406', '77', '', 'Little Haiti House #63', 'None', '300000', 'None', 'None', '-999.965 -221.02 10.8028', 0),
(78, '11', '406', '78', '', 'Little Haiti House #64', 'None', '300000', 'None', 'None', '-1001.14 -209.405 11.3124', 0),
(79, '12', '406', '79', '', 'Little Haiti House #65', 'None', '300000', 'None', 'None', '-1001.92 -201.102 10.9933', 0),
(80, '15', '406', '80', '', 'Little Haiti House #66', 'None', '300000', 'None', 'None', '-999.798 -188.199 10.9779', 0),
(81, '13', '406', '81', '', 'Little Haiti House #67', 'None', '300000', 'None', 'None', '-999.194 -172.096 11.0029', 0),
(82, '12', '406', '82', '', 'Little Haiti House #68', 'None', '300000', 'None', 'None', '-1001.8 -149.146 10.9543', 0),
(83, '12', '406', '83', '', 'Little Haiti House #69', 'None', '200000', 'None', 'None', '-996.03 -93.008 10.923', 0),
(84, '13', '406', '84', '', 'Little Haiti House #70', 'None', '200000', 'None', 'None', '-995.655 -77.782 10.7286', 0),
(85, '14', '406', '85', '', 'Little Haiti House #71', 'None', '200000', 'None', 'None', '-995.5 -65.7125 10.8637', 0),
(86, '11', '406', '86', '', 'Little Haiti House #72', 'None', '200000', 'None', 'None', '-1051.24 -55.8012 11.3124', 0),
(87, '12', '406', '87', '', 'Little Haiti House #73', 'None', '200000', 'None', 'None', '-1050.24 -63.3321 11.0027', 0),
(88, '14', '406', '88', '', 'Little Haiti House #74', 'None', '200000', 'None', 'None', '-1053.66 -76.8106 11.0525', 0),
(89, '13', '406', '89', '', 'Little Haiti House #75', 'None', '200000', 'None', 'None', '-1052.96 -92.0011 11.0496', 0),
(90, '14', '406', '90', '', 'Little Haiti House #76', 'None', '200000', 'None', 'None', '-1038.3 -111.354 10.8946', 0),
(91, '16', '406', '91', '', 'Little Haiti House #77', 'None', '200000', 'None', 'None', '-1025.6 -110.092 10.9951', 0),
(92, '13', '406', '92', '', 'Little Haiti House #78', 'None', '200000', 'None', 'None', '-1011.26 -110.717 11.0138', 0),
(93, '5', '406', '93', '', 'Little Haiti House #75', 'None', '100000', 'None', 'None', '-951.547 134.777 9.31581', 0),
(94, '5', '406', '94', '', 'Little Haiti House #76', 'None', '100000', 'None', 'None', '-977.1 152.193 9.18326', 0),
(95, '5', '406', '95', '', 'Little Haiti House #77', 'None', '100000', 'None', 'None', '-983.504 152.575 9.2193', 0),
(96, '5', '406', '96', '', 'Little Haiti House #78', 'None', '100000', 'None', 'None', '-990.588 152.786 9.26451', 0),
(97, '5', '406', '97', '', 'Little Haiti House #79', 'None', '100000', 'None', 'None', '-998.204 142.678 9.26793', 0),
(98, '5', '406', '98', '', 'Little Haiti House #80', 'None', '100000', 'None', 'None', '-981.559 132.579 9.26517', 0),
(99, '5', '406', '99', '', 'Little Haiti House #81', 'None', '100000', 'None', 'None', '-995.319 123.45 9.28463', 0),
(100, '5', '406', '100', '', 'Little Haiti House #82', 'None', '100000', 'None', 'None', '-994.376 103.983 9.39288', 0),
(101, '5', '406', '101', '', 'Little Haiti House #83', 'None', '100000', 'None', 'None', '-981.396 103.072 9.34658', 0),
(102, '5', '406', '102', '', 'Little Haiti House #84', 'None', '100000', 'None', 'None', '-964.682 105.172 9.25655', 0),
(103, '5', '406', '103', '', 'Little Haiti House #85', 'None', '100000', 'None', 'None', '-964.552 111.892 9.23131', 0),
(104, '5', '406', '104', '', 'Little Haiti House #86', 'None', '100000', 'None', 'None', '-964.907 120.651 9.23511', 0),
(105, '5', '406', '105', '', 'Little Haiti House #87', 'None', '100000', 'None', 'None', '-965.256 126.958 9.23791', 0),
(106, '5', '406', '106', '', 'Little Haiti House #88', 'None', '100000', 'None', 'None', '-979.512 88.2534 10.066', 0),
(107, '5', '406', '107', '', 'Little Haiti House #89', 'None', '100000', 'None', 'None', '-985.833 88.393 10.099', 0),
(108, '5', '406', '108', '', 'Little Haiti House #90', 'None', '100000', 'None', 'None', '-992.852 88.0579 10.1306', 0),
(109, '5', '406', '109', '', 'Little Haiti House #91', 'None', '100000', 'None', 'None', '-1005.99 88.2107 10.1508', 0),
(110, '5', '406', '110', '', 'Little Haiti House #92', 'None', '100000', 'None', 'None', '-967.298 88.5946 10.1431', 0),
(111, '5', '406', '111', '', 'Little Haiti House #93', 'None', '100000', 'None', 'None', '-960.795 88.9843 10.1625', 0),
(112, '5', '406', '112', '', 'Little Haiti House #94', 'None', '100000', 'None', 'None', '-954.862 88.6989 10.1942', 0),
(113, '5', '406', '113', '', 'Little Haiti House #95', 'None', '100000', 'None', 'None', '-949.161 87.8014 10.2356', 0),
(114, '4', '406', '114', '', 'Starfish House #17', 'None', '5000000', 'None', 'None', '-507.367 -424.793 13.4369', 0),
(115, '17', '406', '115', '', 'Starfish House #44', 'None', '500000', 'None', 'None', '-352.839 -277.446 12.3765', 0),
(116, '1', '406', '116', '', 'Vice Point Apartment', 'None', '100000', 'None', 'None', '571.373 16.2387 52.7511', 0),
(117, '1', '406', '117', '', 'Vice Point Apartment', 'None', '100000', 'None', 'None', '569.026 18.776 52.7511', 0),
(118, '1', '406', '118', '', 'Vice Point Apartment', 'None', '100000', 'None', 'None', '566.54 15.8495 52.7511', 0),
(119, '1', '406', '119', '', 'Vice Point Apartment', 'None', '100000', 'None', 'None', '564.144 18.4924 52.7511', 0),
(120, '1', '406', '120', '', 'Vice Point Apartment', 'None', '100000', 'None', 'None', '561.57 15.813 52.7511', 0),
(121, '1', '406', '121', '', 'Vice Point Apartment', 'None', '100000', 'None', 'None', '559.379 19.1127 52.7511', 0),
(122, '17', '406', '122', '', 'Beach House', 'None', '1000000', 'None', 'None', '-103.317 -1603.73 10.281', 0),
(123, '8', '406', '123', '', 'Presidential Estate', 'None', '3000000000000', 'None', 'None', '-519.05 775.453 97.5104', 0),
(124, '2', '406', '124', '', 'The Driscoll Residence', 'None', '750000', 'None', 'None', '-1187.06 -420.225 11.71', 0),
(125, '17', '406', '125', '', 'Secured Starfish Mansion', 'None', '7500000', 'None', 'None', '-682.1 -422.331 10.3643', 0),
(126, '8', '406', '126', '', 'Viceport houses #01', 'None', '3000000', 'None', 'None', '-844.207 -1034.56 12.269', 0),
(127, '8', '406', '127', '', 'Viceport houses #02', 'None', '3000000', 'None', 'None', '-846.257 -1017.9 12.3403', 0),
(128, '17', '406', '128', '', 'Viceport houses #03', 'None', '3000000', 'None', 'None', '-846.605 -1001.47 12.342', 0),
(129, '9', '406', '129', '', 'Viceport houses #04', 'None', '3000000', 'None', 'None', '-847.902 -951.877 11.1034', 0),
(130, '9', '406', '130', '', 'Viceport houses #05', 'None', '3000000', 'None', 'None', '-849.753 -968.016 11.1034', 0),
(131, '8', '406', '131', '', 'VicePort Mansion #01', 'None', '5000000', 'None', 'None', '499.521 559.541 11.695', 0),
(132, '3', '406', '132', '', 'Ocean Beach House #1', 'None', '1000000', 'None', 'None', '-41.2207 -1072.33 10.4635', 0),
(133, '3', '406', '133', '', 'Ocean Beach House #2', 'None', '1000000', 'None', 'None', '-5.03063 -1071.02 10.4635', 0),
(134, 'None', '406', '134', '', 'Ocean Beach House #3', 'None', '1000000', 'None', 'None', '-20.9246 -1062.05 10.4635', 0),
(135, 'None', '406', '135', '', 'Ocean Beach House #4', 'None', '1000000', 'None', 'None', '-15.0008 -1050.7 10.4635', 0),
(136, 'None', '406', '136', '', 'Ocean Beach House #5', 'None', '1000000', 'None', 'None', '25.296 -1116.22 10.4633', 0),
(137, 'None', '406', '137', '', 'Ocean Beach House #6', 'None', '1000000', 'None', 'None', '37.1622 -1103.66 10.4633', 0),
(138, 'None', '406', '138', '', 'Ocean Beach House #7', 'None', '1000000', 'None', 'None', '52.5351 -1100.08 10.4633', 0),
(139, 'None', '406', '139', '', 'Ocean Beach House #8', 'None', '1000000', 'None', 'None', '64.6236 -1111.58 10.4633', 0),
(140, 'None', '406', '140', '', 'Ocean Beach House #9', 'None', '1000000', 'None', 'None', '-31.9939 -1138.25 10.4633', 0),
(141, 'None', '406', '141', '', 'Ocean Beach House #10', 'None', '1000000', 'None', 'None', '-3.37231 -1166.31 10.4633', 0),
(142, 'None', '406', '142', '', 'Ocean Beach House #11', 'None', '1000000', 'None', 'None', '-23.5254 -1149.64 10.4633', 0),
(143, '3', '406', '143', '', 'Ocean Beach House #12', 'None', '1000000', 'None', 'None', '-3.5646 -1150.1 10.4633', 0),
(144, 'None', '406', '144', '', 'Ocean Beach House #13', 'None', '1000000', 'None', 'None', '-3.2748 -1145.18 10.4633', 0),
(145, 'None', '406', '145', '', 'Ocean Beach House #14', 'None', '1000000', 'None', 'None', '-15.7081 -1138.18 10.4633', 0),
(146, 'None', '406', '146', '', 'Ocean Beach House #15', 'None', '1000000', 'None', 'None', '-3.46145 -1129.23 10.4633', 0),
(147, 'None', '406', '147', '', 'Ocean Beach House #16', 'None', '1000000', 'None', 'None', '-3.46741 -1123.45 10.4633', 0),
(148, '3', '406', '148', '', 'Ocean Beach House #17', 'None', '1000000', 'None', 'None', '-3.54395 -1107.39 10.4633', 0),
(149, 'None', '406', '149', '', 'Ocean Beach House #18', 'None', '1000000', 'None', 'None', '-3.51256 -1102.89 10.4633', 0),
(150, '3', '406', '150', '', 'Ocean Beach House #19', 'None', '1000000', 'None', 'None', '-2.93047 -1087.29 10.4633', 0),
(151, 'None', '406', '151', '', 'Ocean Beach House #20', 'None', '1000000', 'None', 'None', '-9.14128 -1437.86 10.4588', 0),
(152, 'None', '406', '152', '', 'Ocean Beach House #21', 'None', '1000000', 'None', 'None', '-10.2185 -1450.26 10.4598', 0),
(153, '3', '406', '153', '', 'Ocean Beach House #22', 'None', '1000000', 'None', 'None', '-11.321 -1462.54 10.4615', 0),
(154, '3', '406', '154', '', 'Ocean Beach House #23', 'None', '1000000', 'None', 'None', '-12.7207 -1474.83 10.4629', 0),
(155, '3', '406', '155', '', 'Ocean Beach House #24', 'None', '1000000', 'None', 'None', '-14.5014 -1496.19 10.4629', 0),
(156, 'None', '406', '156', '', 'Ocean Beach House #25', 'None', '1000000', 'None', 'None', '-15.5777 -1508.3 10.4628', 0),
(157, 'None', '406', '157', '', 'Ocean Beach House #26', 'None', '1000000', 'None', 'None', '-16.5281 -1520.74 10.4628', 0),
(158, 'None', '406', '158', '', 'Ocean Beach House #27', 'None', '1000000', 'None', 'None', '-17.4741 -1533.13 10.4631', 0),
(159, 'None', '406', '159', '', 'Ocean Beach House #28', 'None', '1000000', 'None', 'None', '-27.0214 -1556.87 10.4478', 0),
(160, 'None', '406', '160', '', 'Ocean Beach House #29', 'None', '1000000', 'None', 'None', '-32.7804 -1531.88 10.4357', 0),
(161, 'None', '406', '161', '', 'Ocean Beach House #30', 'None', '1000000', 'None', 'None', '-31.6789 -1519.63 10.4377', 0),
(162, 'None', '406', '162', '', 'Ocean Beach House #31', 'None', '1000000', 'None', 'None', '-30.5495 -1507.18 10.4397', 0),
(163, 'None', '406', '163', '', 'Ocean Beach House #32', 'None', '1000000', 'None', 'None', '-29.4232 -1494.66 10.4417', 0),
(164, 'None', '406', '164', '', 'Ocean Beach House #33', 'None', '1000000', 'None', 'None', '-27.7011 -1473.71 10.4449', 0),
(165, 'None', '406', '165', '', 'Ocean Beach House #34', 'None', '1000000', 'None', 'None', '-26.6911 -1461.21 10.4468', 0),
(166, '3', '406', '166', '', 'Ocean Beach House #35', 'None', '1000000', 'None', 'None', '-25.4542 -1448.97 10.4488', 0),
(167, '3', '406', '167', '', 'Ocean Beach House #36', 'None', '1000000', 'None', 'None', '-24.4337 -1436.41 10.4507', 0),
(168, '3', '406', '168', '', 'Ocean Beach House #37', 'None', '1000000', 'None', 'None', '-19.5605 -1384.45 10.4589', 0),
(169, '3', '406', '169', '', 'Ocean Beach House #38', 'None', '1000000', 'None', 'None', '-17.4623 -1362.1 10.4625', 0),
(170, '3', '406', '170', '', 'Ocean Beach House #39', 'None', '1000000', 'None', 'None', '2.60646 -1358.13 10.4633', 0),
(171, '3', '406', '171', '', 'Ocean Beach House #40', 'None', '1000000', 'None', 'None', '24.7078 -1359.58 10.4633', 0),
(172, 'None', '406', '172', '', 'Ocean Beach House #41', 'None', '1000000', 'None', 'None', '-61.038 -1458.39 10.4489', 0),
(173, '3', '406', '173', '', 'Big Orange Ocean Beach Appartement', 'None', '1500000', 'None', 'None', '-55.1801 -1377.87 10.4593', 0),
(174, 'None', '406', '174', '', 'Ocean Beach House #42', 'None', '1000000', 'None', 'None', '-72.5352 -1447.01 10.4533', 0),
(175, 'None', '406', '175', '', 'Ocean Beach House #43', 'None', '1000000', 'None', 'None', '-103.278 -1285.1 10.4631', 0),
(176, 'None', '406', '176', '', 'Ocean Beach House #44', 'None', '1000000', 'None', 'None', '-58.1329 -1288.8 10.4631', 0),
(177, '3', '406', '177', '', 'Ocean Beach House #45', 'None', '1000000', 'None', 'None', '-78.478 -1299.49 10.4631', 0),
(178, '3', '406', '178', '', 'Ocean Beach House #46', 'None', '1000000', 'None', 'None', '-62.0539 -1312.34 10.4631', 0),
(179, '20', '406', '179', '', 'Ocean Beach House #47', 'None', '1000000', 'None', 'None', '-54.8171 -1305.31 10.4631', 0),
(180, '7', '406', '180', '', 'Ocean Beach House #48', 'None', '1000000', 'None', 'None', '-63.4864 -1335.65 10.4631', 0),
(181, '3', '406', '181', '', 'Ocean Beach House #49', 'None', '1000000', 'None', 'None', '-56.41 -1343.01 10.4631', 0),
(182, '1', '406', '182', '', 'Ocean Beach House #50', 'None', '1000000', 'None', 'None', '-79.9803 -1339.91 10.4631', 0),
(183, 'None', '406', '183', '', 'Ocean Beach House #51', 'None', '1000000', 'None', 'None', '-69.5828 -1359.53 10.4629', 0),
(184, '3', '406', '184', '', 'Ocean Beach House #52', 'None', '1000000', 'None', 'None', '-23.5303 -1166.08 10.4633', 0),
(185, 'None', '406', '185', '', 'Ocean Beach House #53', 'None', '1000000', 'None', 'None', '37.1714 -1314.17 10.4633', 0),
(186, '1', '406', '186', '', 'Ocean Beach House #54', 'None', '1000000', 'None', 'None', '1.09 -1311.03 10.4633', 0);

-- --------------------------------------------------------

--
-- Table structure for table `spawnwep`
--

CREATE TABLE `spawnwep` (
  `Nick` text,
  `Weps` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `spawnwep`
--

INSERT INTO `spawnwep` (`Nick`, `Weps`) VALUES
('Anik', ' 26 20');

-- --------------------------------------------------------

--
-- Table structure for table `vehiclecost`
--

CREATE TABLE `vehiclecost` (
  `rowid` int(11) NOT NULL,
  `Job` int(1) DEFAULT NULL,
  `Name` varchar(19) DEFAULT NULL,
  `Cost` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehiclecost`
--

INSERT INTO `vehiclecost` (`rowid`, `Job`, `Name`, `Cost`) VALUES
(1, 0, 'Admiral', 475000),
(2, 6, 'Ambulance', 350000),
(3, 0, 'Angel', 500000),
(4, 0, 'BF Injection', 575000),
(5, 0, 'Banshee', 1000000),
(6, 2, 'Barracks OL', 450000),
(7, 0, 'Benson', 350000),
(8, 0, 'Blista Compact', 275000),
(9, 0, 'Bloodring Banger #1', 750000),
(10, 0, 'Bobcat', 475000),
(11, 0, 'Boxville', 350000),
(12, 0, 'Burrito', 400000),
(13, 0, 'Gang Burrito', 450000),
(14, 0, 'Bus', 630000),
(15, 0, 'Cabbie', 450000),
(16, 0, 'Caddy', 750000),
(17, 0, 'Cheetah', 1350000),
(18, 0, 'Coach', 500000),
(19, 0, 'Coast Guard', 725000),
(20, 0, 'Comet', 650000),
(21, 0, 'Cuban Hermes', 700000),
(22, 0, 'Cuban Jetmax', 1000000),
(24, 0, 'Dinghy', 600000),
(25, 2, 'Enforcer', 730000),
(26, 0, 'Esperanto', 275000),
(27, 2, 'FBI Rancher', 850000),
(28, 2, 'FBI Washington', 820000),
(29, 0, 'Faggio', 750000),
(30, 0, 'Firetruck', 780000),
(31, 0, 'Flatbed', 300000),
(32, 0, 'Freeway', 500000),
(33, 0, 'Gang Burrito', 780000),
(34, 0, 'Glendale', 275000),
(35, 0, 'Greenwood', 375000),
(36, 0, 'Hermes', 575000),
(37, 0, 'Hotring Racer #3', 1000000),
(38, 2, 'Hunter', 860000),
(39, 0, 'Idaho', 300000),
(40, 0, 'Infernus', 1500000),
(41, 0, 'Kaufman Cab', 1300000),
(42, 0, 'Mesa Grande', 475000),
(43, 0, 'Moonbeam', 450000),
(44, 0, 'Mr. Whoopee', 830000),
(45, 0, 'Mule', 350000),
(46, 0, 'Oceanic', 250000),
(47, 0, 'PCJ-600', 1400000),
(48, 0, 'Packer', 525000),
(49, 2, 'Patriot', 670000),
(50, 0, 'Perennial', 630000),
(51, 0, 'Phoenix', 700000),
(52, 0, 'Stretch', 750000),
(53, 4, 'Taxi', 300000),
(54, 0, 'Top Fun', 840000),
(55, 0, 'Trashmaster', 300000),
(56, 0, 'Tropic', 740000),
(57, 0, 'VCN Maverick', 1000000),
(58, 0, 'Virgo', 275000),
(59, 0, 'Voodoo', 1400000),
(60, 0, 'Walton', 350000),
(61, 0, 'Washington', 400000),
(62, 0, 'Yankee', 350000),
(63, 0, 'Zebra Cab', 1300000),
(64, 0, 'Romeros Hearse', 580000),
(65, 2, 'Vice Squad Cheetah', 690000),
(66, 0, 'Maverick', 2000000),
(67, 2, 'Police', 700000),
(68, 0, 'Landstalker', 400000),
(69, 0, 'Sabre', 525000),
(70, 0, 'Sabre Turbo', 999999999),
(71, 0, 'Sentinel', 375000),
(72, 0, 'Sentinel XS', 750000),
(73, 2, 'Police Maverick', 580000),
(74, 0, 'Stinger', 1250000),
(75, 0, 'Sanchez', 725000),
(76, 0, 'Love Fist', 640000),
(77, 0, 'Skimmer', 630000),
(78, 0, 'Securicar', 750000),
(79, 0, 'Rio', 620000),
(80, 0, 'Marquis', 790000),
(81, 0, 'Predator', 810000),
(82, 0, 'Regina', 300000),
(83, 0, 'Sea Sparrow', 100000000),
(84, 0, 'Reefer', 700000),
(85, 0, 'Sandking', 475000),
(86, 0, 'Stallion', 475000),
(87, 0, 'Deluxo', 625000),
(88, 0, 'squallo', 6000000),
(89, 0, 'squalo', 6000000),
(90, 0, 'Hotring Racer #1', 1000000),
(91, 0, 'Hotring Racer #2', 1000000),
(92, 0, 'Bloodring Banger #2', 750000),
(93, 0, 'Linerunner', 300000),
(94, 0, 'Rancher', 500000),
(95, 0, 'Speeder', 1000000),
(96, 0, 'Spand Express', 350000),
(97, 0, 'Pizza Boy', 750000),
(98, 0, 'Manana', 325000),
(99, 0, 'Pony', 400000),
(100, 0, 'Baggage Handler', 490000),
(101, 0, 'Rumpo', 400000),
(102, 0, 'HDNR Truck', 999999999),
(103, 0, 'RC Bandit', 999999999),
(104, 0, 'Sparrow', 1000000),
(105, 0, 'RC Baron', 999999999),
(106, 0, 'RC Raider', 999999999),
(107, 0, 'RC Goblin', 999999999),
(108, 0, 'Thugz Limo', 999999999),
(109, 0, 'Rhino', 2147483647);

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `rowid` int(11) NOT NULL,
  `Model` text NOT NULL,
  `Name` text NOT NULL,
  `Position` text NOT NULL,
  `Angle` text NOT NULL,
  `Col1` text NOT NULL,
  `Col2` text NOT NULL,
  `Owner` text NOT NULL,
  `Shared` text NOT NULL,
  `Parked` text NOT NULL,
  `Market` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`rowid`, `Model`, `Name`, `Position`, `Angle`, `Col1`, `Col2`, `Owner`, `Shared`, `Parked`, `Market`) VALUES
(1, '220', 'FBI Rancher', '-863.292, -667.012, 11.2546', '0.0569592', '0', '0', 'MHC Staff', 'None', 'N', ''),
(2, '220', 'FBI Rancher', '-859.415, -666.818, 11.2361', '0.0514903', '0', '0', 'MHC Staff', 'None', 'N', ''),
(3, '236', 'Vice Squad Cheetah', '-855.292, -666.32, 11.2164', '0.0919023', '3', '0', 'MHC Staff', 'None', 'N', ''),
(4, '236', 'Vice Squad Cheetah', '-851.56, -665.637, 11.1986', '0.0903335', '0', '0', 'MHC Staff', 'None', 'N', ''),
(5, '147', 'FBI Washington', '-845.798, -671.471, 11.1707', '-1.43747', '0', '0', 'MHC Staff', 'None', 'N', ''),
(6, '236', 'Vice Squad Cheetah', '-844.724, -675.559, 11.167', '-1.42132', '14', '6', 'MHC Staff', 'None', 'N', ''),
(7, '153', 'Mr. Whoopee', '-873.187, -572.968, 11.1829', '-1.42118', '2', '1', 'None', 'None', 'N', ''),
(8, '158', 'Securicar', '-872.382, -357.13, 11.1014', '-0.0311999', '51', '51', 'MHC Staff', 'None', 'N', ''),
(9, '156', 'Police', '-665.226, 772.08, 11.1782', '0.0131483', '52', '1', 'MHC Staff', 'None', 'N', ''),
(10, '156', 'Police', '-665.307, 782.944, 11.2629', '0.0064869', '52', '1', 'MHC Staff', 'None', 'N', ''),
(11, '156', 'Police', '-665.332, 792.569, 11.2629', '0.0119515', '52', '1', 'MHC Staff', 'None', 'N', ''),
(12, '156', 'Police', '-665.349, 804.43, 11.2629', '0.00741149', '52', '1', 'MHC Staff', 'None', 'N', ''),
(13, '156', 'Police', '-645.239, 753.975, 11.429', '-1.64252', '52', '1', 'MHC Staff', 'None', 'N', ''),
(14, '156', 'Police', '-622.802, 752.366, 11.429', '-1.64253', '52', '1', 'MHC Staff', 'None', 'N', ''),
(15, '156', 'Police', '-611.854, 751.759, 11.429', '-1.64253', '52', '1', 'MHC Staff', 'None', 'N', ''),
(16, '157', 'Enforcer', '-634.702, 753.165, 11.429', '-1.61518', '52', '1', 'MHC Staff', 'None', 'N', ''),
(17, '156', 'Police', '493.475, 503.553, 11.4882', '-3.12824', '52', '1', 'MHC Staff', 'None', 'N', ''),
(18, '156', 'Police', '502.15, 503.749, 11.3746', '-3.12824', '52', '1', 'MHC Staff', 'None', 'N', ''),
(19, '157', 'Enforcer', '520.646, 503.784, 11.0796', '3.11161', '52', '1', 'MHC Staff', 'None', 'N', ''),
(20, '156', 'Police', '489.453, 517.913, 11.5815', '-1.58058', '52', '1', 'MHC Staff', 'None', 'N', ''),
(21, '156', 'Police', '355.942, -511.813, 12.3246', '2.4179', '52', '1', 'MHC Staff', 'None', 'N', ''),
(22, '156', 'Police', '361.279, -516.669, 12.3246', '2.40696', '52', '1', 'MHC Staff', 'None', 'N', ''),
(23, '156', 'Police', '369.365, -523.695, 12.3246', '2.45071', '52', '1', 'MHC Staff', 'None', 'N', ''),
(24, '200', 'Patriot', '-1746, -261.731, 14.8683', '1.54547', '49', '49', 'MHC Staff', 'None', 'N', ''),
(25, '200', 'Patriot', '-1746.5, -240.814, 14.8683', '1.53453', '49', '49', 'MHC Staff', 'None', 'N', ''),
(26, '200', 'Patriot', '-1702.58, -273.457, 14.8683', '-1.55572', '49', '49', 'MHC Staff', 'None', 'N', ''),
(27, '200', 'Patriot', '-1747.4, -211.813, 14.8683', '1.53918', '49', '49', 'MHC Staff', 'None', 'N', ''),
(28, '163', 'Barracks OL', '-1702.18, -239.524, 14.8683', '-1.51744', '49', '49', 'MHC Staff', 'None', 'N', ''),
(29, '155', 'Hunter', '-1661.88, -225.486, 14.8683', '-0.0358195', '49', '49', 'MHC Staff', 'None', 'N', ''),
(30, '215', 'Baggage Handler', '-1546.36, -804.868, 14.868', '0.00303174', '1', '1', 'MHC Staff', 'None', 'N', ''),
(31, '141', 'Infernus', '-1021.44, -865.911, 13.0852', '2.35208', '22', '22', 'None', 'None', 'N', ''),
(32, '159', 'Banshee', '-1015.4, -865.683, 13.0852', '-2.74985', '2', '20', 'None', 'None', 'N', ''),
(33, '210', 'Comet', '-1028.29, -858.871, 13.0864', '1.90912', '2', '7', 'None', 'None', 'N', ''),
(34, '207', 'Phoenix', '-1014.49, -865.922, 17.9572', '-2.37798', '35', '4', 'None', 'None', 'N', 'False'),
(35, '211', 'Deluxo', '-1020.54, -868.356, 17.9671', '2.22608', '2', '1', 'None', 'None', 'N', 'False'),
(36, '141', 'Infernus', '-1025.02, -861.198, 17.9593', '2.32452', '50', '53', 'None', 'None', 'N', ''),
(37, '144', 'Mule', '-954.147, -1302.09, 12.1277', '2.72867', '53', '53', 'None', 'None', 'N', 'False'),
(38, '185', 'Flatbed', '-1020.56, -1453.13, 11.7738', '-0.401587', '40', '40', 'None', 'None', 'N', ''),
(39, '133', 'Linerunner', '-713.387, -1362.5, 11.0873', '-1.28503', '2', '2', 'None', 'None', 'N', ''),
(40, '132', 'Stinger', '-699.88, -1269.62, 11.0715', '-1.14236', '54', '14', 'None', 'None', 'N', ''),
(41, '132', 'Stinger', '-696.948, -1275.82, 11.0715', '-1.16971', '15', '15', 'None', 'None', 'N', ''),
(42, '197', 'Oceanic', '-809.322, -1162.64, 11.1022', '1.91384', '5', '5', 'None', 'None', 'N', 'False'),
(43, '205', 'Sabre', '-826.656, -1109.67, 11.1054', '1.76072', '1', '1', 'None', 'None', 'N', ''),
(44, '207', 'Phoenix', '-830.136, -1091.4, 11.1039', '1.76311', '7', '75', 'None', 'None', 'N', ''),
(45, '219', 'Rancher', '-843.742, -958.272, 11.1034', '3.05448', '70', '72', 'None', 'None', 'N', ''),
(46, '224', 'Hotring Racer #1', '-845.799, -910.34, 11.1034', '-0.0661077', '89', '23', 'None', 'None', 'N', ''),
(47, '164', 'Cuban Hermes', '-1164.92, -604.127, 11.6415', '-1.42863', '47', '3', 'None', 'None', 'N', 'False'),
(48, '164', 'Cuban Hermes', '-1175.68, -630.695, 11.6415', '-3.04191', '0', '1', 'None', 'None', 'N', 'False'),
(49, '142', 'Voodoo', '-955.248, 143.685, 9.26685', '0.00976087', '67', '67', 'None', 'None', 'N', 'False'),
(50, '142', 'Voodoo', '-970, 145.762, 9.20947', '0.0320449', '67', '67', 'None', 'None', 'N', ''),
(51, '150', 'Taxi', '-1005.34, 208.422, 11.358', '-0.12629', '51', '14', 'None', 'None', 'N', 'False'),
(52, '150', 'Taxi', '-999.186, 207.23, 11.4341', '-0.159103', '1', '1', 'None', 'None', 'N', ''),
(53, '150', 'Taxi', '-994.339, 193.617, 11.4341', '1.3284', '1', '1', 'None', 'None', 'N', ''),
(54, '188', 'Zebra Cab', '-1006.74, 191.739, 11.4078', '1.49441', '1', '1', 'None', 'None', 'N', ''),
(55, '138', 'Trashmaster', '-1283.71, 145.36, 11.4501', '-0.00741242', '1', '1', 'None', 'None', 'N', ''),
(56, '178', 'Pizza Boy', '-1047.97, 91.5838, 11.5972', '1.50966', '3', '5', 'None', 'None', 'N', ''),
(57, '206', 'Sabre Turbo', '-1107.32, 293.987, 12.2578', '-1.59318', '1', '1', 'None', 'None', 'N', ''),
(58, '191', 'PCJ-600', '-736.279, 328.328, 11.1007', '-1.69116', '1', '1', 'None', 'None', 'N', ''),
(59, '191', 'PCJ-600', '-736.095, 331.072, 11.1007', '-1.76225', '16', '11', 'None', 'None', 'N', ''),
(60, '130', 'Landstalker', '-815.899, 580.468, 10.931', '0.0278988', '34', '1', 'None', 'None', 'N', 'False'),
(61, '135', 'Sentinel', '-857.269, 580.64, 10.931', '0.0388336', '6', '6', 'None', 'None', 'N', 'False'),
(62, '152', 'Bobcat', '-863.611, 534.091, 10.931', '-3.13304', '21', '21', 'None', 'None', 'N', ''),
(63, '193', 'Freeway', '-601.589, 654.524, 11.0726', '-3.02794', '57', '57', 'None', 'None', 'N', 'False'),
(64, '193', 'Freeway', '-587.113, 655.589, 11.0719', '-2.98419', '1', '52', 'None', 'None', 'N', 'False'),
(65, '166', 'Angel', '-604.298, 654.568, 11.0729', '-2.98419', '1', '1', 'None', 'None', 'N', 'False'),
(66, '166', 'Angel', '-589.775, 656.058, 11.0725', '-2.96778', '1', '1', 'None', 'None', 'N', ''),
(67, '227', 'Police Maverick', '-613.963, 804.598, 29.6848', '3.11332', '52', '1', 'MHC Staff', 'None', 'N', ''),
(68, '137', 'Firetruck', '-693.278, 929.703, 10.9154', '1.58077', '3', '1', 'MHC Staff', 'None', 'N', ''),
(69, '137', 'Firetruck', '-693.16, 916.828, 10.9154', '1.52608', '3', '1', 'MHC Staff', 'None', 'N', ''),
(70, '201', 'Love Fist', '-865.412, 1153.6, 10.8762', '2.94608', '87', '19', 'None', 'None', 'N', 'False'),
(71, '234', 'Bloodring Banger #1', '-1090.95, 1278.98, 8.73682', '-0.0246916', '13', '1', 'None', 'None', 'N', 'False'),
(72, '235', 'Bloodring Banger #2', '-1099.09, 1280.06, 8.73682', '0.0245266', '3', '72', 'None', 'None', 'N', 'False'),
(73, '146', 'Ambulance', '-775.828, 1128.28, 12.4243', '3.13988', '1', '14', 'MHC Staff', 'None', 'N', ''),
(74, '232', 'Hotring Racer #2', '-1098.11, 1383.06, 8.73682', '3.10406', '5', '1', 'None', 'None', 'N', ''),
(75, '233', 'Hotring Racer #3', '-1090.16, 1382.76, 8.73682', '3.10953', '0', '2', 'None', 'None', 'N', ''),
(76, '230', 'Mesa Grande', '-1348.9, 1502.79, 8.73682', '-3.13307', '10', '46', 'None', 'None', 'N', ''),
(77, '159', 'Banshee', '-1544.42, 1226.32, 8.73679', '0.47734', '0', '0', 'None', 'None', 'N', ''),
(78, '141', 'Infernus', '-1539.44, 1228.69, 8.7368', '0.488278', '35', '35', 'None', 'None', 'N', ''),
(79, '217', 'Maverick', '-853.421, 1354.98, 69.5497', '1.57159', '23', '89', 'None', 'None', 'N', ''),
(80, '218', 'VCN Maverick', '-469.564, 1123.57, 64.7521', '-1.58524', '1', '1', 'None', 'None', 'N', ''),
(81, '145', 'Cheetah', '-33.7106, 939.722, 10.9403', '3.13014', '70', '72', 'None', 'None', 'N', ''),
(82, '151', 'Washington', '-40.786, 941.007, 10.9403', '-3.1257', '13', '13', 'None', 'None', 'N', ''),
(83, '179', 'Gang Burrito', '38.2082, 1098.15, 15.672', '0.236609', '74', '3', 'None', 'None', 'N', ''),
(84, '179', 'Gang Burrito', '24.5006, 1132.91, 18.4436', '-0.0122185', '8', '46', 'None', 'None', 'N', ''),
(85, '169', 'Stallion', '309.698, 1245.09, 17.518', '1.61509', '12', '12', 'None', 'None', 'N', ''),
(86, '149', 'Esperanto', '325.663, 1254.62, 17.4815', '-0.0528769', '2', '2', 'None', 'None', 'N', ''),
(87, '141', 'Infernus', '336.056, 1213.93, 22.7475', '-1.58878', '57', '1', 'None', 'None', 'N', ''),
(88, '174', 'Sentinel XS', '336.348, 1188.17, 22.7475', '-1.57888', '1', '1', 'None', 'None', 'N', ''),
(89, '191', 'PCJ-600', '336.256, 1225.47, 27.5683', '-1.58353', '3', '5', 'None', 'None', 'N', ''),
(90, '198', 'Sanchez', '335.561, 1214.22, 27.5705', '-1.55072', '1', '1', 'None', 'None', 'N', ''),
(91, '146', 'Ambulance', '467.181, 718.393, 11.4033', '-1.61188', '1', '14', 'MHC Staff', 'None', 'N', ''),
(92, '132', 'Stinger', '445.377, 638.437, 11.2428', '-1.55267', '3', '26', 'None', 'None', 'N', ''),
(93, '141', 'Infernus', '455.568, -0.333274, 10.9861', '1.53903', '44', '44', 'None', 'None', 'N', 'False'),
(94, '197', 'Oceanic', '477.112, -15.5392, 10.7099', '-1.65431', '87', '1', 'None', 'None', 'N', ''),
(95, '205', 'Sabre', '456.515, -24.8979, 10.6124', '1.57184', '46', '46', 'None', 'None', 'N', 'False'),
(96, '204', 'Hermes', '463.382, 10.399, 10.9562', '-0.0191569', '3', '3', 'None', 'None', 'N', ''),
(97, '209', 'Regina', '479.768, -24.8997, 10.6069', '-1.64844', '4', '4', 'None', 'None', 'N', 'False'),
(98, '217', 'Maverick', '478.271, -19.5009, 10.6635', '-1.63203', '1', '12', 'None', 'None', 'N', ''),
(99, '226', 'Blista Compact', '476.199, -42.3562, 10.1246', '3.0164', '19', '19', 'None', 'None', 'N', 'False'),
(100, '211', 'Deluxo', '488.751, -42.3608, 10.1241', '3.11214', '46', '69', 'None', 'None', 'N', 'False'),
(101, '141', 'Infernus', '518.334, -175.056, 13.6293', '-2.59642', '67', '67', 'None', 'None', 'N', ''),
(102, '191', 'PCJ-600', '507.787, -309.891, 13.8289', '3.02866', '75', '75', 'None', 'None', 'N', ''),
(103, '154', 'BF Injection', '490.138, -477.957, 10.9015', '3.11405', '66', '66', 'None', 'None', 'N', ''),
(104, '198', 'Sanchez', '239.185, -1250.14, 11.0712', '1.33152', '46', '1', 'None', 'None', 'N', ''),
(105, '175', 'Admiral', '241.464, -1282.09, 10.9015', '2.92539', '1', '1', 'None', 'None', 'N', ''),
(106, '131', 'Idaho', '243.356, -1349.27, 10.9015', '2.94138', '12', '12', 'None', 'None', 'N', ''),
(107, '145', 'Cheetah', '86.3964, -1489.99, 10.4353', '1.46062', '36', '36', 'None', 'None', 'N', ''),
(108, '191', 'PCJ-600', '82.4997, -1473.36, 10.4376', '1.38406', '16', '3', 'None', 'None', 'N', ''),
(109, '191', 'PCJ-600', '110.481, -1453.13, 10.4318', '-0.458911', '2', '70', 'None', 'None', 'N', ''),
(110, '192', 'Faggio', '133.889, -1350.78, 10.4633', '1.45478', '5', '5', 'None', 'None', 'N', 'False'),
(111, '171', 'Glendale', '138.615, -1304.97, 10.4427', '1.44454', '35', '50', 'None', 'None', 'N', 'False'),
(112, '207', 'Phoenix', '148.737, -1213.53, 17.7805', '-1.66973', '6', '1', 'None', 'None', 'N', 'False'),
(113, '219', 'Rancher', '130.147, -1180.21, 17.7805', '-0.0730367', '13', '1', 'None', 'None', 'N', 'True'),
(114, '213', 'Spand Express', '301.555, -301.225, 11.9591', '-0.0480928', '93', '1', 'None', 'None', 'N', ''),
(115, '145', 'Cheetah', '198.895, -502.653, 11.5182', '3.05086', '68', '68', 'None', 'None', 'N', ''),
(116, '141', 'Infernus', '226.399, -364.072, 10.6624', '2.90706', '37', '0', 'None', 'None', 'N', ''),
(117, '186', 'Yankee', '277.857, -234.078, 12.4681', '-1.52819', '17', '17', 'None', 'None', 'N', ''),
(118, '169', 'Stallion', '231.683, -223.049, 11.834', '1.04278', '50', '38', 'None', 'None', 'N', ''),
(119, '154', 'BF Injection', '254.293, -171.851, 11.5481', '1.04819', '32', '32', 'None', 'None', 'N', 'False'),
(120, '139', 'Stretch', '-377.768, -514.1, 12.8199', '1.52462', '1', '1', 'None', 'None', 'N', ''),
(121, '175', 'Admiral', '-394.377, -535.135, 12.7797', '-3.13517', '3', '121', 'None', 'None', 'N', ''),
(122, '141', 'Infernus', '-355.234, -535.908, 12.7753', '-3.14064', '58', '58', 'None', 'None', 'N', 'False'),
(123, '211', 'Deluxo', '-359.93, -534.771, 12.7618', '3.12642', '68', '68', 'None', 'None', 'N', ''),
(124, '217', 'Maverick', '-390.574, -573.775, 40.0476', '1.59011', '46', '4', 'None', 'None', 'N', ''),
(125, '191', 'PCJ-600', '-407.584, -536.159, 12.8105', '1.63232', '46', '22', 'None', 'None', 'N', ''),
(126, '145', 'Cheetah', '-224.048, -418.403, 11.289', '-1.43665', '7', '4', 'None', 'None', 'N', ''),
(127, '159', 'Banshee', '-267.626, -302.318, 10.2978', '-0.378867', '6', '6', 'None', 'None', 'N', 'False'),
(128, '209', 'Regina', '-560.4, -522.073, 10.6463', '3.01565', '29', '29', 'None', 'None', 'N', 'False'),
(129, '141', 'Infernus', '-962.355, -356.111, 13.382', '-1.57643', '172', '172', 'None', 'None', 'N', 'False'),
(130, '204', 'Hermes', '-829.651, -783.547, 11.102', '-3.07676', '60', '60', 'None', 'None', 'N', 'False'),
(131, '207', 'Phoenix', '-805.368, -1180.79, 11.1046', '1.93609', '1', '1', 'None', 'None', 'N', ''),
(132, '210', 'Comet', '-732.566, -1504.44, 11.5493', '-0.0257654', '77', '77', 'None', 'None', 'N', ''),
(133, '191', 'PCJ-600', '-709.162, -1504.12, 11.4634', '-0.0367007', '190', '104', 'None', 'None', 'N', ''),
(134, '207', 'Phoenix', '-714.407, -1556.34, 12.5575', '2.67446', '61', '1', 'None', 'None', 'N', 'False'),
(135, '177', 'Sea Sparrow', '-677.748, -1568.03, 12.5276', '-2.01437', '15', '15', 'MHC Staff', 'None', 'N', ''),
(136, '176', 'Squalo', '-580.449, -1515.05, 6.76054', '-1.86576', '39', '1', 'None', 'None', 'N', ''),
(137, '223', 'Cuban Jetmax', '-581.409, -1503.76, 7.09599', '-1.95067', '3', '6', 'None', 'None', 'N', ''),
(138, '214', 'Marquis', '-328.257, -1254.67, 6.76432', '-0.0293312', '13', '1', 'None', 'None', 'N', ''),
(139, '202', 'Coast Guard', '-325.923, -1208.8, 6.97433', '1.52885', '1', '1', 'None', 'None', 'N', ''),
(140, '190', 'Skimmer', '-653.152, -264.13, 6.85891', '-1.04873', '4', '1', 'None', 'None', 'N', ''),
(141, '206', 'Sabre Turbo', '-69.2273, 86.6681, 9.6832', '1.78886', '1', '1', 'None', 'None', 'N', 'False'),
(142, '210', 'Comet', '89.7875, 243.521, 21.6841', '-1.21484', '3', '142', 'None', 'None', 'N', 'False'),
(143, '187', 'Caddy', '101.312, 281.356, 21.7719', '0.455038', '60', '60', 'None', 'None', 'N', 'False'),
(144, '187', 'Caddy', '77.0562, 271.276, 21.7719', '0.388208', '6', '6', 'None', 'None', 'N', ''),
(145, '217', 'Maverick', '292.463, 269.149, 17.71', '-1.49238', '0', '0', 'None', 'None', 'N', ''),
(146, '221', 'Virgo', '259.073, 42.7253, 11.0712', '1.28558', '67', '67', 'None', 'None', 'N', ''),
(147, '149', 'Esperanto', '109.766, -791.104, 10.4633', '-2.13184', '46', '46', 'None', 'None', 'N', ''),
(148, '140', 'Manana', '12.8839, -1013.34, 10.4633', '3.09868', '50', '50', 'None', 'None', 'N', 'True'),
(149, '135', 'Sentinel', '-30.3958, -993.837, 10.463', '0.00383188', '1', '1', 'None', 'None', 'N', ''),
(150, '134', 'Perennial', '-52.534, -1012.55, 10.4634', '3.11555', '69', '69', 'None', 'None', 'N', 'False'),
(151, '146', 'Ambulance', '-133.328, -979.398, 10.4634', '-2.81767', '1', '14', 'MHC Staff', 'None', 'N', ''),
(152, '159', 'Banshee', '-233.899, -1376.47, 8.11297', '1.8528', '4', '4', 'None', 'None', 'N', ''),
(153, '145', 'Cheetah', '-241.704, -1345.59, 8.11296', '1.65822', '1', '63', 'None', 'None', 'N', ''),
(154, '132', 'Stinger', '-140.556, -1418.37, 3.97023', '-1.26598', '1', '154', 'None', 'None', 'N', 'False'),
(155, '211', 'Deluxo', '-138.477, -1366.5, 3.97023', '-1.24957', '34', '34', 'None', 'None', 'N', ''),
(156, '217', 'Maverick', '-1094.29, 1513.33, 11.9797', '0.0516071', '66', '4', 'None', 'None', 'N', ''),
(157, '203', 'Dinghy', '-375.524, -660.184, 5.66126', '-1.62624', '1', '1', 'None', 'None', 'N', 'False'),
(158, '176', 'Speeder', '-218.589, -283.936, 6.76508', '0.772359', '5', '5', 'None', 'None', 'N', ''),
(159, '190', 'Skimmer', '-141.43, 1027.74, 6.93857', '0.20361', '3', '1', 'None', 'None', 'N', ''),
(160, '190', 'Skimmer', '601.113, -1699.24, 6.80608', '1.25361', '46', '1', 'None', 'None', 'N', 'False'),
(161, '167', 'Coach', '-1161.04, -1316.31, 14.872', '2.74783', '0', '5', 'None', 'None', 'N', 'False'),
(162, '217', 'Maverick', '-878.83, 1509.81, 33.0392', '1.58928', '66', '16', 'None', 'None', 'N', 'False'),
(163, '143', 'Pony', '-1055.08, -266.206, 11.4464', '1.59382', '40', '27', 'None', 'None', 'N', 'False'),
(164, '145', 'Cheetah', '-839.649, 534.747, 10.931', '-3.11382', '96', '96', 'None', 'None', 'N', ''),
(165, '154', 'BF Injection', '-804.828, 493.118, 10.931', '-1.58392', '6', '6', 'None', 'None', 'N', ''),
(166, '159', 'Banshee', '562.206, 679.777, 13.3316', '1.4394', '5', '5', 'None', 'None', 'N', ''),
(167, '174', 'Sentinel XS', '539.637, 159.915, 14.493', '-3.11295', '61', '61', 'None', 'None', 'N', ''),
(168, '210', 'Comet', '316.398, -906.868, 10.9016', '2.73285', '53', '53', 'None', 'None', 'N', 'False'),
(169, '225', 'Sandking', '10.3006, -1382.37, 10.4633', '1.47466', '14', '35', 'None', 'None', 'N', 'False'),
(170, '191', 'PCJ-600', '20.184, -1246.36, 10.4633', '-3.03124', '58', '6', 'None', 'None', 'N', ''),
(171, '198', 'Sanchez', '0.478668, -1238.43, 10.4633', '-3.13403', '7', '7', 'None', 'None', 'N', ''),
(172, '193', 'Freeway', '53.8606, -943.711, 15.2593', '1.63679', '3', '172', 'None', 'None', 'N', ''),
(173, '130', 'Landstalker', '48.8371, -928.852, 24.573', '1.62459', '14', '14', 'None', 'None', 'N', 'False'),
(174, '132', 'Stinger', '47.9251, -952.081, 24.573', '1.60459', '46', '43', 'None', 'None', 'N', 'False'),
(175, '141', 'Infernus', '-505.836, 1212.1, 7.54459', '-0.493219', '105', '105', 'None', 'None', 'N', ''),
(176, '191', 'PCJ-600', '368.683, 471.897, 11.6417', '-1.66818', '50', '2', 'None', 'None', 'N', ''),
(177, '175', 'Admiral', '-1141.61, -939.265, 14.8677', '1.56789', '35', '3', 'None', 'None', 'N', ''),
(178, '207', 'Phoenix', '-1152.05, -955.119, 14.8677', '-1.57118', '11', '11', 'None', 'None', 'N', 'False'),
(179, '211', 'Deluxo', '-1649.81, -665.299, 14.8852', '-3.13087', '50', '24', 'None', 'None', 'N', ''),
(180, '224', 'Hotring Racer #1', '-1627.42, -654.02, 14.8852', '0.0245986', '95', '77', 'None', 'None', 'N', ''),
(181, '192', 'Faggio', '-1627.34, -645.034, 14.8852', '-3.11406', '1', '1', 'None', 'None', 'N', ''),
(182, '218', 'VCN Maverick', '-1369.35, -1255.93, 18.2098', '-2.44491', '1', '0', 'None', 'None', 'N', ''),
(183, '161', 'Bus', '348.154, -500.073, 12.3246', '-0.63341', '3', '5', 'None', 'None', 'N', ''),
(184, '197', 'Oceanic', '261.107, -1267, 10.9015', '2.94313', '53', '2', 'None', 'None', 'N', 'True'),
(185, '142', 'Voodoo', '-731.914, -1557.57, 14.9149', '1.20213', '6', '1', 'None', 'None', 'N', 'False'),
(186, '174', 'Sentinel XS', '-1005.18, -686.105, 11.7894', '-1.43794', '96', '89', 'None', 'None', 'N', ''),
(187, '143', 'Pony', '497.323, -83.6153, 10.0303', '2.38396', '24', '24', 'None', 'None', 'N', ''),
(188, '162', 'Caddy', '-69.956, 79.6732, 9.88085', '1.68564', '26', '26', 'None', 'None', 'N', ''),
(189, '216', 'Kaufman Cab', '-1007.75, 197.516, 19.8485', '3.01822', '35', '35', 'None', 'None', 'N', ''),
(190, '192', 'Faggio', '-486.387, 1132.76, 65.4701', '-1.76604', '64', '64', 'None', 'None', 'N', ''),
(191, '226', 'Blista Compact', '338.346, 1186.57, 22.7475', '1.54711', '16', '1', 'None', 'None', 'N', 'False'),
(192, '229', 'Benson', '-198.529, -423.906, 11.1074', '0.0986424', '36', '23', 'None', 'None', 'N', ''),
(193, '222', 'Greenwood', '-235.456, -1249.25, 8.11296', '1.53777', '59', '78', 'None', 'None', 'N', 'False'),
(194, '175', 'Admiral', '-240.333, -1224.79, 8.11295', '-0.0855818', '46', '46', 'None', 'None', 'N', ''),
(195, '212', 'Burrito', '333.822, -823.578, 10.9962', '-0.235393', '5', '5', 'None', 'None', 'N', ''),
(196, '142', 'Voodoo', '-1041.47, -503.547, 11.127', '-1.53418', '4', '4', 'None', 'None', 'N', ''),
(197, '174', 'Sentinel XS', '-1331.76, 42.096, 11.377', '-3.12262', '7', '7', 'None', 'None', 'N', ''),
(198, '173', 'Packer', '-1331.69, 21.0519, 11.3715', '-0.0402131', '14', '0', 'None', 'None', 'N', 'False'),
(199, '230', 'Mesa Grande', '-414.045, -256.984, 11.1153', '1.56405', '46', '43', 'None', 'None', 'N', 'False'),
(200, '230', 'Mesa Grande', '-980.2, -1169.37, 14.868', '-1.57142', '61', '61', 'None', 'None', 'N', ''),
(201, '139', 'Stretch', '498.217, -83.6674, 10.0305', '2.36652', '69', '69', 'None', 'None', 'N', ''),
(202, '185', 'Flatbed', '-691.449, -1572.45, 12.5539', '1.13877', '79', '79', 'None', 'None', 'N', ''),
(203, '173', 'Packer', '-968.477, -837.576, 13.1644', '-3.07756', '46', '2', 'None', 'None', 'N', 'False'),
(204, '229', 'Benson', '-936.894, -1490.78, 12.1373', '-1.97637', '53', '78', 'None', 'None', 'N', ''),
(205, '228', 'Boxville', '77.5242, -1476.25, 10.2894', '1.43138', '61', '1', 'None', 'None', 'N', ''),
(206, '221', 'Virgo', '110.21, -1459.32, 10.4318', '-0.403833', '1', '14', 'None', 'None', 'N', ''),
(207, '213', 'Spand Express', '286.958, -194.481, 11.2462', '2.80445', '66', '66', 'None', 'None', 'N', ''),
(208, '198', 'Sanchez', '265.697, -296.388, 9.24819', '1.58073', '2', '2', 'None', 'None', 'N', ''),
(209, '191', 'PCJ-600', '235.783, -1290.57, 11.0712', '-0.2177', '172', '0', 'None', 'None', 'N', ''),
(210, '178', 'Pizza Boy', '407.764, 103.697, 11.3964', '-2.49684', '14', '35', 'None', 'None', 'N', ''),
(211, '154', 'BF Injection', '877.681, 757.596, 15.2661', '-0.100909', '3', '53', 'None', 'None', 'N', ''),
(212, '210', 'Comet', '35.6485, -1068.12, 10.4633', '-1.49739', '29', '29', 'None', 'None', 'N', 'False'),
(213, '208', 'Walton', '-716.53, 1267.06, 11.7673', '3.13835', '84', '93', 'None', 'None', 'N', ''),
(214, '191', 'PCJ-600', '-406.082, -535.997, 12.8093', '-1.3105', '62', '62', 'None', 'None', 'N', ''),
(215, '185', 'Flatbed', '-61.0869, 1030.38, 10.9403', '1.63743', '33', '33', 'None', 'None', 'N', ''),
(216, '138', 'Trashmaster', '9.82512, 992.482, 10.9403', '2.87593', '93', '44', 'None', 'None', 'N', ''),
(217, '203', 'Dinghy', '-798.966, -352.179, 4.83348', '-0.130228', '4', '14', 'None', 'None', 'N', ''),
(218, '169', 'Stallion', '440.692, -474.676, 10.1874', '2.9477', '28', '54', 'None', 'None', 'N', 'False'),
(219, '193', 'Freeway', '459.682, -383.71, 10.2197', '1.33234', '3', '1', 'None', 'None', 'N', 'False'),
(220, '148', 'Moonbeam', '336.863, 1214.66, 27.5665', '1.58203', '57', '57', 'None', 'None', 'N', 'True'),
(221, '152', 'Bobcat', '-1190.21, -331.351, 10.9427', '-3.0074', '2', '44', 'None', 'None', 'N', 'False'),
(222, '142', 'Voodoo', '-936.943, 300.087, 11.263', '3.12195', '5', '5', 'None', 'None', 'N', ''),
(223, '141', 'Infernus', '451.715, 196.364, 11.6681', '1.5744', '196', '196', 'None', 'None', 'N', ''),
(224, '151', 'Washington', '-516.455, 841.384, 11.5987', '-0.103339', '40', '40', 'None', 'None', 'N', 'False'),
(225, '205', 'Sabre', '-573.487, 839.521, 11.5987', '0.00644685', '23', '23', 'None', 'None', 'N', ''),
(226, '211', 'Deluxo', '-523.127, 839.456, 11.5987', '0.0411744', '61', '61', 'None', 'None', 'N', ''),
(227, '198', 'Sanchez', '-1651.37, -971.717, 14.868', '-2.20162', '6', '50', 'None', 'None', 'N', 'False'),
(228, '196', 'Glendale', '-741.905, 1043.19, 9.5002', '0.0182791', '1', '35', 'None', 'None', 'N', ''),
(229, '217', 'Maverick', '-877.699, 1509.97, 33.0392', '1.562', '24', '39', 'None', 'None', 'N', ''),
(230, '154', 'BF Injection', '-355.979, 1422.29, 10.2285', '0.0200482', '46', '57', 'None', 'None', 'N', ''),
(231, '198', 'Sanchez', '-515.611, 1365.33, 11.7669', '-0.557512', '66', '66', 'None', 'None', 'N', 'False'),
(232, '234', 'Bloodring Banger #1', '-1567.34, 1409.12, 8.73678', '2.6525', '10', '10', 'None', 'None', 'N', 'False'),
(233, '207', 'Phoenix', '171.312, -1074.62, 10.4318', '-3.1018', '7', '1', 'None', 'None', 'N', 'False'),
(234, '223', 'Cuban Jetmax', '-145.751, 1001.91, 4.94999', '2.45673', '6', '66', 'None', 'None', 'N', 'False'),
(235, '224', 'Hotring Racer #1', '-970.685, -825.489, 6.80089', '2.14071', '0', '0', 'None', 'None', 'N', ''),
(236, '191', 'PCJ-600', '-1229.71, -1313.07, 14.6302', '-2.79995', '46', '1', 'None', 'None', 'N', ''),
(237, '145', 'Cheetah', '588.229, 693.303, 12.6679', '-0.103201', '90', '90', 'None', 'None', 'N', ''),
(238, '217', 'Maverick', '-1369.31, -1255.77, 18.2099', '-2.50783', '0', '197', 'None', 'None', 'N', ''),
(239, '137', 'Firetruck', '-1768.43, -889.819, 14.868', '-1.49781', '14', '1', 'MHC Staff', 'None', 'N', ''),
(240, '198', 'Sanchez', '806.799, 787.304, 18.1615', '1.44185', '36', '36', 'None', 'None', 'N', ''),
(241, '191', 'PCJ-600', '-1012.15, -161.153, 11.1806', '3.06175', '22', '22', 'None', 'None', 'N', ''),
(242, '193', 'Freeway', '370.672, -595.813, 10.1787', '1.80214', '50', '7', 'None', 'None', 'N', ''),
(243, '175', 'Admiral', '116.123, -1224.26, 17.7805', '-0.0104508', '8', '8', 'None', 'None', 'N', 'False'),
(244, '149', 'Esperanto', '-53.1585, -932.401, 24.573', '-1.52781', '57', '57', 'None', 'None', 'N', ''),
(245, '132', 'Stinger', '-1596.62, -632.189, 14.8852', '3.14036', '54', '245', 'None', 'None', 'N', ''),
(246, '131', 'Idaho', '52.8152, -449.031, 8.44666', '0.00253917', '95', '95', 'None', 'None', 'N', 'False'),
(247, '198', 'Sanchez', '-335.052, -1450.39, 8.11296', '-1.53832', '61', '61', 'None', 'None', 'N', ''),
(248, '191', 'PCJ-600', '-536.841, 936.861, 74.6843', '0.0196285', '14', '14', 'None', 'None', 'N', ''),
(249, '191', 'PCJ-600', '-212.842, -403.165, 10.8827', '0.549827', '1', '1', 'None', 'None', 'N', ''),
(250, '213', 'Spand Express', '309.675, -303.323, 11.9591', '-3.13755', '35', '35', 'None', 'None', 'N', ''),
(251, '170', 'Rumpo', '122.363, -347.756, 9.03077', '-0.0380735', '84', '79', 'None', 'None', 'N', ''),
(252, '139', 'Stretch', '-175.122, -1122.61, 10.4633', '-0.683704', '0', '0', 'None', 'None', 'N', 'False'),
(253, '213', 'Spand Express', '285.644, -302.228, 11.9591', '-1.59266', '7', '7', 'None', 'None', 'N', ''),
(254, '152', 'Bobcat', '-389.275, -297.189, 10.4818', '-1.55518', '6', '0', 'None', 'None', 'N', 'False'),
(255, '141', 'Infernus', '-669.333, -420.708, 10.4761', '0.13937', '0', '0', 'None', 'None', 'N', ''),
(256, '233', 'Hotring Racer #3', '-709.627, 28.0875, 9.66629', '-1.58973', '66', '16', 'None', 'None', 'N', ''),
(257, '176', 'Squalo', '-169.386, -389.12, 4.89605', '0.246426', '14', '1', 'None', 'None', 'N', ''),
(258, '229', 'Benson', '-1062.45, -445.883, 10.9456', '1.75727', '90', '1', 'None', 'None', 'N', ''),
(259, '133', 'Linerunner', '-1061.99, -502.592, 11.1377', '1.62831', '57', '57', 'None', 'None', 'N', ''),
(260, '207', 'Phoenix', '-786.899, 689.595, 11.0846', '-1.54486', '0', '14', 'None', 'None', 'N', 'False'),
(261, '151', 'Washington', '-1063.08, -649.577, 11.6594', '-2.94598', '61', '61', 'None', 'None', 'N', 'False'),
(262, '130', 'Landstalker', '287.68, -325.232, 11.9591', '-2.43611', '78', '65', 'None', 'None', 'N', 'False'),
(263, '193', 'Freeway', '-544.552, 686.319, 11.0845', '-1.2866', '26', '16', 'None', 'None', 'N', ''),
(264, '166', 'Angel', '-540.533, 695.724, 11.0847', '-1.99374', '0', '14', 'None', 'None', 'N', ''),
(265, '208', 'Walton', '-601.873, 619.784, 11.6814', '1.62891', '94', '94', 'None', 'None', 'N', ''),
(266, '171', 'RC Bandit', '-67.8703, 82.7424, 8.7619', '-1.53738', '1', '0', 'None', 'None', 'N', ''),
(267, '174', 'Sentinel XS', '604.093, 692.565, 12.2274', '1.58333', '66', '66', 'None', 'None', 'N', ''),
(268, '175', 'Admiral', '74.309, 913.521, 10.7917', '-1.71452', '61', '61', 'None', 'None', 'N', 'False'),
(269, '197', 'Oceanic', '-872.551, 250.31, 9.34845', '1.45805', '6', '1', 'None', 'None', 'N', 'False'),
(270, '197', 'Oceanic', '-456.514, 963.567, 11.0846', '-3.13533', '14', '3', 'None', 'None', 'N', 'False'),
(271, '197', 'Oceanic', '-460.056, 1194.7, 9.68458', '-1.65836', '14', '1', 'None', 'None', 'N', ''),
(272, '197', 'Oceanic', '-551.621, 1238.46, 7.54459', '-0.581018', '5', '5', 'None', 'None', 'N', ''),
(273, '217', 'Maverick', '561.908, 1052.94, 18.5156', '1.50664', '83', '23', 'None', 'None', 'N', ''),
(274, '198', 'Sanchez', '542.738, 365.759, 15.4046', '-0.0921311', '12', '12', 'None', 'None', 'N', ''),
(275, '131', 'Idaho', '516.009, 74.2388, 11.2042', '-0.133847', '44', '39', 'None', 'None', 'N', ''),
(276, '143', 'Pony', '242.325, -840.99, 10.147', '2.56608', '62', '62', 'None', 'None', 'N', 'False'),
(277, '169', 'Stallion', '46.8209, -1315.06, 10.4633', '-1.65383', '27', '1', 'None', 'None', 'N', 'False'),
(278, '204', 'Hermes', '-104.001, -1410.73, 10.4623', '0.0163488', '59', '59', 'None', 'None', 'N', ''),
(279, '199', 'Sparrow', '74.7962, 1103.52, 32.6039', '1.55543', '3', '14', 'None', 'None', 'N', ''),
(280, '235', 'Bloodring Banger #2', '243.478, -494.474, 11.9605', '1.4467', '1', '12', 'None', 'None', 'N', 'False'),
(281, '149', 'Esperanto', '-318.144, 1086.34, 9.05853', '1.43984', '65', '1', 'None', 'None', 'N', ''),
(282, '148', 'Moonbeam', '-831.422, 1502.3, 12.2493', '-3.11424', '26', '26', 'None', 'None', 'N', ''),
(283, '183', 'Reefer', '-1205.99, -1366.28, 6.00078', '2.71843', '1', '1', 'None', 'None', 'N', ''),
(284, '212', 'Burrito', '-1159.3, -1414.24, 11.4832', '-1.86643', '3', '1', 'None', 'None', 'N', 'False'),
(285, '141', 'Infernus', '-1117.26, 123.392, 11.1264', '3.10207', '1', '7', 'None', 'None', 'N', ''),
(286, '211', 'Deluxo', '-1135.4, -1057.35, 14.8677', '0.0388923', '69', '1', 'None', 'None', 'N', ''),
(287, '178', 'Pizza Boy', '-1023.75, 69.566, 11.4146', '0.102582', '61', '61', 'None', 'None', 'N', ''),
(288, '217', 'Maverick', '-871.579, -516.285, 29.2181', '-2.99202', '0', '172', 'None', 'None', 'N', ''),
(289, '145', 'Cheetah', '-976.186, -396.076, 10.9455', '-1.29671', '35', '35', 'None', 'None', 'N', ''),
(290, '132', 'Stinger', '-851.559, -712.325, 11.1284', '-1.74002', '4', '4', 'None', 'None', 'N', ''),
(291, '147', 'FBI Washington', '-1175.8, 71.0238, 11.128', '-1.55732', '0', '0', 'MHC Staff', 'None', 'N', ''),
(292, '220', 'FBI Rancher', '-1175.92, 74.8893, 11.128', '-1.51904', '0', '0', 'MHC Staff', 'None', 'N', ''),
(293, '236', 'Vice Squad Cheetah', '-1160.58, 106.384, 11.1277', '3.12648', '0', '0', 'MHC Staff', 'None', 'N', ''),
(294, '236', 'Vice Squad Cheetah', '-1181.79, 85.8428, 11.1281', '-1.55983', '1', '1', 'MHC Staff', 'None', 'N', ''),
(295, '163', 'Barracks OL', '-1186.18, 106.884, 11.1279', '-1.61998', '0', '0', 'MHC Staff', 'None', 'N', ''),
(296, '6401', 'Thugz Limo', '467.371, -42.2486, 10.127', '-3.02481', '0', '0', 'None', 'None', 'N', ''),
(297, '141', 'Infernus', '526.568, -190.487, 13.6291', '0.943585', '1', '1', 'None', 'None', 'N', 'False'),
(298, '206', 'Sabre Turbo', '-410.143, -519.165, 12.7815', '-1.68176', '0', '0', 'None', 'None', 'N', ''),
(299, '145', 'Cheetah', '-126.104, -1390.75, 10.463', '1.58189', '1', '1', 'None', 'None', 'N', ''),
(300, '217', 'Maverick', '-329.031, -291.193, 12.2092', '-0.00798463', '59', '14', 'None', 'None', 'N', ''),
(301, '191', 'PCJ-600', '-128.095, -1377.69, 10.463', '1.57297', '1', '1', 'None', 'None', 'N', ''),
(302, '145', 'Cheetah', '-1235.15, -354.197, 10.8579', '0.0360971', '0', '0', 'None', 'None', 'N', 'False'),
(303, '191', 'PCJ-600', '-1075.37, 141.019, 11.263', '-2.31656', '49', '49', 'None', 'None', 'N', ''),
(304, '233', 'Hotring Racer #3', '-968.799, -825.117, 6.80089', '1.64357', '96', '95', 'None', 'None', 'N', ''),
(305, '174', 'Sentinel XS', '75.0642, -883.12, 10.4414', '0.592601', '65', '65', 'None', 'None', 'N', ''),
(306, '211', 'Deluxo', '377.392, -765.604, 11.0713', '2.70381', '23', '95', 'None', 'None', 'N', 'False'),
(307, '212', 'Burrito', '-994.431, -301.459, 10.7601', '0.046412', '0', '0', 'None', 'None', 'N', ''),
(308, '132', 'Stinger', '-485.852, -551.295, 10.335', '-1.53952', '2', '2', 'None', 'None', 'N', ''),
(309, '218', 'VCN Maverick', '-768.217, 1242.82, 24.9881', '1.61271', '1', '1', 'None', 'None', 'N', ''),
(310, '141', 'Infernus', '-263.294, 1346.58, 27.2445', '3.08486', '5', '5', 'None', 'None', 'N', ''),
(311, '191', 'PCJ-600', '-483.888, -422.436, 11.5696', '-3.13943', '59', '59', 'None', 'None', 'N', ''),
(312, '141', 'Infernus', '-822.477, 475.209, 10.931', '1.58156', '13', '13', 'None', 'None', 'N', 'False'),
(313, '145', 'Cheetah', '47.8394, -952.009, 24.573', '1.60895', '3', '3', 'None', 'None', 'N', 'False'),
(314, '191', 'PCJ-600', '603.097, 695.495, 12.2663', '-2.97207', '66', '66', 'None', 'None', 'N', 'False'),
(315, '227', 'Police Maverick', '367.668, -483.702, 22.9141', '2.48692', '53', '1', 'MHC Staff', 'None', 'N', ''),
(316, '227', 'Police Maverick', '389.617, -500.249, 22.9141', '2.39436', '53', '1', 'MHC Staff', 'None', 'N', ''),
(317, '227', 'Police Maverick', '-888.153, -683.329, 26.7596', '-2.67643', '53', '1', 'MHC Staff', 'None', 'N', ''),
(318, '191', 'PCJ-600', '-1661.43, -1540.26, 14.868', '-1.97267', '0', '0', 'None', 'None', 'N', ''),
(319, '191', 'PCJ-600', '-1059.08, -1435.55, 11.7475', '1.2364', '50', '50', 'None', 'None', 'N', ''),
(320, '232', 'Hotring Racer #2', '-54.4751, -1493.66, 10.291', '3.07473', '36', '62', 'None', 'None', 'N', ''),
(321, '224', 'Hotring Racer #1', '-873.657, -1249.03, 11.7188', '1.11767', '14', '2', 'None', 'None', 'N', ''),
(322, '224', 'Hotring Racer #1', '-955.9, -1501.55, 12.1819', '1.14561', '53', '1', 'None', 'None', 'N', ''),
(323, '144', 'Mule', '-607.289, -1482.51, 12.5257', '1.17545', '33', '55', 'None', 'None', 'N', ''),
(324, '192', 'Faggio', '-375.488, 1384.54, 11.1664', '-3.14135', '2', '2', 'None', 'None', 'N', ''),
(325, '205', 'Sabre', '522.08, 110.892, 11.1378', '-0.0469546', '14', '14', 'None', 'None', 'N', ''),
(326, '159', 'Banshee', '-650.484, 1388.33, 12.0332', '1.60473', '53', '6', 'None', 'None', 'N', ''),
(327, '145', 'Cheetah', '-955.673, 1147.88, 11.1121', '-1.53679', '64', '3', 'None', 'None', 'N', ''),
(328, '134', 'Perennial', '-796.284, -1231.31, 11.1697', '-0.864101', '0', '0', 'None', 'None', 'N', ''),
(329, '138', 'Trashmaster', '-1360.08, 1280.8, 83.8882', '1.82214', '0', '0', 'None', 'None', 'N', ''),
(330, '138', 'Trashmaster', '-1365.71, 1294.34, 83.8882', '0.953019', '0', '0', 'None', 'None', 'N', ''),
(331, '141', 'Infernus', '-1220.37, -350.509, 10.797', '-3.06762', '0', '0', 'None', 'None', 'N', ''),
(332, '142', 'Voodoo', '-1006.84, -227.49, 10.8694', '1.66763', '6', '12', 'None', 'None', 'N', ''),
(333, '192', 'Faggio', '-1030.51, -228.406, 11.3543', '-2.8054', '6', '6', 'None', 'None', 'N', ''),
(334, '191', 'PCJ-600', '-1024.52, -241.274, 11.2954', '-2.8054', '12', '12', 'None', 'None', 'N', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`rowid`);

--
-- Indexes for table `vehiclecost`
--
ALTER TABLE `vehiclecost`
  ADD PRIMARY KEY (`rowid`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`rowid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;
--
-- AUTO_INCREMENT for table `vehiclecost`
--
ALTER TABLE `vehiclecost`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;
--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=335;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
