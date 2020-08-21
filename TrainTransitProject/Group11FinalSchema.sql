CREATE DATABASE  IF NOT EXISTS `TrainDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `TrainDB`;
-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com    Database: TrainDB
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `adminUser`
--

DROP TABLE IF EXISTS `adminUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminUser` (
  `usernameAdmin` varchar(50) NOT NULL,
  `SSN` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`usernameAdmin`),
  CONSTRAINT `usernameAdmin` FOREIGN KEY (`usernameAdmin`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminUser`
--

LOCK TABLES `adminUser` WRITE;
/*!40000 ALTER TABLE `adminUser` DISABLE KEYS */;
INSERT INTO `adminUser` VALUES ('admin','123456789');
/*!40000 ALTER TABLE `adminUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerRepUser`
--

DROP TABLE IF EXISTS `customerRepUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerRepUser` (
  `usernameCR` varchar(50) NOT NULL,
  `SSN` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`usernameCR`),
  CONSTRAINT `usernameCR` FOREIGN KEY (`usernameCR`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerRepUser`
--

LOCK TABLES `customerRepUser` WRITE;
/*!40000 ALTER TABLE `customerRepUser` DISABLE KEYS */;
INSERT INTO `customerRepUser` VALUES ('cr1','987654321'),('cr2','123412345');
/*!40000 ALTER TABLE `customerRepUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerRepUser_handles_trainSchedule`
--

DROP TABLE IF EXISTS `customerRepUser_handles_trainSchedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerRepUser_handles_trainSchedule` (
  `tsIDCRhTS` int(11) NOT NULL,
  `usernameCRhTS` varchar(45) NOT NULL,
  PRIMARY KEY (`tsIDCRhTS`,`usernameCRhTS`),
  KEY `usernameCRhTS_idx` (`usernameCRhTS`),
  CONSTRAINT `tsIDCRhTS` FOREIGN KEY (`tsIDCRhTS`) REFERENCES `trainSchedule` (`tsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usernameCRhTS` FOREIGN KEY (`usernameCRhTS`) REFERENCES `customerRepUser` (`usernameCR`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerRepUser_handles_trainSchedule`
--

LOCK TABLES `customerRepUser_handles_trainSchedule` WRITE;
/*!40000 ALTER TABLE `customerRepUser_handles_trainSchedule` DISABLE KEYS */;
INSERT INTO `customerRepUser_handles_trainSchedule` VALUES (1,'cr1'),(2,'cr1'),(3,'cr1');
/*!40000 ALTER TABLE `customerRepUser_handles_trainSchedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerRepUser_repliesQuestion_messages`
--

DROP TABLE IF EXISTS `customerRepUser_repliesQuestion_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerRepUser_repliesQuestion_messages` (
  `mID` int(11) NOT NULL,
  `usernameCRrM` varchar(45) NOT NULL,
  PRIMARY KEY (`mID`,`usernameCRrM`),
  KEY `usernameCRrM_idx` (`usernameCRrM`),
  CONSTRAINT `mID` FOREIGN KEY (`mID`) REFERENCES `messages` (`mID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usernameCRrM` FOREIGN KEY (`usernameCRrM`) REFERENCES `customerRepUser` (`usernameCR`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerRepUser_repliesQuestion_messages`
--

LOCK TABLES `customerRepUser_repliesQuestion_messages` WRITE;
/*!40000 ALTER TABLE `customerRepUser_repliesQuestion_messages` DISABLE KEYS */;
INSERT INTO `customerRepUser_repliesQuestion_messages` VALUES (2,'cr1'),(3,'cr1'),(5,'cr1'),(6,'cr1'),(7,'cr1'),(8,'cr1'),(10,'cr1'),(12,'cr1');
/*!40000 ALTER TABLE `customerRepUser_repliesQuestion_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerUser`
--

DROP TABLE IF EXISTS `customerUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerUser` (
  `usernameC` varchar(50) NOT NULL,
  PRIMARY KEY (`usernameC`),
  CONSTRAINT `usernameC` FOREIGN KEY (`usernameC`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerUser`
--

LOCK TABLES `customerUser` WRITE;
/*!40000 ALTER TABLE `customerUser` DISABLE KEYS */;
INSERT INTO `customerUser` VALUES ('cust1'),('cust2'),('cust3'),('cust4'),('cust5'),('cust6');
/*!40000 ALTER TABLE `customerUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerUser_asksQuestion_messages`
--

DROP TABLE IF EXISTS `customerUser_asksQuestion_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerUser_asksQuestion_messages` (
  `mIDaQM` int(11) NOT NULL,
  `usernameCaM` varchar(50) NOT NULL,
  PRIMARY KEY (`mIDaQM`,`usernameCaM`),
  KEY `usernameCaM_idx` (`usernameCaM`),
  CONSTRAINT `mIDaQM` FOREIGN KEY (`mIDaQM`) REFERENCES `messages` (`mID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usernameCaM` FOREIGN KEY (`usernameCaM`) REFERENCES `customerUser` (`usernameC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerUser_asksQuestion_messages`
--

LOCK TABLES `customerUser_asksQuestion_messages` WRITE;
/*!40000 ALTER TABLE `customerUser_asksQuestion_messages` DISABLE KEYS */;
INSERT INTO `customerUser_asksQuestion_messages` VALUES (1,'cust1'),(2,'cust1'),(3,'cust1'),(4,'cust1'),(6,'cust1'),(7,'cust1'),(8,'cust1'),(9,'cust1'),(10,'cust1'),(11,'cust1'),(12,'cust1'),(13,'cust1'),(14,'cust1'),(15,'cust1'),(5,'cust4');
/*!40000 ALTER TABLE `customerUser_asksQuestion_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_has_reservation`
--

DROP TABLE IF EXISTS `customer_has_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_has_reservation` (
  `reservationNumChR` int(11) NOT NULL AUTO_INCREMENT,
  `usernameChR` varchar(50) NOT NULL,
  PRIMARY KEY (`reservationNumChR`),
  KEY `usernameC_idx` (`usernameChR`),
  KEY `reservationNumChR_idx` (`reservationNumChR`),
  CONSTRAINT `reservationNumChR` FOREIGN KEY (`reservationNumChR`) REFERENCES `reservation` (`reservationNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usernameChR` FOREIGN KEY (`usernameChR`) REFERENCES `customerUser` (`usernameC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_has_reservation`
--

LOCK TABLES `customer_has_reservation` WRITE;
/*!40000 ALTER TABLE `customer_has_reservation` DISABLE KEYS */;
INSERT INTO `customer_has_reservation` VALUES (56,'cust1'),(64,'cust1'),(83,'cust1'),(84,'cust1'),(86,'cust1'),(87,'cust1'),(89,'cust1'),(90,'cust1'),(91,'cust1'),(93,'cust1'),(65,'cust2'),(66,'cust2'),(67,'cust2'),(68,'cust2'),(69,'cust2'),(70,'cust2'),(72,'cust3'),(73,'cust3'),(74,'cust3'),(75,'cust3'),(76,'cust3'),(77,'cust4'),(78,'cust4'),(79,'cust4'),(80,'cust4'),(81,'cust5');
/*!40000 ALTER TABLE `customer_has_reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `mID` int(11) NOT NULL,
  `question` varchar(500) DEFAULT NULL,
  `answer` varchar(500) DEFAULT 'Not answered yet.',
  `date` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'How much is the fare?','It varies per reservation.','2020-08-01','11:44:47'),(2,'How many stops will I have?','It varies per reservation.','2020-08-02','12:22:01'),(3,'How long is my trip?','It depends on your origin and destination.','2020-08-03','12:22:55'),(4,'What discounts are available?','Based on your age/disability.','2020-08-04','13:55:24'),(5,'Why are train\'s so expensive?','IDK MAN OUR PRICES','2020-08-05','20:20:24'),(6,'What is the weather like in Richmond?','Check weather.com!','2020-08-06','19:03:27'),(7,'What is your name?','It depends on the person.','2020-08-07','19:06:09'),(8,'Hello?','World.','2020-08-08','19:07:27'),(9,'What?','Not answered yet.','2020-08-08','19:09:50'),(10,'Hello there?','Hello!','2020-08-08','19:09:57'),(11,'There?','Not answered yet.','2020-08-08','19:12:05'),(12,'When is my train coming?','Tomorrow','2020-08-08','17:04:59'),(13,'Why is it so cold outside?','Not answered yet.','2020-08-08','18:40:26'),(14,'Do the trains have bathrooms?','Not answered yet.','2020-08-08','18:44:17'),(15,'How has your day been today?','Not answered yet.','2020-08-08','18:50:42');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservationNumber` int(11) NOT NULL AUTO_INCREMENT,
  `discount` int(11) DEFAULT NULL,
  `totalFare` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `tripType` varchar(20) DEFAULT NULL,
  `transitLineName` varchar(100) DEFAULT NULL,
  `trainID` int(11) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `departureDateTime` datetime DEFAULT NULL,
  `arrivalDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`reservationNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (56,0,36,'2020-08-06','Round Trip','transitLine1',1,'Trenton Station','Princeton Junction Station','2020-08-01 07:00:00','2020-08-01 07:10:00'),(64,0,36.36,'2020-08-06','Round Trip','transitLine1',1,'Trenton Station','Princeton Junction Station','2020-08-01 07:00:00','2020-08-01 07:10:00'),(65,25,300,'2020-08-06','Round Trip','transitLine3',7,'New York Penn Station','Washington DC Station','2020-08-31 10:00:00','2020-08-31 11:55:00'),(66,50,18.18,'2020-08-06','Round Trip','transitLine1',5,'Trenton Station','Princeton Junction Station','2020-08-31 07:00:00','2020-08-31 07:10:00'),(67,0,163.64,'2020-08-06','Round Trip','transitLine1',5,'Princeton Junction Station','New York Penn Station','2020-08-31 07:12:00','2020-08-31 08:00:00'),(68,0,109.09,'2020-08-06','Round Trip','transitLine2',2,'New York Penn Station','Edison Station','2020-08-01 09:00:00','2020-08-01 09:33:00'),(69,0,109.09,'2020-08-06','Round Trip','transitLine2',6,'New York Penn Station','Edison Station','2020-08-31 09:00:00','2020-08-31 09:33:00'),(70,0,90.91,'2020-08-06','Round Trip','transitLine2',2,'Edison Station','Trenton Station','2020-08-01 09:35:00','2020-08-01 10:00:00'),(72,35,650,'2020-08-06','Round Trip','transitLine4',8,'Orlando Station','New York Penn Station','2020-08-31 16:00:00','2020-08-31 21:00:00'),(73,0,109.09,'2020-08-06','Round Trip','transitLine2',2,'New York Penn Station','Edison Station','2020-08-01 09:00:00','2020-08-01 09:33:00'),(74,25,40.91,'2020-08-06','One Way','transitLine1',1,'Edison Station','New York Penn Station','2020-08-01 07:30:00','2020-08-01 08:00:00'),(75,0,200,'2020-08-06','One Way','transitLine3',7,'Richmond Station','Orlando Station','2020-08-31 13:00:00','2020-08-31 15:00:00'),(76,0,200,'2020-08-06','One Way','transitLine4',8,'Orlando Station','Richmond Station','2020-08-31 16:00:00','2020-08-31 17:55:00'),(77,0,600,'2020-08-06','Round Trip','transitLine3',3,'College Park Station','Chapel Hill Station','2020-08-01 11:00:00','2020-08-01 13:55:00'),(78,0,600,'2020-08-06','Round Trip','transitLine3',7,'College Park Station','Chapel Hill Station','2020-08-31 11:00:00','2020-08-31 13:55:00'),(79,0,400,'2020-08-06','Round Trip','transitLine4',4,'Richmond Station','College Park Station','2020-08-01 18:00:00','2020-08-01 19:55:00'),(80,0,36.36,'2020-08-06','Round Trip','transitLine1',1,'Princeton Junction Station','New Brunswick Station','2020-08-01 07:12:00','2020-08-01 07:23:00'),(81,0,90.91,'2020-08-06','Round Trip','transitLine1',5,'Trenton Station','Edison Station','2020-08-31 07:00:00','2020-08-31 07:28:00'),(83,0,72.73,'2020-08-07','Round Trip','transitLine1',1,'Edison Station','Newark Penn Station','2020-08-01 07:30:00','2020-08-01 07:48:00'),(84,0,72.73,'2020-08-07','Round Trip','transitLine1',5,'Edison Station','Newark Penn Station','2020-08-31 07:30:00','2020-08-31 07:48:00'),(86,0,109.09,'2020-08-07','Round Trip','transitLine1',1,'Edison Station','New York Penn Station','2020-08-01 07:30:00','2020-08-01 08:00:00'),(87,0,200,'2020-08-08','Round Trip','transitLine1',1,'Trenton Station','New York Penn Station','2020-08-01 07:00:00','2020-08-01 08:00:00'),(89,0,100,'2020-08-08','Round Trip','transitLine5',9,'Trenton Station','New York Penn Station','2020-08-01 12:00:00','2020-08-01 12:45:00'),(90,0,200,'2020-08-08','Round Trip','transitLine1',1,'Trenton Station','New York Penn Station','2020-08-01 07:00:00','2020-08-01 08:00:00'),(91,35,130,'2020-08-08','Round Trip','transitLine1',1,'Trenton Station','New York Penn Station','2020-08-01 07:00:00','2020-08-01 08:00:00'),(93,25,37.5,'2020-08-08','One Way','transitLine5',9,'Trenton Station','New York Penn Station','2020-08-01 12:00:00','2020-08-01 12:45:00');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_has_train`
--

DROP TABLE IF EXISTS `reservation_has_train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_has_train` (
  `reservationNumberRHT` int(11) NOT NULL,
  `tIDRHT` int(11) NOT NULL,
  PRIMARY KEY (`reservationNumberRHT`),
  KEY `tIDRHT_idx` (`tIDRHT`),
  CONSTRAINT `reservationNumberRHT` FOREIGN KEY (`reservationNumberRHT`) REFERENCES `reservation` (`reservationNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tIDRHT` FOREIGN KEY (`tIDRHT`) REFERENCES `train` (`tID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_has_train`
--

LOCK TABLES `reservation_has_train` WRITE;
/*!40000 ALTER TABLE `reservation_has_train` DISABLE KEYS */;
INSERT INTO `reservation_has_train` VALUES (56,1),(64,1),(74,1),(80,1),(83,1),(68,2),(70,2),(73,2),(77,3),(79,4),(66,5),(67,5),(81,5),(84,5),(69,6),(65,7),(75,7),(78,7),(72,8),(76,8);
/*!40000 ALTER TABLE `reservation_has_train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `sID` int(11) NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Trenton','NJ','Trenton Station'),(2,'Hamilton','NJ','Hamilton Station'),(3,'Princeton Junction','NJ','Princeton Junction Station'),(4,'New Brunswick','NJ','Jersey Ave Station'),(5,'New Brunswick','NJ','New Brunswick Station'),(6,'Edison','NJ','Edison Station'),(7,'Metuchen','NJ','Metuchen Station'),(8,'Rahway','NJ','Rahway Station'),(9,'Elizabeth','NJ','Elizabeth Station'),(10,'Newark','NJ','Newark Penn Station'),(11,'Secaucus','NJ','Secaucus Staion'),(12,'New York','NY','New York Penn Station'),(13,'College Park','MD','College Park Station'),(14,'Washington DC','VA','Washington DC Station'),(15,'Richmond','VA','Richmond Station'),(16,'Chapel Hill','NC','Chapel Hill Station'),(17,'Orlando','FL','Orlando Station');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `tID` int(11) NOT NULL,
  PRIMARY KEY (`tID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainSchedule`
--

DROP TABLE IF EXISTS `trainSchedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainSchedule` (
  `tsID` int(11) NOT NULL,
  `numberOfStops` int(11) DEFAULT NULL,
  `travelTime` time DEFAULT NULL,
  `transitLineName` varchar(100) DEFAULT NULL,
  `fixedFare` float DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `departureDateTime` datetime DEFAULT NULL,
  `arrivalDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`tsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainSchedule`
--

LOCK TABLES `trainSchedule` WRITE;
/*!40000 ALTER TABLE `trainSchedule` DISABLE KEYS */;
INSERT INTO `trainSchedule` VALUES (1,11,'01:00:00','transitLine1',100,'Trenton Station','New York Penn Station','2020-08-01 07:00:00','2020-08-01 08:00:00'),(2,11,'01:00:00','transitLine2',100,'New York Penn Station','Trenton Station','2020-08-01 09:00:00','2020-08-01 10:00:00'),(3,5,'05:00:00','transitLine3',500,'New York Penn Station','Orlando Station','2020-08-01 10:00:00','2020-08-01 15:00:00'),(4,5,'05:00:00','transitLine4',500,'Orlando Station','New York Penn Station','2020-08-01 16:00:00','2020-08-01 21:00:00'),(5,11,'01:00:00','transitLine1',100,'Trenton Station','New York Penn Station','2020-08-31 07:00:00','2020-08-31 08:00:00'),(6,11,'01:00:00','transitLine2',100,'New York Penn Station','Trenton Station','2020-08-31 09:00:00','2020-08-31 10:00:00'),(7,5,'05:00:00','transitLine3',500,'New York Penn Station','Orlando Station','2020-08-31 10:00:00','2020-08-31 15:00:00'),(8,5,'05:00:00','transitLine6',500,'Orlando Station','New York Penn Station','2020-08-31 16:00:00','2020-08-31 21:00:00'),(9,2,'00:45:00','transitLine5',50,'Trenton Station','New York Penn Station','2020-08-01 12:00:00','2020-08-01 12:45:00'),(10,2,'00:45:00','transitLine7',50,'Trenton Station','New York Penn Station','2020-09-15 11:00:00','2020-09-15 11:45:00');
/*!40000 ALTER TABLE `trainSchedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainSchedule_hasStops_station`
--

DROP TABLE IF EXISTS `trainSchedule_hasStops_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainSchedule_hasStops_station` (
  `tsIDStops` int(11) NOT NULL,
  `sIDStops` int(11) NOT NULL,
  `stopNumber` int(11) DEFAULT NULL,
  `departureDateTime` datetime DEFAULT NULL,
  `arrivalDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`tsIDStops`,`sIDStops`),
  KEY `sIDStops_idx` (`sIDStops`),
  CONSTRAINT `sIDStops` FOREIGN KEY (`sIDStops`) REFERENCES `station` (`sID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tsIDStops` FOREIGN KEY (`tsIDStops`) REFERENCES `trainSchedule` (`tsID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainSchedule_hasStops_station`
--

LOCK TABLES `trainSchedule_hasStops_station` WRITE;
/*!40000 ALTER TABLE `trainSchedule_hasStops_station` DISABLE KEYS */;
INSERT INTO `trainSchedule_hasStops_station` VALUES (1,1,0,'2020-08-01 07:00:00',NULL),(1,2,1,'2020-08-01 07:05:00','2020-08-01 07:03:00'),(1,3,2,'2020-08-01 07:12:00','2020-08-01 07:10:00'),(1,4,3,'2020-08-01 07:20:00','2020-08-01 07:17:00'),(1,5,4,'2020-08-01 07:25:00','2020-08-01 07:23:00'),(1,6,5,'2020-08-01 07:30:00','2020-08-01 07:28:00'),(1,7,6,'2020-08-01 07:35:00','2020-08-01 07:33:00'),(1,8,7,'2020-08-01 07:40:00','2020-08-01 07:38:00'),(1,9,8,'2020-08-01 07:45:00','2020-08-01 07:43:00'),(1,10,9,'2020-08-01 07:50:00','2020-08-01 07:48:00'),(1,11,10,'2020-08-01 07:55:00','2020-08-01 07:53:00'),(1,12,11,NULL,'2020-08-01 08:00:00'),(2,1,11,NULL,'2020-08-01 10:00:00'),(2,2,10,'2020-08-01 09:55:00','2020-08-01 09:53:00'),(2,3,9,'2020-08-01 09:50:00','2020-08-01 09:48:00'),(2,4,8,'2020-08-01 09:45:00','2020-08-01 09:43:00'),(2,5,7,'2020-08-01 09:40:00','2020-08-01 09:38:00'),(2,6,6,'2020-08-01 09:35:00','2020-08-01 09:33:00'),(2,7,5,'2020-08-01 09:30:00','2020-08-01 09:28:00'),(2,8,4,'2020-08-01 09:25:00','2020-08-01 09:23:00'),(2,9,3,'2020-08-01 09:20:00','2020-08-01 09:17:00'),(2,10,2,'2020-08-01 09:12:00','2020-08-01 09:10:00'),(2,11,1,'2020-08-01 09:05:00','2020-08-01 09:03:00'),(2,12,0,'2020-08-01 09:00:00',NULL),(3,12,0,'2020-08-01 10:00:00',NULL),(3,13,1,'2020-08-01 11:00:00','2020-08-01 10:55:00'),(3,14,2,'2020-08-01 12:00:00','2020-08-01 11:55:00'),(3,15,3,'2020-08-01 13:00:00','2020-08-01 12:55:00'),(3,16,4,'2020-08-01 14:00:00','2020-08-01 13:55:00'),(3,17,5,NULL,'2020-08-01 15:00:00'),(4,12,5,NULL,'2020-08-01 21:00:00'),(4,13,4,'2020-08-01 20:00:00','2020-08-01 19:55:00'),(4,14,3,'2020-08-01 19:00:00','2020-08-01 18:55:00'),(4,15,2,'2020-08-01 18:00:00','2020-08-01 17:55:00'),(4,16,1,'2020-08-01 17:00:00','2020-08-01 16:55:00'),(4,17,0,'2020-08-01 16:00:00',NULL),(5,1,0,'2020-08-31 07:00:00',NULL),(5,2,1,'2020-08-31 07:05:00','2020-08-31 07:03:00'),(5,3,2,'2020-08-31 07:12:00','2020-08-31 07:10:00'),(5,4,3,'2020-08-31 07:20:00','2020-08-31 07:17:00'),(5,5,4,'2020-08-31 07:25:00','2020-08-31 07:23:00'),(5,6,5,'2020-08-31 07:30:00','2020-08-31 07:28:00'),(5,7,6,'2020-08-31 07:35:00','2020-08-31 07:33:00'),(5,8,7,'2020-08-31 07:40:00','2020-08-31 07:38:00'),(5,9,8,'2020-08-31 07:45:00','2020-08-31 07:43:00'),(5,10,9,'2020-08-31 07:50:00','2020-08-31 07:48:00'),(5,11,10,'2020-08-31 07:55:00','2020-08-31 07:53:00'),(5,12,11,NULL,'2020-08-31 08:00:00'),(6,1,11,NULL,'2020-08-31 10:00:00'),(6,2,10,'2020-08-31 09:55:00','2020-08-31 09:53:00'),(6,3,9,'2020-08-31 09:50:00','2020-08-31 09:48:00'),(6,4,8,'2020-08-31 09:45:00','2020-08-31 09:43:00'),(6,5,7,'2020-08-31 09:40:00','2020-08-31 09:38:00'),(6,6,6,'2020-08-31 09:35:00','2020-08-31 09:33:00'),(6,7,5,'2020-08-31 09:30:00','2020-08-31 09:28:00'),(6,8,4,'2020-08-31 09:25:00','2020-08-31 09:23:00'),(6,9,3,'2020-08-31 09:20:00','2020-08-31 09:17:00'),(6,10,2,'2020-08-31 09:12:00','2020-08-31 09:10:00'),(6,11,1,'2020-08-31 09:05:00','2020-08-31 09:03:00'),(6,12,0,'2020-08-31 09:00:00',NULL),(7,12,0,'2020-08-31 10:00:00',NULL),(7,13,1,'2020-08-31 11:00:00','2020-08-31 10:55:00'),(7,14,2,'2020-08-31 12:00:00','2020-08-31 11:55:00'),(7,15,3,'2020-08-31 13:00:00','2020-08-31 12:55:00'),(7,16,4,'2020-08-31 14:00:00','2020-08-31 13:55:00'),(7,17,5,NULL,'2020-08-31 15:00:00'),(8,12,5,NULL,'2020-08-31 21:00:00'),(8,13,4,'2020-08-31 20:00:00','2020-08-31 19:55:00'),(8,14,3,'2020-08-31 19:00:00','2020-08-31 18:55:00'),(8,15,2,'2020-08-31 18:00:00','2020-08-31 17:55:00'),(8,16,1,'2020-08-31 17:00:00','2020-08-31 16:55:00'),(8,17,0,'2020-08-31 16:00:00',NULL),(9,1,0,'2020-08-01 12:00:00',NULL),(9,7,1,'2020-08-01 12:35:00','2020-08-01 12:30:00'),(9,12,2,NULL,'2020-08-01 12:45:00'),(10,1,0,'2020-09-15 11:00:00',NULL),(10,7,1,'2020-09-15 11:35:00','2020-09-15 11:30:00'),(10,12,2,NULL,'2020-09-15 11:45:00');
/*!40000 ALTER TABLE `trainSchedule_hasStops_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_has_trainSchedule`
--

DROP TABLE IF EXISTS `train_has_trainSchedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_has_trainSchedule` (
  `tIDTHS` int(11) NOT NULL,
  `tsIDTHS` int(11) NOT NULL,
  PRIMARY KEY (`tIDTHS`),
  KEY `tsID_idx` (`tsIDTHS`),
  CONSTRAINT `tIDTHS` FOREIGN KEY (`tIDTHS`) REFERENCES `train` (`tID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tsIDTHS` FOREIGN KEY (`tsIDTHS`) REFERENCES `trainSchedule` (`tsID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_has_trainSchedule`
--

LOCK TABLES `train_has_trainSchedule` WRITE;
/*!40000 ALTER TABLE `train_has_trainSchedule` DISABLE KEYS */;
INSERT INTO `train_has_trainSchedule` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `train_has_trainSchedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','admin',NULL,NULL,NULL),('cr1','cr1','Bob','Math','bob@123'),('cr2','cr2','Jeff','Karate','jeff@123'),('cust1','cust1','John','Smith','john@123'),('cust2','cust2','Sam','Withers','sam@123'),('cust3','cust3','Joe','Good','joe@123'),('cust4','cust4','Matt','Dog','matt@123'),('cust5','cust5','Mike','Apple','mike@123'),('cust6','cust6',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-08 21:19:00
