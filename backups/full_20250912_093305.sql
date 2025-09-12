-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: tamaDB
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Current Database: `tamaDB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tamaDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tamaDB`;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ev_type` enum('EAT','BACKUP','OOPS','RESTORE') NOT NULL,
  `ev_at` datetime(6) NOT NULL,
  `details` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_events_time` (`ev_at`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'RESTORE','2025-09-11 17:55:14.395728','{\"reason\": \"init\", \"character\": \"(U･ᴥ･U)\"}','2025-09-11 08:55:14'),(2,'EAT','2025-09-11 17:55:19.723653','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-11 08:55:19'),(3,'EAT','2025-09-11 17:55:24.240232','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-11 08:55:24'),(4,'OOPS','2025-09-11 17:55:28.570342','{\"state\": \"HURT\", \"delta_health\": -10}','2025-09-11 08:55:28'),(5,'OOPS','2025-09-11 17:55:36.349019','{\"state\": \"HURT\", \"delta_health\": -10}','2025-09-11 08:55:36'),(6,'OOPS','2025-09-11 18:00:44.148052','{\"state\": \"PAIN\", \"delta_health\": -10}','2025-09-11 09:00:44'),(7,'EAT','2025-09-11 18:00:51.108264','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-11 09:00:51'),(8,'RESTORE','2025-09-12 09:16:59.157240','{\"reason\": \"init\", \"character\": \"(U･ᴥ･U)\"}','2025-09-12 00:16:59'),(9,'EAT','2025-09-12 09:17:09.031966','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-12 00:17:09'),(10,'RESTORE','2025-09-12 09:20:20.989092','{\"reason\": \"init\", \"character\": \"(U･ᴥ･U)\"}','2025-09-12 00:20:21'),(11,'EAT','2025-09-12 09:20:24.788210','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-12 00:20:24'),(12,'OOPS','2025-09-12 09:20:29.177259','{\"state\": \"HURT\", \"delta_health\": -10}','2025-09-12 00:20:29'),(13,'OOPS','2025-09-12 09:21:33.173713','{\"state\": \"HURT\", \"delta_health\": -10}','2025-09-12 00:21:33'),(14,'EAT','2025-09-12 09:21:43.361360','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-12 00:21:43'),(15,'RESTORE','2025-09-12 09:22:26.583059','{\"reason\": \"init\", \"character\": \"(U･ᴥ･U)\"}','2025-09-12 00:22:26'),(16,'RESTORE','2025-09-12 09:28:05.317087','{\"reason\": \"init\", \"character\": \"(U･ᴥ･U)\"}','2025-09-12 00:28:05'),(17,'OOPS','2025-09-12 09:28:18.196651','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:28:18'),(18,'OOPS','2025-09-12 09:28:23.322491','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:28:23'),(19,'EAT','2025-09-12 09:28:30.207236','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-12 00:28:30'),(20,'OOPS','2025-09-12 09:29:00.572782','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:29:00'),(21,'RESTORE','2025-09-12 09:29:10.791709','{\"reason\": \"init\", \"character\": \"=^.^=\"}','2025-09-12 00:29:10'),(22,'OOPS','2025-09-12 09:29:46.771205','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:29:46'),(23,'OOPS','2025-09-12 09:29:49.815226','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:29:49'),(24,'OOPS','2025-09-12 09:29:51.457051','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:29:51'),(25,'EAT','2025-09-12 09:29:54.506164','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-12 00:29:54'),(26,'OOPS','2025-09-12 09:29:57.667562','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:29:57'),(27,'OOPS','2025-09-12 09:29:59.243186','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:29:59'),(28,'OOPS','2025-09-12 09:30:01.077923','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:30:01'),(29,'OOPS','2025-09-12 09:30:02.652869','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:30:02'),(30,'OOPS','2025-09-12 09:30:03.938854','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:30:04'),(31,'RESTORE','2025-09-12 09:30:38.586767','{\"reason\": \"init\", \"character\": \"(U･ᴥ･U)\"}','2025-09-12 00:30:38'),(32,'OOPS','2025-09-12 09:30:43.739994','{\"state\": \"HURT\", \"delta_health\": -90}','2025-09-12 00:30:43'),(33,'EAT','2025-09-12 09:30:49.327935','{\"by\": \"eat.sh\", \"set_health\": 100}','2025-09-12 00:30:49'),(34,'RESTORE','2025-09-12 09:32:59.269899','{\"reason\": \"init\", \"character\": \"(•ᴗ•)و\"}','2025-09-12 00:32:59');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_state`
--

DROP TABLE IF EXISTS `game_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_state` (
  `id` tinyint unsigned NOT NULL DEFAULT '1',
  `icon_normal` varchar(32) NOT NULL,
  `icon_eat` varchar(32) NOT NULL,
  `icon_pain` varchar(32) NOT NULL,
  `health` int NOT NULL DEFAULT '100',
  `mood` enum('NORMAL','EAT','PAIN') NOT NULL DEFAULT 'NORMAL',
  `last_backup_at` datetime(6) DEFAULT NULL,
  `last_oops_at` datetime(6) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_state`
--

LOCK TABLES `game_state` WRITE;
/*!40000 ALTER TABLE `game_state` DISABLE KEYS */;
INSERT INTO `game_state` VALUES (1,'(•ᴗ•)و','(•ᴗ•)و🍚','(•╥﹏╥•)',90,'NORMAL',NULL,NULL,'2025-09-12 00:33:05');
/*!40000 ALTER TABLE `game_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pitr_meta`
--

DROP TABLE IF EXISTS `pitr_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitr_meta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_dump` varchar(255) NOT NULL,
  `meta_text` text NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_pitr_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitr_meta`
--

LOCK TABLES `pitr_meta` WRITE;
/*!40000 ALTER TABLE `pitr_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitr_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tamaDB'
--

--
-- Dumping routines for database 'tamaDB'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-12  9:33:05
