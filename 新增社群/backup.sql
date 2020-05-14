-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: socialgroup_1
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `broadcast`
--

DROP TABLE IF EXISTS `broadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcast` (
  `broadcast_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reported_count` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(60) NOT NULL,
  `content` varchar(600) NOT NULL,
  `create_date` datetime NOT NULL,
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0',
  `dislike_count` int(10) unsigned NOT NULL DEFAULT '0',
  `picture_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`broadcast_id`),
  UNIQUE KEY `broadcast_id_UNIQUE` (`broadcast_id`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `broadcast_comment`
--

DROP TABLE IF EXISTS `broadcast_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcast_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `broadcast_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content` varchar(300) NOT NULL,
  `create_date` datetime NOT NULL,
  `reply_count` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`broadcast_comment_AFTER_INSERT` AFTER INSERT ON `broadcast_comment` FOR EACH ROW
BEGIN
 UPDATE broadcast set comment_count = comment_count + 1 where broadcast_id = new.broadcast_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `broadcast_reply`
--

DROP TABLE IF EXISTS `broadcast_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcast_reply` (
  `reply_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `broadcast_id` int(10) unsigned NOT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  `reply_from_user_id` int(10) unsigned NOT NULL,
  `reply_to_user_id` int(10) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content` varchar(300) NOT NULL,
  `create_date` datetime NOT NULL,
  `reply_to_user_nickname` varchar(20) NOT NULL,
  PRIMARY KEY (`reply_id`),
  UNIQUE KEY `reply_id_UNIQUE` (`reply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`broadcast_reply_AFTER_INSERT` AFTER INSERT ON `broadcast_reply` FOR EACH ROW
BEGIN
 UPDATE broadcast set comment_count = comment_count + 1 where broadcast_id = new.broadcast_id;
 UPDATE broadcast_comment set reply_count = reply_count + 1 where comment_id = new.comment_id;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `circle`
--

DROP TABLE IF EXISTS `circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circle` (
  `circle_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content` varchar(500) NOT NULL,
  `create_date` datetime NOT NULL,
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `like_count` int(10) unsigned NOT NULL DEFAULT '0',
  `picture_count` int(10) unsigned NOT NULL DEFAULT '0',
  `reported_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`circle_id`),
  UNIQUE KEY `circle_id_UNIQUE` (`circle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `circle_comment`
--

DROP TABLE IF EXISTS `circle_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circle_comment` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `circle_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content` varchar(200) NOT NULL,
  `create_date` datetime NOT NULL,
  `reply_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `comment_id_UNIQUE` (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`circle_comment_AFTER_INSERT` AFTER INSERT ON `circle_comment` FOR EACH ROW
BEGIN
 UPDATE circle set comment_count = comment_count + 1 where circle_id = new.circle_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `circle_reply`
--

DROP TABLE IF EXISTS `circle_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circle_reply` (
  `reply_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `circle_id` int(10) unsigned NOT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  `reply_from_user_id` int(10) unsigned NOT NULL,
  `reply_to_user_id` int(10) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content` varchar(200) NOT NULL,
  `create_date` datetime NOT NULL,
  `reply_to_user_nickname` varchar(45) NOT NULL,
  PRIMARY KEY (`reply_id`),
  UNIQUE KEY `reply_id_UNIQUE` (`reply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`circle_reply_AFTER_INSERT` AFTER INSERT ON `circle_reply` FOR EACH ROW
BEGIN
 UPDATE circle set comment_count = comment_count + 1 where circle_id = new.circle_id;
 UPDATE circle_comment set reply_count = reply_count + 1 where comment_id = new.comment_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `judge`
--

DROP TABLE IF EXISTS `judge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `judge` (
  `judge_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `judge_type` tinyint(3) unsigned NOT NULL,
  `square_item_type` tinyint(4) NOT NULL,
  `square_item_id` int(10) unsigned NOT NULL,
  `from_user_id` int(10) unsigned NOT NULL,
  `canceled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`judge_id`),
  UNIQUE KEY `judge_id_UNIQUE` (`judge_id`),
  UNIQUE KEY `judge_type` (`judge_type`,`square_item_type`,`square_item_id`,`from_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`judge_AFTER_INSERT` AFTER INSERT ON `judge` FOR EACH ROW
BEGIN
if(new.square_item_type = 1) then
	if(new.judge_type = 1) then
		update broadcast set like_count = like_count + 1 where broadcast_id = new.square_item_id;
	elseif(new.judge_type = 2) then
		update broadcast set dislike_count = dislike_count + 1 where broadcast_id = new.square_item_id;
	elseif(new.judge_type = 3) then
		update broadcast set reported_count = reported_count + 1 where broadcast_id = new.square_item_id;
	end if;
elseif(new.square_item_type = 2) then
	if(new.judge_type = 1) then
		update circle set like_count = like_count + 1 where circle_id = new.square_item_id;
	elseif(new.judge_type = 2) then
		update circle set dislike_count = dislike_count + 1 where circle_id = new.square_item_id;
	elseif(new.judge_type = 3) then
		update circle set reported_count = reported_count + 1 where circle_id = new.square_item_id;
	end if;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`judge_AFTER_DELETE` AFTER DELETE ON `judge` FOR EACH ROW
BEGIN
if(old.square_item_type = 1) then
	if(old.judge_type = 1) then
		update broadcast set like_count = like_count - 1 where broadcast_id = old.square_item_id;
	elseif(old.judge_type = 2) then
		update broadcast set dislike_count = dislike_count - 1 where broadcast_id = old.square_item_id;
	elseif(old.judge_type = 3) then
		update broadcast set reported_count = reported_count - 1 where broadcast_id = old.square_item_id;
	end if;
elseif(old.square_item_type = 2) then
	if(old.judge_type = 1) then
		update circle set like_count = like_count - 1 where circle_id = old.square_item_id;
	elseif(old.judge_type = 2) then
		update circle set dislike_count = dislike_count - 1 where circle_id = old.square_item_id;
	elseif(old.judge_type = 3) then
		update circle set reported_count = reported_count - 1 where circle_id = old.square_item_id;
	end if;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `user_nickname` varchar(20) NOT NULL,
  `user_avatar` int(10) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  UNIQUE KEY `notification_id_UNIQUE` (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_poster`
--

DROP TABLE IF EXISTS `notification_poster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_poster` (
  `notification_poster_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` int(10) unsigned NOT NULL,
  `brief` varchar(20) NOT NULL,
  `welcome` varchar(200) NOT NULL,
  `hold_date` varchar(50) NOT NULL,
  `hold_location` varchar(50) NOT NULL,
  `holder` varchar(50) NOT NULL,
  `detail` varchar(400) NOT NULL,
  `link` varchar(200) NOT NULL,
  PRIMARY KEY (`notification_poster_id`),
  UNIQUE KEY `notification_poster_id_UNIQUE` (`notification_poster_id`),
  UNIQUE KEY `notification_id_UNIQUE` (`notification_id`),
  CONSTRAINT `notification_id` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`notification_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_message`
--

DROP TABLE IF EXISTS `push_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_message` (
  `push_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `content` varchar(500) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`push_message_id`),
  UNIQUE KEY `push_message_id_UNIQUE` (`push_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stick`
--

DROP TABLE IF EXISTS `stick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stick` (
  `stick_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stick_from_user_id` int(10) unsigned NOT NULL,
  `stick_to_user_id` int(10) unsigned NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`stick_id`),
  UNIQUE KEY `stick_id_UNIQUE` (`stick_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`tangjiahua`@`localhost`*/ /*!50003 TRIGGER `socialgroup_1`.`stick_AFTER_INSERT` AFTER INSERT ON `stick` FOR EACH ROW
BEGIN
update user_profile set stick_count = stick_count + 1 where user_id = new.stick_to_user_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `user_profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `nickname` varchar(20) NOT NULL DEFAULT '暂未填写',
  `realname` varchar(10) NOT NULL DEFAULT '暂未填写',
  `gender` char(1) NOT NULL DEFAULT 'm',
  `age` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `avatar` int(10) unsigned NOT NULL DEFAULT '0',
  `background` int(10) unsigned NOT NULL DEFAULT '0',
  `stick_count` int(10) unsigned NOT NULL DEFAULT '0',
  `wall_picture_count` int(10) unsigned NOT NULL DEFAULT '0',
  `public_introduce` varchar(800) DEFAULT '暂未填写',
  `private_introduce` varchar(400) DEFAULT '暂未填写',
  `grade` varchar(4) NOT NULL DEFAULT '暂未填写',
  `hometown` varchar(20) NOT NULL DEFAULT '暂未填写',
  `major` varchar(20) NOT NULL DEFAULT '暂未填写',
  `relationship_status` varchar(20) NOT NULL DEFAULT '暂未填写',
  `role` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_profile_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `user_profile_id_UNIQUE` (`user_profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'socialgroup_1'
--

--
-- Dumping routines for database 'socialgroup_1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-14 16:44:05
