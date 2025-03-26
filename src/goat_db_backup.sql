-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: goat_db
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `breeders`
--

DROP TABLE IF EXISTS `breeders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breeders` (
  `breeder_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`breeder_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `breeders`
--

LOCK TABLES `breeders` WRITE;
/*!40000 ALTER TABLE `breeders` DISABLE KEYS */;
INSERT INTO `breeders` VALUES (1,'John Doe','Texas Ranch','johndoe@example.com');
/*!40000 ALTER TABLE `breeders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goats`
--

DROP TABLE IF EXISTS `goats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goats` (
  `goat_id` int NOT NULL AUTO_INCREMENT,
  `scrapies_tag` varchar(50) NOT NULL,
  `breeder_id` int DEFAULT NULL,
  `weight_kg` float DEFAULT NULL,
  `grade` varchar(10) NOT NULL,
  `price_usd` decimal(10,2) NOT NULL,
  `goat_type` enum('Dairy','Meat','Hybrid') NOT NULL,
  `grading_reason` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`goat_id`),
  UNIQUE KEY `scrapies_tag` (`scrapies_tag`),
  KEY `breeder_id` (`breeder_id`),
  CONSTRAINT `goats_ibfk_1` FOREIGN KEY (`breeder_id`) REFERENCES `breeders` (`breeder_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goats`
--

LOCK TABLES `goats` WRITE;
/*!40000 ALTER TABLE `goats` DISABLE KEYS */;
INSERT INTO `goats` VALUES (1,'TAG12345',1,45.2,'1-2',150.00,'Meat','Good muscle conformation and weight','2025-03-11 16:05:36','2025-03-11 16:05:36');
/*!40000 ALTER TABLE `goats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `goat_id` int DEFAULT NULL,
  `image_type` enum('Front','Side','Top','Post-Slaughter','Other') NOT NULL,
  `image_path` text NOT NULL,
  `captured_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `goat_id` (`goat_id`),
  CONSTRAINT `images_ibfk_1` FOREIGN KEY (`goat_id`) REFERENCES `goats` (`goat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,1,'Front','C:/goat_images/goat_001_front.jpg','2025-03-11 16:16:03'),(2,1,'Side','C:/goat_images/goat_001_side.jpg','2025-03-11 16:16:03'),(3,1,'Top','C:/goat_images/goat_001_top.jpg','2025-03-11 16:16:03');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manual_entries`
--

DROP TABLE IF EXISTS `manual_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manual_entries` (
  `entry_id` int NOT NULL AUTO_INCREMENT,
  `goat_id` int DEFAULT NULL,
  `entry_type` enum('Image','Note') NOT NULL,
  `entry_path` text,
  `entry_text` text,
  `entry_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`entry_id`),
  KEY `goat_id` (`goat_id`),
  CONSTRAINT `manual_entries_ibfk_1` FOREIGN KEY (`goat_id`) REFERENCES `goats` (`goat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manual_entries`
--

LOCK TABLES `manual_entries` WRITE;
/*!40000 ALTER TABLE `manual_entries` DISABLE KEYS */;
INSERT INTO `manual_entries` VALUES (1,1,'Note',NULL,'Observed slight scarring on back, possible healed injury.','2025-03-11 16:12:43');
/*!40000 ALTER TABLE `manual_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_slaughter_data`
--

DROP TABLE IF EXISTS `post_slaughter_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_slaughter_data` (
  `slaughter_id` int NOT NULL AUTO_INCREMENT,
  `goat_id` int DEFAULT NULL,
  `cap_fat` float DEFAULT NULL,
  `back_fat` float DEFAULT NULL,
  `organ_health` text,
  `additional_notes` text,
  `evaluation_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`slaughter_id`),
  KEY `goat_id` (`goat_id`),
  CONSTRAINT `post_slaughter_data_ibfk_1` FOREIGN KEY (`goat_id`) REFERENCES `goats` (`goat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_slaughter_data`
--

LOCK TABLES `post_slaughter_data` WRITE;
/*!40000 ALTER TABLE `post_slaughter_data` DISABLE KEYS */;
INSERT INTO `post_slaughter_data` VALUES (1,1,1.2,1,'Healthy organs','No abnormalities','2025-03-11 16:12:35');
/*!40000 ALTER TABLE `post_slaughter_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 14:00:01
