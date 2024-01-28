CREATE DATABASE  IF NOT EXISTS `group_buy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `group_buy`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: group_buy
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cartId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `isCheckout` tinyint(1) DEFAULT '0',
  `checkoutTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cartId`),
  KEY `userId` (`userId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (201,101,1,'2024-01-21 16:48:42'),(202,102,0,NULL),(203,103,1,'2024-01-21 16:48:42'),(204,103,0,NULL),(205,101,1,'2024-01-21 16:48:42'),(206,101,1,'2024-01-21 17:40:02'),(207,101,1,'2024-01-21 17:41:50'),(208,101,1,'2024-01-22 08:34:42'),(209,101,1,'2024-01-23 08:43:17'),(210,101,1,'2024-01-26 08:13:27');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartitem`
--

DROP TABLE IF EXISTS `cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartitem` (
  `itemId` int NOT NULL AUTO_INCREMENT,
  `cartId` int NOT NULL,
  `productId` int NOT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`itemId`),
  KEY `cartId` (`cartId`),
  KEY `cartitem_ibfk_2` (`productId`),
  CONSTRAINT `cartitem_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`),
  CONSTRAINT `cartitem_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartitem`
--

LOCK TABLES `cartitem` WRITE;
/*!40000 ALTER TABLE `cartitem` DISABLE KEYS */;
INSERT INTO `cartitem` VALUES (1,201,501,10),(5,203,504,20),(6,205,505,15),(7,206,505,1),(8,207,503,1),(9,208,501,2),(10,209,505,2),(11,210,505,2);
/*!40000 ALTER TABLE `cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level` (
  `levelId` int NOT NULL,
  `levelName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`levelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` VALUES (1,'一般客戶'),(2,'內部員工');
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level_ref_service`
--

DROP TABLE IF EXISTS `level_ref_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level_ref_service` (
  `levelId` int NOT NULL,
  `serviceId` int NOT NULL,
  `sort` int DEFAULT '1',
  UNIQUE KEY `unique_sid_and_aid` (`levelId`,`serviceId`),
  KEY `serviceId` (`serviceId`),
  CONSTRAINT `level_ref_service_ibfk_1` FOREIGN KEY (`levelId`) REFERENCES `level` (`levelId`),
  CONSTRAINT `level_ref_service_ibfk_2` FOREIGN KEY (`serviceId`) REFERENCES `service` (`serviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level_ref_service`
--

LOCK TABLES `level_ref_service` WRITE;
/*!40000 ALTER TABLE `level_ref_service` DISABLE KEYS */;
INSERT INTO `level_ref_service` VALUES (1,1,1),(1,2,3),(1,3,5),(1,4,4),(1,5,2),(2,1,1),(2,2,2),(2,3,6),(2,4,7),(2,51,3),(2,52,4),(2,53,5);
/*!40000 ALTER TABLE `level_ref_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(50) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `isLaunch` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=511 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (501,'Beer',300.00,'Pack',0),(503,'Dress',600.00,'Clothing',0),(504,'Car',900000.00,'Set',0),(505,'Phone',25000.00,'Set',0);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `serviceId` int NOT NULL,
  `serviceLocation` varchar(50) DEFAULT NULL,
  `serviceName` varchar(50) DEFAULT NULL,
  `serviceUrl` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`serviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'frontend','✋團購首頁','/mvc/group_buy/frontend/main'),(2,'frontend','? 購物車','/mvc/group_buy/frontend/cart'),(3,'frontend','? 登出','/mvc/group_buy/logout'),(4,'frontend','? Profile','/mvc/group_buy/frontend/profile'),(5,'frontend','?商品頁面','/mvc/group_buy/frontend/product'),(51,'backend','?後台報告','/mvc/group_buy/backend/report'),(52,'backend','➕商品新增','/mvc/group_buy/backend/main'),(53,'backend','➖商品刪除','/mvc/group_buy/backend/delete');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` int DEFAULT NULL,
  `authType` enum('local','github','google') DEFAULT 'local',
  `authId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (101,'user123','JqKLj+4Aw3DnndH0MHUQkg==',1,'local',NULL),(102,'user456','ormIciIAHZjZjQYphMuCHQ==',2,'local',NULL),(103,'user789','Nj8ZE1H01l0cDeX/GskzXg==',1,'local',NULL),(104,'Edward3241','None',1,'github','132114665');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `usertotalamountview`
--

DROP TABLE IF EXISTS `usertotalamountview`;
/*!50001 DROP VIEW IF EXISTS `usertotalamountview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usertotalamountview` AS SELECT 
 1 AS `userId`,
 1 AS `username`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'group_buy'
--

--
-- Final view structure for view `usertotalamountview`
--

/*!50001 DROP VIEW IF EXISTS `usertotalamountview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`web`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `usertotalamountview` AS select `u`.`userId` AS `userId`,`u`.`username` AS `username`,coalesce(sum((`p`.`price` * `ci`.`quantity`)),0) AS `total` from (((`user` `u` left join `cart` `c` on((`u`.`userId` = `c`.`userId`))) left join `cartitem` `ci` on((`c`.`cartId` = `ci`.`cartId`))) left join `product` `p` on((`ci`.`productId` = `p`.`productId`))) where (`c`.`isCheckout` = true) group by `u`.`userId`,`u`.`username` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-26  9:43:29
