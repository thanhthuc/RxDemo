CREATE DATABASE  IF NOT EXISTS `RXDemo` /*!40100 DEFAULT CHARACTER SET big5 */;
USE `RXDemo`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: RXDemo
-- ------------------------------------------------------
-- Server version	8.0.3-rc-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `productId` int(11) NOT NULL,
  `productName` varchar(200) DEFAULT NULL,
  `productImageUrl` varchar(200) DEFAULT NULL,
  `productPrice` varchar(200) DEFAULT NULL,
  `districtName` varchar(200) DEFAULT NULL,
  `latitude` varchar(200) DEFAULT NULL,
  `longitude` varchar(200) DEFAULT NULL,
  `addressName` varchar(200) DEFAULT NULL,
  `rating` varchar(200) DEFAULT NULL,
  `restaurantName` varchar(200) DEFAULT NULL,
  `urlrelate` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=big5;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'Book','http://adecinc.com/wp-content/uploads/2017/11/Wish-List-button-600x400.png','20','TanBinh','10','10','Ho Chi Minh','3','Hai San',NULL),(2,'Gift Chrismart','https://static-bebeautiful-in.unileverservices.com/how-to-make-snow-globe-in-mason-jar-600x400.jpg','20','TanBinh','10','10','Ho Chi Minh','3','Hai San',NULL),(3,'Fish','https://i1.wp.com/intheknowupstate.com/wp-content/uploads/2017/11/gnome-600x400.jpg?fit=600%2C400&ssl=1','20','TanBinh','10','10','Ho Chi Minh','3','Hai San',NULL),(4,'CoCaCola','https://www.torontomulticulturalcalendar.com/wp-content/uploads/2017/11/wwwChristmas-Bazaar-Poster-600x400.jpg','20','TanBinh','10','10','Ho Chi Minh','3','Hai San',NULL),(5,'Cake','http://www.qygjxz.com/data/out/46/5993983-christmas-images.jpg','20','TanBinh','10','10','Ho Chi Minh','3','Hai San',NULL),(6,'SportCloth','http://www.qygjxz.com/data/out/46/4889187-christmas-images.jpg','20','TanBinh','10','10','Ho Chi Minh','3','Hai San',NULL);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-07 17:51:01
