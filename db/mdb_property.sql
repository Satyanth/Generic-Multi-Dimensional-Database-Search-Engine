-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: mdb
-- ------------------------------------------------------
-- Server version	8.0.31

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

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property` (
  `domainName` varchar(32) NOT NULL,
  `propertyName` varchar(32) NOT NULL,
  `propertyQuestion` varchar(256) DEFAULT NULL,
  `displayorder` tinyint DEFAULT NULL,
  `propertyDisplayType` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`domainName`,`propertyName`),
  CONSTRAINT `property_ibfk_1` FOREIGN KEY (`domainName`) REFERENCES `domain` (`domainName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES ('Automobiles','age','What age cars are you considering?',4,'radio'),('Automobiles','bodyStyle','Which body styles are you \nconsidering?',2,'multiselect'),('Automobiles','color','What exterior color do you prefer?',8,'select'),('Automobiles','fuelType','What fuel type do you \nprefer?',12,'checkbox'),('Automobiles','luxurySeats','Do you need Luxury Seats?',10,'radio'),('Automobiles','make','Which manufacturer are you \nconsidering?',3,'multiselect'),('Automobiles','mileage','What mileage are you looking for?',7,'radio'),('Automobiles','priceRange','What price range are you looking \nfor?',5,'radio'),('Automobiles','sellerType','Which sellers do you prefer?',6,'radio'),('Automobiles','sunroof','Do you need a Sunroof?',9,'radio'),('Automobiles','transmission','What transmission do you \nprefer?',11,'radio'),('Automobiles','usedOrNew','Which cars are you interested \nin?',1,'checkbox'),('Colleges','collegeAge','Is college age of any concern to \nyou?',13,'radio'),('Colleges','collegeRanking','What ranking of schools are you searching \nfor?',9,'radio'),('Colleges','collegeSize','What size college are you interested \nin?',7,'radio'),('Colleges','collegeType','What type of college are you interested \nin?',6,'checkbox'),('Colleges','cost','What tuitions are you comfortable \nwith?',12,'radio'),('Colleges','focus','Are you interested in schools with a specific \nfocus?',4,'checkbox'),('Colleges','publicOrPrivate','Do you like to attend a public or private \nuniversity?',1,'radio'),('Colleges','region','What region of the country do you \nprefer?',2,'checkbox'),('Colleges','SATAvg','What SAT Average school are you looking \nfor?',8,'radio'),('Colleges','setting','In what kind of setting are you \ninterested?',5,'checkbox'),('Colleges','sportsTradition','Is collegiate sports tradition of \ninterest to you?',10,'radio'),('Colleges','state','What state of the country do you \nprefer?',3,'multiselect'),('Colleges','studentFacultyRatio','How do you feel about student faculty \nratios?',11,'radio');
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-01 22:40:00
