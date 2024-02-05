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
-- Table structure for table `propertyDetail`
--

DROP TABLE IF EXISTS `propertyDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propertyDetail` (
  `domainName` varchar(32) NOT NULL,
  `propertyName` varchar(32) NOT NULL,
  `allowedValue` varchar(64) NOT NULL,
  `allowedValueCode` int DEFAULT NULL,
  PRIMARY KEY (`domainName`,`propertyName`,`allowedValue`),
  CONSTRAINT `propertydetail_ibfk_1` FOREIGN KEY (`domainName`, `propertyName`) REFERENCES `property` (`domainName`, `propertyName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propertyDetail`
--

LOCK TABLES `propertyDetail` WRITE;
/*!40000 ALTER TABLE `propertyDetail` DISABLE KEYS */;
INSERT INTO `propertyDetail` VALUES ('Automobiles','age','Between 2 and 5 \nyears old',2),('Automobiles','age','Between 5 and 10 \nyears old',3),('Automobiles','age','Less than 2 years \nold',1),('Automobiles','age','More than 10 years \nold',4),('Automobiles','bodyStyle','Convertible',1),('Automobiles','bodyStyle','Coupe',2),('Automobiles','bodyStyle','Hatchback',3),('Automobiles','bodyStyle','Sedan',4),('Automobiles','bodyStyle','SUV',5),('Automobiles','bodyStyle','Truck',6),('Automobiles','bodyStyle','Van',7),('Automobiles','bodyStyle','Wagon',8),('Automobiles','color','Beige',1),('Automobiles','color','Black',2),('Automobiles','color','Blue',3),('Automobiles','color','Brown',4),('Automobiles','color','Burgundy',5),('Automobiles','color','Charcoal',6),('Automobiles','color','Gold',7),('Automobiles','color','Gray',8),('Automobiles','color','Green',9),('Automobiles','color','Orange',10),('Automobiles','color','Pink',11),('Automobiles','color','Red',12),('Automobiles','color','Silver',13),('Automobiles','color','Tan',14),('Automobiles','color','Turquoise',15),('Automobiles','color','White',16),('Automobiles','fuelType','Alternative',1),('Automobiles','fuelType','Diesel',3),('Automobiles','fuelType','Gasoline',2),('Automobiles','luxurySeats','No',2),('Automobiles','luxurySeats','Yes',1),('Automobiles','make','Acura',1),('Automobiles','make','Audi',2),('Automobiles','make','Bentley',3),('Automobiles','make','BMW',4),('Automobiles','make','Ford',5),('Automobiles','make','Honda',6),('Automobiles','make','Hyundai',7),('Automobiles','make','Mazda',8),('Automobiles','make','Nissan',9),('Automobiles','make','Saab',10),('Automobiles','make','Toyota',11),('Automobiles','make','Volkswagen',12),('Automobiles','mileage','Less than \n15,000',1),('Automobiles','mileage','Less than \n30,000',2),('Automobiles','mileage','Less than \n45,000',3),('Automobiles','mileage','Less than \n60,000',4),('Automobiles','mileage','More than \n60,000',5),('Automobiles','priceRange','Between \n$12,000 and $18,000',2),('Automobiles','priceRange','Between \n$18,000 and $30,000',3),('Automobiles','priceRange','Less than \n$12,000',1),('Automobiles','priceRange','More than \n$30,000',4),('Automobiles','sellerType','Dealers',1),('Automobiles','sellerType','Private \nSeller',2),('Automobiles','sunroof','No',2),('Automobiles','sunroof','Yes',1),('Automobiles','transmission','Automatic',1),('Automobiles','transmission','Manual',2),('Automobiles','usedOrNew','Certified \nCars',3),('Automobiles','usedOrNew','New \nCars',1),('Automobiles','usedOrNew','Used \nCars',2),('Colleges','collegeAge','Established \nover 50 yrs ago',2),('Colleges','collegeAge','New College - \nestablish in past 50 yrs',3),('Colleges','collegeAge','Old school - \nEstablished over 100 yrs ago',1),('Colleges','collegeRanking','100-200',4),('Colleges','collegeRanking','20-50',2),('Colleges','collegeRanking','50-100',3),('Colleges','collegeRanking','Others',5),('Colleges','collegeRanking','Top \n20',1),('Colleges','collegeSize','Large (>20000 \nstudents)',1),('Colleges','collegeSize','Medium \n(5000-20000 students)',2),('Colleges','collegeSize','Small (<5000 \nstudents)',3),('Colleges','collegeType','Engineering',4),('Colleges','collegeType','Law',3),('Colleges','collegeType','Liberal \nArts',1),('Colleges','collegeType','Medical',2),('Colleges','cost','Above $30000',5),('Colleges','cost','Upto $10000',2),('Colleges','cost','Upto $15000',3),('Colleges','cost','Upto $20000',4),('Colleges','cost','Upto $5000',1),('Colleges','focus','Men Only',1),('Colleges','focus','Military',3),('Colleges','focus','Religious',4),('Colleges','focus','Women Only',2),('Colleges','publicOrPrivate','Private',2),('Colleges','publicOrPrivate','Public',1),('Colleges','region','East',3),('Colleges','region','Midwest',2),('Colleges','region','Southeast',1),('Colleges','region','West',4),('Colleges','SATAvg','<800',5),('Colleges','SATAvg','>1400',1),('Colleges','SATAvg','1000-1200',3),('Colleges','SATAvg','1200-1400',2),('Colleges','SATAvg','800-1000',4),('Colleges','setting','Large City',1),('Colleges','setting','Large Town',3),('Colleges','setting','Rural Area',5),('Colleges','setting','Small City',2),('Colleges','setting','Small Town',4),('Colleges','sportsTradition','Excellent \n(won major championships)',1),('Colleges','sportsTradition','Good \n(competitive)',2),('Colleges','sportsTradition','Poor (not \ncompetitive)',3),('Colleges','state','Alabama',1),('Colleges','state','Arizona',2),('Colleges','state','California',3),('Colleges','state','Florida',4),('Colleges','state','Georgia',5),('Colleges','state','Illinois',6),('Colleges','state','Indiana',7),('Colleges','state','Iowa',8),('Colleges','state','Kansas',9),('Colleges','state','Kentucky',10),('Colleges','state','Louisiana',11),('Colleges','state','Maryland',12),('Colleges','state','Michigan',13),('Colleges','state','Minnesota',14),('Colleges','state','Missouri',15),('Colleges','state','Nevada',16),('Colleges','state','New Jersey',18),('Colleges','state','New Mexico',19),('Colleges','state','New York',20),('Colleges','state','North \nCarolina',17),('Colleges','state','Ohio',21),('Colleges','state','Pennsylvania',22),('Colleges','state','South \nCarolina',23),('Colleges','state','South Dakota',24),('Colleges','state','Tennessee',25),('Colleges','state','Texas',26),('Colleges','state','Utah',27),('Colleges','state','Vermont',28),('Colleges','state','Virginia',29),('Colleges','state','Washington',30),('Colleges','state','West Virginia',31),('Colleges','state','Wisconsin',32),('Colleges','state','Wyoming',33),('Colleges','studentFacultyRatio','Larger classes (above 20:1)',3),('Colleges','studentFacultyRatio','Medium classes (10:1 to 20:1)',2),('Colleges','studentFacultyRatio','Small \nclasses (under 10:1)',1);
/*!40000 ALTER TABLE `propertyDetail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-01 22:39:59
