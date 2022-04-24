-- MariaDB dump 10.19  Distrib 10.7.3-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database:
-- ------------------------------------------------------
-- Server version	10.7.3-MariaDB-1:10.7.3+maria~focal

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
-- Current Database: `Website`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Website` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `Website`;

--
-- Table structure for table `altlink`
--

DROP TABLE IF EXISTS `altlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `altlink` (
  `id` binary(16) NOT NULL,
  `alias` varchar(45) NOT NULL,
  `target` varchar(2048) NOT NULL,
  `access_limit` int(11) NOT NULL,
  `access_cnt` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_auth`
--

DROP TABLE IF EXISTS `api_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_auth` (
  `auth_token` binary(32) NOT NULL,
  `auth_token_exp` datetime NOT NULL,
  `access_level` int(2) unsigned NOT NULL DEFAULT 1,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`auth_token`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatroom`
--

DROP TABLE IF EXISTS `chatroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatroom` (
  `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatroom_command`
--

DROP TABLE IF EXISTS `chatroom_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatroom_command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` varchar(45) NOT NULL,
  `response` text NOT NULL,
  `description` varchar(120) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prefix_UNIQUE` (`command`)
) ENGINE=InnoDB AUTO_INCREMENT=625 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatroom_scheduler`
--

DROP TABLE IF EXISTS `chatroom_scheduler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatroom_scheduler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(250) NOT NULL,
  `message` varchar(250) NOT NULL,
  `tweet` varchar(250) NOT NULL,
  `start_time` time NOT NULL DEFAULT '00:00:00',
  `sunday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `monday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `tuesday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `wednesday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `thursday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `friday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `saturday_flag` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command_image`
--

DROP TABLE IF EXISTS `command_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_image` (
  `command` varchar(45) NOT NULL,
  `local_url` varchar(250) NOT NULL,
  `imgur_url` varchar(250) DEFAULT NULL,
  `meta` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`command`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guild_info`
--

DROP TABLE IF EXISTS `guild_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_info` (
  `id` varchar(45) NOT NULL,
  `name` varchar(200) NOT NULL,
  `owner_id` varchar(45) NOT NULL,
  `prefix` varchar(3) NOT NULL DEFAULT '!',
  `created_on` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `led`
--

DROP TABLE IF EXISTS `led`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `led` (
  `user_id` int(11) unsigned NOT NULL,
  `white` int(10) unsigned NOT NULL DEFAULT 0,
  `orange` int(10) unsigned NOT NULL DEFAULT 0,
  `yellow` int(10) unsigned NOT NULL DEFAULT 0,
  `green` int(10) unsigned NOT NULL DEFAULT 0,
  `blue` int(10) unsigned NOT NULL DEFAULT 0,
  `cyan` int(10) unsigned NOT NULL DEFAULT 0,
  `purple` int(10) unsigned NOT NULL DEFAULT 0,
  `red` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_bet`
--

DROP TABLE IF EXISTS `matches_bet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_bet` (
  `user_id` int(11) unsigned NOT NULL,
  `match_id` int(10) unsigned NOT NULL,
  `team` int(10) unsigned NOT NULL,
  `points` bigint(20) unsigned NOT NULL,
  `dt_placed` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`user_bet_AFTER_INSERT` AFTER INSERT ON `matches_bet` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
	CALL `usp_matches_upd_bet_calculation`(NEW.match_id);

    INSERT INTO `matches_stats` (user_id, season, wins, losses, ratings, rating_points, daily_points, bet_points, total_points, available_points, updated)
		SELECT *, NOW() FROM `uv_matches_stats_calc_s5` vusc
	ON DUPLICATE KEY UPDATE
		wins=vusc.wins,
		losses=vusc.losses,
		ratings=vusc.ratings,
		rating_points=vusc.rating_points,
		daily_points=vusc.daily_points,
		bet_points=vusc.bet_points,
		total_points=vusc.total_points,
		available_points=vusc.available_points,
		updated=NOW();
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`user_bet_AFTER_UPDATE` AFTER UPDATE ON `matches_bet` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
	CALL `usp_matches_upd_bet_calculation`(NEW.match_id);

    INSERT INTO `matches_stats` (user_id, season, wins, losses, ratings, rating_points, daily_points, bet_points, total_points, available_points, updated)
		SELECT *, NOW() FROM `uv_matches_stats_calc_s5` vusc
	ON DUPLICATE KEY UPDATE
		wins=vusc.wins,
		losses=vusc.losses,
		ratings=vusc.ratings,
		rating_points=vusc.rating_points,
		daily_points=vusc.daily_points,
		bet_points=vusc.bet_points,
		total_points=vusc.total_points,
		available_points=vusc.available_points,
		updated=NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `matches_bet_calculation`
--

DROP TABLE IF EXISTS `matches_bet_calculation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_bet_calculation` (
  `match_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `points` bigint(20) unsigned NOT NULL,
  `team_base_pot` bigint(20) unsigned NOT NULL,
  `potential_pot` bigint(20) unsigned NOT NULL,
  `potential_cut_pct` decimal(40,20) unsigned NOT NULL,
  `potential_cut_points` bigint(20) unsigned NOT NULL,
  `bet_won` tinyint(1) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`match_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_brand`
--

DROP TABLE IF EXISTS `matches_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_brand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_contestant`
--

DROP TABLE IF EXISTS `matches_contestant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_contestant` (
  `match_id` int(10) unsigned NOT NULL DEFAULT 0,
  `superstar_id` int(10) unsigned NOT NULL DEFAULT 1,
  `team` int(10) unsigned NOT NULL DEFAULT 0,
  `bet_multiplier` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`match_id`,`superstar_id`,`team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`match_contestant_AFTER_INSERT` AFTER INSERT ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`match_contestant_AFTER_UPDATE` AFTER UPDATE ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`match_contestant_AFTER_DELETE` AFTER DELETE ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(OLD.match_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `matches_event`
--

DROP TABLE IF EXISTS `matches_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ppv` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=435 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_favorite_superstar`
--

DROP TABLE IF EXISTS `matches_favorite_superstar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_favorite_superstar` (
  `user_id` int(11) NOT NULL,
  `superstar_id` int(11) NOT NULL DEFAULT 1,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_match`
--

DROP TABLE IF EXISTS `matches_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_match` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL DEFAULT 0,
  `title_id` int(10) unsigned NOT NULL DEFAULT 0,
  `match_type_id` int(10) unsigned NOT NULL DEFAULT 1,
  `match_note` varchar(200) NOT NULL,
  `team_won` int(10) unsigned NOT NULL DEFAULT 0,
  `winner_note` varchar(200) NOT NULL DEFAULT '',
  `bet_open` tinyint(1) NOT NULL DEFAULT 0,
  `last_updated_by` int(10) NOT NULL DEFAULT 0,
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1270 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`match_AFTER_INSERT` AFTER INSERT ON `matches_match` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.id);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`match_AFTER_UPDATE` AFTER UPDATE ON `matches_match` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.id);
    CALL `usp_matches_upd_bet_calculation`(NEW.id);

    INSERT INTO `matches_stats` (user_id, season, wins, losses, ratings, rating_points, daily_points, bet_points, total_points, available_points, updated)
		SELECT *, NOW() FROM `uv_matches_stats_calc_s5` vusc
	ON DUPLICATE KEY UPDATE
		wins=vusc.wins,
		losses=vusc.losses,
		ratings=vusc.ratings,
		rating_points=vusc.rating_points,
		daily_points=vusc.daily_points,
		bet_points=vusc.bet_points,
		total_points=vusc.total_points,
		available_points=vusc.available_points,
		updated=NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `matches_match_calculation`
--

DROP TABLE IF EXISTS `matches_match_calculation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_match_calculation` (
  `match_id` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `pot_valid` tinyint(1) NOT NULL,
  `contestants` text NOT NULL,
  `contestants_won` text NOT NULL,
  `contestants_lost` text NOT NULL,
  `bet_multiplier` int(11) NOT NULL,
  `base_pot` bigint(20) unsigned NOT NULL,
  `base_winner_pot` bigint(20) unsigned NOT NULL,
  `base_loser_pot` bigint(20) unsigned NOT NULL,
  `user_bet_cnt` int(11) NOT NULL,
  `user_bet_winner_cnt` int(11) NOT NULL,
  `user_bet_loser_cnt` int(11) NOT NULL,
  `user_rating_avg` double NOT NULL,
  `user_rating_cnt` int(11) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_match_rating`
--

DROP TABLE IF EXISTS `matches_match_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_match_rating` (
  `user_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `rating` double unsigned NOT NULL,
  `updates` int(10) unsigned NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`user_match_rating_AFTER_INSERT` AFTER INSERT ON `matches_match_rating` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`user_match_rating_AFTER_UPDATE` AFTER UPDATE ON `matches_match_rating` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `matches_match_type`
--

DROP TABLE IF EXISTS `matches_match_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_match_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_royalrumble`
--

DROP TABLE IF EXISTS `matches_royalrumble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_royalrumble` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `event_id` int(11) unsigned NOT NULL,
  `entry_max` tinyint(2) NOT NULL DEFAULT 30,
  `entry_won` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_royalrumble_entry`
--

DROP TABLE IF EXISTS `matches_royalrumble_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_royalrumble_entry` (
  `royalrumble_id` int(11) NOT NULL,
  `display_name` varchar(25) NOT NULL,
  `entry` tinyint(2) NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  PRIMARY KEY (`royalrumble_id`,`display_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_season`
--

DROP TABLE IF EXISTS `matches_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_season` (
  `season` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_matchid` int(11) NOT NULL,
  `end_matchid` int(11) DEFAULT NULL,
  PRIMARY KEY (`season`),
  UNIQUE KEY `start_matchid_UNIQUE` (`start_matchid`),
  UNIQUE KEY `end_matchid_UNIQUE` (`end_matchid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_stable`
--

DROP TABLE IF EXISTS `matches_stable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_stable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `page_url` varchar(2083) NOT NULL,
  `image_url` varchar(2083) NOT NULL,
  `bio` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_stable_member`
--

DROP TABLE IF EXISTS `matches_stable_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_stable_member` (
  `stable_id` int(11) NOT NULL,
  `superstar_id` int(11) NOT NULL,
  PRIMARY KEY (`stable_id`,`superstar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_stats`
--

DROP TABLE IF EXISTS `matches_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_stats` (
  `user_id` int(11) unsigned NOT NULL,
  `season` int(10) unsigned NOT NULL,
  `wins` int(11) unsigned NOT NULL DEFAULT 0,
  `losses` int(11) unsigned NOT NULL DEFAULT 0,
  `ratings` int(11) NOT NULL DEFAULT 0,
  `rating_points` int(11) NOT NULL DEFAULT 0,
  `daily_points` int(10) unsigned NOT NULL DEFAULT 0,
  `bet_points` bigint(20) NOT NULL DEFAULT 0,
  `total_points` bigint(20) unsigned NOT NULL DEFAULT 0,
  `available_points` bigint(20) unsigned NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_id`,`season`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_superstar`
--

DROP TABLE IF EXISTS `matches_superstar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_superstar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `brand_id` int(11) NOT NULL DEFAULT 0,
  `height` varchar(10) NOT NULL DEFAULT '',
  `weight` varchar(10) NOT NULL DEFAULT '',
  `hometown` varchar(45) NOT NULL DEFAULT '',
  `dob` date DEFAULT NULL,
  `signature_move` varchar(200) NOT NULL DEFAULT '',
  `page_url` varchar(2083) NOT NULL DEFAULT '',
  `image_url` varchar(2083) NOT NULL DEFAULT '',
  `bio` text NOT NULL DEFAULT '',
  `twitter_id` varchar(16) NOT NULL DEFAULT '',
  `twitter_username` varchar(45) NOT NULL DEFAULT '',
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=506 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matches_title`
--

DROP TABLE IF EXISTS `matches_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_title` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_item`
--

DROP TABLE IF EXISTS `poll_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_item` (
  `id` binary(16) NOT NULL,
  `topic_id` binary(16) NOT NULL,
  `content` varchar(50) NOT NULL,
  `votes` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_topic`
--

DROP TABLE IF EXISTS `poll_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_topic` (
  `id` binary(16) NOT NULL,
  `content` varchar(100) NOT NULL,
  `allow_multi` tinyint(1) NOT NULL DEFAULT 0,
  `hide_votes` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` int(11) unsigned DEFAULT NULL,
  `votes` int(10) unsigned NOT NULL DEFAULT 0,
  `expire_dt` datetime NOT NULL,
  `created_dt` datetime NOT NULL,
  `admin_hide` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_vote`
--

DROP TABLE IF EXISTS `poll_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_vote` (
  `id` binary(16) NOT NULL,
  `topic_id` binary(16) NOT NULL,
  `item_id` binary(16) NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `created_dt` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Update vote count on poll_item and poll_topic';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`poll_vote_AFTER_INSERT` AFTER INSERT ON `poll_vote` FOR EACH ROW
BEGIN
    UPDATE `Website`.`poll_item`
    SET `Website`.`poll_item`.`votes`=`Website`.`poll_item`.`votes`+1
    WHERE `Website`.`poll_item`.`id`=NEW.item_id;

    UPDATE `Website`.`poll_topic`
    SET `Website`.`poll_topic`.`votes`=`Website`.`poll_topic`.`votes`+1
    WHERE `Website`.`poll_topic`.`id`=NEW.topic_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `quote`
--

DROP TABLE IF EXISTS `quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quote` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quote` varchar(200) DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic`
--

DROP TABLE IF EXISTS `traffic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic` (
  `id` binary(16) NOT NULL,
  `request_id` binary(16) NOT NULL,
  `user_agent_id` binary(16) NOT NULL,
  `ip_id` binary(16) NOT NULL,
  `auth_user_id` int(11) DEFAULT NULL,
  `response_code` int(10) unsigned DEFAULT NULL,
  `response_updated` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_ip`
--

DROP TABLE IF EXISTS `traffic_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic_ip` (
  `id` binary(16) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  `access_cnt` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_UNIQUE` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_request`
--

DROP TABLE IF EXISTS `traffic_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic_request` (
  `id` binary(16) NOT NULL,
  `request` text NOT NULL,
  `md5hash` binary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  `access_cnt` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5hash_UNIQUE` (`md5hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_user_agent`
--

DROP TABLE IF EXISTS `traffic_user_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic_user_agent` (
  `id` binary(16) NOT NULL,
  `user_agent` text NOT NULL,
  `md5hash` binary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  `access_cnt` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5hash_UNIQUE` (`md5hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `username_last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `secret` binary(60) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `secret_last_updated` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `access` int(2) unsigned NOT NULL DEFAULT 1,
  `login_token` varchar(255) DEFAULT NULL,
  `login_token_exp` datetime DEFAULT NULL,
  `temp_secret` varchar(255) DEFAULT NULL,
  `temp_secret_exp` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_last_updated` datetime DEFAULT NULL,
  `twitter_id` varchar(45) DEFAULT NULL,
  `twitter_last_updated` datetime DEFAULT NULL,
  `discord_id` varchar(45) DEFAULT NULL,
  `discord_last_updated` datetime DEFAULT NULL,
  `chatango_id` varchar(45) DEFAULT NULL,
  `chatango_last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `twitter_id_UNIQUE` (`twitter_id`),
  UNIQUE KEY `discord_id_UNIQUE` (`discord_id`),
  UNIQUE KEY `chatango_id_UNIQUE` (`chatango_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`user_AFTER_INSERT` AFTER INSERT ON `user` FOR EACH ROW
BEGIN
	CALL `usp_matches_ins_stats`(NEW.id);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `Website`.`user_AFTER_UPDATE` AFTER UPDATE ON `user` FOR EACH ROW
BEGIN
	IF NOT (NEW.username <=> OLD.username) THEN
		INSERT INTO `user_username_history`
			(`id`, `user_id`, `old_username`,  `new_username`, `created`)
        VALUES
			(UUID_TO_BIN(UUID()), NEW.id, OLD.username, NEW.username, NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_username_history`
--

DROP TABLE IF EXISTS `user_username_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_username_history` (
  `id` binary(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `old_username` varchar(25) NOT NULL,
  `new_username` varchar(25) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `uv_matches`
--

DROP TABLE IF EXISTS `uv_matches`;
/*!50001 DROP VIEW IF EXISTS `uv_matches`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches` (
  `id` tinyint NOT NULL,
  `completed` tinyint NOT NULL,
  `pot_valid` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `event` tinyint NOT NULL,
  `title` tinyint NOT NULL,
  `match_type` tinyint NOT NULL,
  `match_note` tinyint NOT NULL,
  `contestants` tinyint NOT NULL,
  `team_won` tinyint NOT NULL,
  `contestants_won` tinyint NOT NULL,
  `contestants_lost` tinyint NOT NULL,
  `winner_note` tinyint NOT NULL,
  `bet_open` tinyint NOT NULL,
  `bet_multiplier` tinyint NOT NULL,
  `base_loser_pot` tinyint NOT NULL,
  `base_winner_pot` tinyint NOT NULL,
  `base_pot` tinyint NOT NULL,
  `total_pot` tinyint NOT NULL,
  `user_bet_cnt` tinyint NOT NULL,
  `user_bet_loser_cnt` tinyint NOT NULL,
  `user_bet_winner_cnt` tinyint NOT NULL,
  `user_rating_avg` tinyint NOT NULL,
  `user_rating_cnt` tinyint NOT NULL,
  `event_id` tinyint NOT NULL,
  `title_id` tinyint NOT NULL,
  `match_type_id` tinyint NOT NULL,
  `info_last_updated` tinyint NOT NULL,
  `info_last_updated_by_id` tinyint NOT NULL,
  `info_last_updated_by_username` tinyint NOT NULL,
  `calc_last_updated` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_all`
--

DROP TABLE IF EXISTS `uv_matches_all`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_all`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_all` (
  `id` tinyint NOT NULL,
  `event_id` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `event` tinyint NOT NULL,
  `title_id` tinyint NOT NULL,
  `title` tinyint NOT NULL,
  `match_type_id` tinyint NOT NULL,
  `match_type` tinyint NOT NULL,
  `match_note` tinyint NOT NULL,
  `superstars` tinyint NOT NULL,
  `team_won` tinyint NOT NULL,
  `winner_note` tinyint NOT NULL,
  `bet_open` tinyint NOT NULL,
  `last_updated` tinyint NOT NULL,
  `last_updated_by` tinyint NOT NULL,
  `user_rating_avg` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_all_bets`
--

DROP TABLE IF EXISTS `uv_matches_all_bets`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_all_bets`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_all_bets` (
  `id` tinyint NOT NULL,
  `bet_multiplier` tinyint NOT NULL,
  `base_loser_pot` tinyint NOT NULL,
  `base_winner_pot` tinyint NOT NULL,
  `base_pot` tinyint NOT NULL,
  `total_pot` tinyint NOT NULL,
  `loser_bet_cnt` tinyint NOT NULL,
  `winner_bet_cnt` tinyint NOT NULL,
  `bet_cnt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_last_updated_by`
--

DROP TABLE IF EXISTS `uv_matches_last_updated_by`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_last_updated_by`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_last_updated_by` (
  `user_id` tinyint NOT NULL,
  `last_updated_by` tinyint NOT NULL,
  `match_cnt` tinyint NOT NULL,
  `min_match_id` tinyint NOT NULL,
  `min_dt` tinyint NOT NULL,
  `max_match_id` tinyint NOT NULL,
  `max_dt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_match_calculation`
--

DROP TABLE IF EXISTS `uv_matches_match_calculation`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_match_calculation`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_match_calculation` (
  `id` tinyint NOT NULL,
  `contestants` tinyint NOT NULL,
  `contestants_won` tinyint NOT NULL,
  `contestants_lost` tinyint NOT NULL,
  `bet_multiplier` tinyint NOT NULL,
  `base_pot` tinyint NOT NULL,
  `base_winner_pot` tinyint NOT NULL,
  `base_loser_pot` tinyint NOT NULL,
  `user_bet_cnt` tinyint NOT NULL,
  `user_bet_winner_cnt` tinyint NOT NULL,
  `user_bet_loser_cnt` tinyint NOT NULL,
  `user_rating_avg` tinyint NOT NULL,
  `user_rating_cnt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_match_detail`
--

DROP TABLE IF EXISTS `uv_matches_match_detail`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_match_detail`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_match_detail` (
  `id` tinyint NOT NULL,
  `event_id` tinyint NOT NULL,
  `title_id` tinyint NOT NULL,
  `match_type_id` tinyint NOT NULL,
  `match_note` tinyint NOT NULL,
  `team_won` tinyint NOT NULL,
  `winner_note` tinyint NOT NULL,
  `bet_open` tinyint NOT NULL,
  `info_last_updated_by_id` tinyint NOT NULL,
  `info_last_updated` tinyint NOT NULL,
  `completed` tinyint NOT NULL,
  `pot_valid` tinyint NOT NULL,
  `contestants` tinyint NOT NULL,
  `contestants_won` tinyint NOT NULL,
  `contestants_lost` tinyint NOT NULL,
  `bet_multiplier` tinyint NOT NULL,
  `base_pot` tinyint NOT NULL,
  `total_pot` tinyint NOT NULL,
  `base_winner_pot` tinyint NOT NULL,
  `base_loser_pot` tinyint NOT NULL,
  `user_bet_cnt` tinyint NOT NULL,
  `user_bet_winner_cnt` tinyint NOT NULL,
  `user_bet_loser_cnt` tinyint NOT NULL,
  `user_rating_avg` tinyint NOT NULL,
  `user_rating_cnt` tinyint NOT NULL,
  `calc_last_updated` tinyint NOT NULL,
  `event` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `title` tinyint NOT NULL,
  `match_type` tinyint NOT NULL,
  `last_updated_by_username` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_match_rating`
--

DROP TABLE IF EXISTS `uv_matches_match_rating`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_match_rating`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_match_rating` (
  `id` tinyint NOT NULL,
  `user_rating_avg` tinyint NOT NULL,
  `user_rating_cnt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_royalrumble`
--

DROP TABLE IF EXISTS `uv_matches_royalrumble`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_royalrumble`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_royalrumble` (
  `royalrumble_id` tinyint NOT NULL,
  `event_dt` tinyint NOT NULL,
  `event_name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `entry_max` tinyint NOT NULL,
  `entry_won` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `entry` tinyint NOT NULL,
  `comment` tinyint NOT NULL,
  `entered` tinyint NOT NULL,
  `winner` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_season_rating`
--

DROP TABLE IF EXISTS `uv_matches_season_rating`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_season_rating`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_season_rating` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `rating_cnt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats`
--

DROP TABLE IF EXISTS `uv_matches_stats`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats` (
  `user_id` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `date_created` tinyint NOT NULL,
  `favorite_superstar_id` tinyint NOT NULL,
  `s1_wins` tinyint NOT NULL,
  `s1_losses` tinyint NOT NULL,
  `s1_ratings` tinyint NOT NULL,
  `s1_rating_points` tinyint NOT NULL,
  `s1_daily_points` tinyint NOT NULL,
  `s1_bet_points` tinyint NOT NULL,
  `s1_total_points` tinyint NOT NULL,
  `s1_available_points` tinyint NOT NULL,
  `s2_wins` tinyint NOT NULL,
  `s2_losses` tinyint NOT NULL,
  `s2_ratings` tinyint NOT NULL,
  `s2_rating_points` tinyint NOT NULL,
  `s2_daily_points` tinyint NOT NULL,
  `s2_bet_points` tinyint NOT NULL,
  `s2_total_points` tinyint NOT NULL,
  `s2_available_points` tinyint NOT NULL,
  `s3_wins` tinyint NOT NULL,
  `s3_losses` tinyint NOT NULL,
  `s3_ratings` tinyint NOT NULL,
  `s3_rating_points` tinyint NOT NULL,
  `s3_daily_points` tinyint NOT NULL,
  `s3_bet_points` tinyint NOT NULL,
  `s3_total_points` tinyint NOT NULL,
  `s3_available_points` tinyint NOT NULL,
  `s4_wins` tinyint NOT NULL,
  `s4_losses` tinyint NOT NULL,
  `s4_ratings` tinyint NOT NULL,
  `s4_rating_points` tinyint NOT NULL,
  `s4_daily_points` tinyint NOT NULL,
  `s4_bet_points` tinyint NOT NULL,
  `s4_total_points` tinyint NOT NULL,
  `s4_available_points` tinyint NOT NULL,
  `s5_wins` tinyint NOT NULL,
  `s5_losses` tinyint NOT NULL,
  `s5_ratings` tinyint NOT NULL,
  `s5_rating_points` tinyint NOT NULL,
  `s5_daily_points` tinyint NOT NULL,
  `s5_bet_points` tinyint NOT NULL,
  `s5_total_points` tinyint NOT NULL,
  `s5_available_points` tinyint NOT NULL,
  `s6_wins` tinyint NOT NULL,
  `s6_losses` tinyint NOT NULL,
  `s6_ratings` tinyint NOT NULL,
  `s6_rating_points` tinyint NOT NULL,
  `s6_daily_points` tinyint NOT NULL,
  `s6_bet_points` tinyint NOT NULL,
  `s6_total_points` tinyint NOT NULL,
  `s6_available_points` tinyint NOT NULL,
  `total_wins` tinyint NOT NULL,
  `total_losses` tinyint NOT NULL,
  `total_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc` (
  `user_id` tinyint NOT NULL,
  `date_created` tinyint NOT NULL,
  `s1_wins` tinyint NOT NULL,
  `s1_losses` tinyint NOT NULL,
  `s1_ratings` tinyint NOT NULL,
  `s1_rating_points` tinyint NOT NULL,
  `s1_daily_points` tinyint NOT NULL,
  `s1_bet_points` tinyint NOT NULL,
  `s1_total_points` tinyint NOT NULL,
  `s1_available_points` tinyint NOT NULL,
  `s2_wins` tinyint NOT NULL,
  `s2_losses` tinyint NOT NULL,
  `s2_ratings` tinyint NOT NULL,
  `s2_rating_points` tinyint NOT NULL,
  `s2_daily_points` tinyint NOT NULL,
  `s2_bet_points` tinyint NOT NULL,
  `s2_total_points` tinyint NOT NULL,
  `s2_available_points` tinyint NOT NULL,
  `s3_wins` tinyint NOT NULL,
  `s3_losses` tinyint NOT NULL,
  `s3_ratings` tinyint NOT NULL,
  `s3_rating_points` tinyint NOT NULL,
  `s3_daily_points` tinyint NOT NULL,
  `s3_bet_points` tinyint NOT NULL,
  `s3_total_points` tinyint NOT NULL,
  `s3_available_points` tinyint NOT NULL,
  `s4_daily_points` tinyint NOT NULL,
  `s4_bet_points` tinyint NOT NULL,
  `s4_total_points` tinyint NOT NULL,
  `s4_available_points` tinyint NOT NULL,
  `total_wins` tinyint NOT NULL,
  `total_losses` tinyint NOT NULL,
  `total_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc_s1`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc_s1`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc_s1` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `wins` tinyint NOT NULL,
  `losses` tinyint NOT NULL,
  `ratings` tinyint NOT NULL,
  `rating_points` tinyint NOT NULL,
  `daily_points` tinyint NOT NULL,
  `bet_points` tinyint NOT NULL,
  `total_points` tinyint NOT NULL,
  `available_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc_s2`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc_s2`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc_s2` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `wins` tinyint NOT NULL,
  `losses` tinyint NOT NULL,
  `ratings` tinyint NOT NULL,
  `rating_points` tinyint NOT NULL,
  `daily_points` tinyint NOT NULL,
  `bet_points` tinyint NOT NULL,
  `total_points` tinyint NOT NULL,
  `available_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc_s3`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc_s3`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s3`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc_s3` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `wins` tinyint NOT NULL,
  `losses` tinyint NOT NULL,
  `ratings` tinyint NOT NULL,
  `rating_points` tinyint NOT NULL,
  `daily_points` tinyint NOT NULL,
  `bet_points` tinyint NOT NULL,
  `total_points` tinyint NOT NULL,
  `available_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc_s4`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc_s4`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s4`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc_s4` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `wins` tinyint NOT NULL,
  `losses` tinyint NOT NULL,
  `ratings` tinyint NOT NULL,
  `rating_points` tinyint NOT NULL,
  `daily_points` tinyint NOT NULL,
  `bet_points` tinyint NOT NULL,
  `total_points` tinyint NOT NULL,
  `available_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc_s5`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc_s5`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s5`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc_s5` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `wins` tinyint NOT NULL,
  `losses` tinyint NOT NULL,
  `ratings` tinyint NOT NULL,
  `rating_points` tinyint NOT NULL,
  `daily_points` tinyint NOT NULL,
  `bet_points` tinyint NOT NULL,
  `total_points` tinyint NOT NULL,
  `available_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_stats_calc_s6`
--

DROP TABLE IF EXISTS `uv_matches_stats_calc_s6`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s6`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_stats_calc_s6` (
  `user_id` tinyint NOT NULL,
  `season` tinyint NOT NULL,
  `wins` tinyint NOT NULL,
  `losses` tinyint NOT NULL,
  `ratings` tinyint NOT NULL,
  `rating_points` tinyint NOT NULL,
  `daily_points` tinyint NOT NULL,
  `bet_points` tinyint NOT NULL,
  `total_points` tinyint NOT NULL,
  `available_points` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_matches_user_bets`
--

DROP TABLE IF EXISTS `uv_matches_user_bets`;
/*!50001 DROP VIEW IF EXISTS `uv_matches_user_bets`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_matches_user_bets` (
  `user_id` tinyint NOT NULL,
  `match_id` tinyint NOT NULL,
  `bet_amount` tinyint NOT NULL,
  `bet_team` tinyint NOT NULL,
  `bet_placed` tinyint NOT NULL,
  `bet_won` tinyint NOT NULL,
  `team_base_pot` tinyint NOT NULL,
  `potential_pot` tinyint NOT NULL,
  `potential_cut_pct` tinyint NOT NULL,
  `potential_cut_points` tinyint NOT NULL,
  `completed` tinyint NOT NULL,
  `pot_valid` tinyint NOT NULL,
  `base_pot` tinyint NOT NULL,
  `bet_multiplier` tinyint NOT NULL,
  `total_pot` tinyint NOT NULL,
  `contestants` tinyint NOT NULL,
  `contestants_won` tinyint NOT NULL,
  `contestants_lost` tinyint NOT NULL,
  `bet_on` tinyint NOT NULL,
  `event_name` tinyint NOT NULL,
  `event_dt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_poll_active`
--

DROP TABLE IF EXISTS `uv_poll_active`;
/*!50001 DROP VIEW IF EXISTS `uv_poll_active`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_poll_active` (
  `id` tinyint NOT NULL,
  `content` tinyint NOT NULL,
  `allow_multi` tinyint NOT NULL,
  `hide_votes` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `votes` tinyint NOT NULL,
  `expire_dt` tinyint NOT NULL,
  `created_dt` tinyint NOT NULL,
  `ending_in` tinyint NOT NULL,
  `admin_hide` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_poll_expired`
--

DROP TABLE IF EXISTS `uv_poll_expired`;
/*!50001 DROP VIEW IF EXISTS `uv_poll_expired`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_poll_expired` (
  `id` tinyint NOT NULL,
  `content` tinyint NOT NULL,
  `allow_multi` tinyint NOT NULL,
  `hide_votes` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `votes` tinyint NOT NULL,
  `expire_dt` tinyint NOT NULL,
  `created_dt` tinyint NOT NULL,
  `ending_in` tinyint NOT NULL,
  `admin_hide` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_poll_info`
--

DROP TABLE IF EXISTS `uv_poll_info`;
/*!50001 DROP VIEW IF EXISTS `uv_poll_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_poll_info` (
  `id` tinyint NOT NULL,
  `content` tinyint NOT NULL,
  `allow_multi` tinyint NOT NULL,
  `hide_votes` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `votes` tinyint NOT NULL,
  `expire_dt` tinyint NOT NULL,
  `created_dt` tinyint NOT NULL,
  `ending_in` tinyint NOT NULL,
  `admin_hide` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_table_size_on_disk`
--

DROP TABLE IF EXISTS `uv_table_size_on_disk`;
/*!50001 DROP VIEW IF EXISTS `uv_table_size_on_disk`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_table_size_on_disk` (
  `Database` tinyint NOT NULL,
  `Table` tinyint NOT NULL,
  `Size (MB)` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_traffic`
--

DROP TABLE IF EXISTS `uv_traffic`;
/*!50001 DROP VIEW IF EXISTS `uv_traffic`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_traffic` (
  `created` tinyint NOT NULL,
  `response_code` tinyint NOT NULL,
  `request` tinyint NOT NULL,
  `auth_user_id` tinyint NOT NULL,
  `auth_user_username` tinyint NOT NULL,
  `inet6_ntoa(traffic_ip.ip)` tinyint NOT NULL,
  `user_agent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_traffic_general_daily`
--

DROP TABLE IF EXISTS `uv_traffic_general_daily`;
/*!50001 DROP VIEW IF EXISTS `uv_traffic_general_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_traffic_general_daily` (
  `total_traffic` tinyint NOT NULL,
  `unique_ips` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_traffic_ip_daily`
--

DROP TABLE IF EXISTS `uv_traffic_ip_daily`;
/*!50001 DROP VIEW IF EXISTS `uv_traffic_ip_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_traffic_ip_daily` (
  `ip` tinyint NOT NULL,
  `total_hits` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_web_traffic`
--

DROP TABLE IF EXISTS `uv_web_traffic`;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_web_traffic` (
  `bot` tinyint NOT NULL,
  `created` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `ip` tinyint NOT NULL,
  `uri` tinyint NOT NULL,
  `user_action` tinyint NOT NULL,
  `user_agent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_web_traffic_general_daily`
--

DROP TABLE IF EXISTS `uv_web_traffic_general_daily`;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_general_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_web_traffic_general_daily` (
  `total_traffic` tinyint NOT NULL,
  `unique_ips` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_web_traffic_ip_daily`
--

DROP TABLE IF EXISTS `uv_web_traffic_ip_daily`;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_ip_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_web_traffic_ip_daily` (
  `ip` tinyint NOT NULL,
  `total_hits` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_web_traffic_uri_daily`
--

DROP TABLE IF EXISTS `uv_web_traffic_uri_daily`;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_uri_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_web_traffic_uri_daily` (
  `uri` tinyint NOT NULL,
  `total_traffic` tinyint NOT NULL,
  `unique_ips` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `uv_web_traffic_useragent_daily`
--

DROP TABLE IF EXISTS `uv_web_traffic_useragent_daily`;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_useragent_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `uv_web_traffic_useragent_daily` (
  `user_agent` tinyint NOT NULL,
  `total_traffic` tinyint NOT NULL,
  `unique_ips` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `web_contact`
--

DROP TABLE IF EXISTS `web_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_contact` (
  `id` binary(16) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(320) NOT NULL,
  `subject` varchar(120) NOT NULL,
  `body` text NOT NULL,
  `ip` text NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `received_dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_ip`
--

DROP TABLE IF EXISTS `web_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_ip` (
  `id` binary(16) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `old_ip` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_UNIQUE` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_traffic`
--

DROP TABLE IF EXISTS `web_traffic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_traffic` (
  `id` binary(16) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `ip_id` binary(16) NOT NULL,
  `uri_id` binary(16) NOT NULL,
  `user_agent_id` binary(16) NOT NULL,
  `user_action_id` binary(16) NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_uri`
--

DROP TABLE IF EXISTS `web_uri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_uri` (
  `id` binary(16) NOT NULL,
  `uri` text NOT NULL,
  `md5hash` binary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5hash_UNIQUE` (`md5hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_user_action`
--

DROP TABLE IF EXISTS `web_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_user_action` (
  `id` binary(16) NOT NULL,
  `user_action` text NOT NULL,
  `md5hash` binary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5hash_UNIQUE` (`md5hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_user_agent`
--

DROP TABLE IF EXISTS `web_user_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_user_agent` (
  `id` binary(16) NOT NULL,
  `user_agent` text NOT NULL,
  `md5hash` binary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5hash_UNIQUE` (`md5hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `mysql`;

--
-- Table structure for table `column_stats`
--

DROP TABLE IF EXISTS `column_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `column_stats` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `column_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `min_value` varbinary(255) DEFAULT NULL,
  `max_value` varbinary(255) DEFAULT NULL,
  `nulls_ratio` decimal(12,4) DEFAULT NULL,
  `avg_length` decimal(12,4) DEFAULT NULL,
  `avg_frequency` decimal(12,4) DEFAULT NULL,
  `hist_size` tinyint(3) unsigned DEFAULT NULL,
  `hist_type` enum('SINGLE_PREC_HB','DOUBLE_PREC_HB') COLLATE utf8mb3_bin DEFAULT NULL,
  `histogram` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`db_name`,`table_name`,`column_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='Statistics on Columns';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns_priv` (
  `Host` char(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Column_name` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8mb3 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db` (
  `Host` char(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  `Delete_history_priv` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `db` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `body` longblob NOT NULL,
  `definer` varchar(384) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `execute_at` datetime DEFAULT NULL,
  `interval_value` int(11) DEFAULT NULL,
  `interval_field` enum('YEAR','QUARTER','MONTH','DAY','HOUR','MINUTE','WEEK','SECOND','MICROSECOND','YEAR_MONTH','DAY_HOUR','DAY_MINUTE','DAY_SECOND','HOUR_MINUTE','HOUR_SECOND','MINUTE_SECOND','DAY_MICROSECOND','HOUR_MICROSECOND','MINUTE_MICROSECOND','SECOND_MICROSECOND') DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_executed` datetime DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `ends` datetime DEFAULT NULL,
  `status` enum('ENABLED','DISABLED','SLAVESIDE_DISABLED') NOT NULL DEFAULT 'ENABLED',
  `on_completion` enum('DROP','PRESERVE') NOT NULL DEFAULT 'DROP',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH','EMPTY_STRING_IS_NULL','SIMULTANEOUS_ASSIGNMENT','TIME_ROUND_FRACTIONAL') NOT NULL DEFAULT '',
  `comment` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `originator` int(10) unsigned NOT NULL,
  `time_zone` char(64) CHARACTER SET latin1 NOT NULL DEFAULT 'SYSTEM',
  `character_set_client` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `body_utf8` longblob DEFAULT NULL,
  PRIMARY KEY (`db`,`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Events';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `func` (
  `name` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `ret` tinyint(1) NOT NULL DEFAULT 0,
  `dl` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8mb3 NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_priv`
--

DROP TABLE IF EXISTS `global_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_priv` (
  `Host` char(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Priv` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}' CHECK (json_valid(`Priv`)),
  PRIMARY KEY (`Host`,`User`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gtid_slave_pos`
--

DROP TABLE IF EXISTS `gtid_slave_pos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gtid_slave_pos` (
  `domain_id` int(10) unsigned NOT NULL,
  `sub_id` bigint(20) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `seq_no` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`domain_id`,`sub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Replication slave GTID position';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned DEFAULT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `index_stats`
--

DROP TABLE IF EXISTS `index_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_stats` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `index_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `prefix_arity` int(11) unsigned NOT NULL,
  `avg_frequency` decimal(12,4) DEFAULT NULL,
  PRIMARY KEY (`db_name`,`table_name`,`index_name`,`prefix_arity`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='Statistics on Indexes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `innodb_index_stats`
--

DROP TABLE IF EXISTS `innodb_index_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `innodb_index_stats` (
  `database_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(199) COLLATE utf8mb3_bin NOT NULL,
  `index_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `stat_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `stat_value` bigint(20) unsigned NOT NULL,
  `sample_size` bigint(20) unsigned DEFAULT NULL,
  `stat_description` varchar(1024) COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`database_name`,`table_name`,`index_name`,`stat_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin STATS_PERSISTENT=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `innodb_table_stats`
--

DROP TABLE IF EXISTS `innodb_table_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `innodb_table_stats` (
  `database_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(199) COLLATE utf8mb3_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `n_rows` bigint(20) unsigned NOT NULL,
  `clustered_index_size` bigint(20) unsigned NOT NULL,
  `sum_of_other_index_sizes` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`database_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin STATS_PERSISTENT=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `dl` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='MySQL plugins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proc` (
  `db` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `type` enum('FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY') NOT NULL,
  `specific_name` char(64) NOT NULL DEFAULT '',
  `language` enum('SQL') NOT NULL DEFAULT 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL DEFAULT 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL DEFAULT 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` longblob NOT NULL,
  `body` longblob NOT NULL,
  `definer` varchar(384) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH','EMPTY_STRING_IS_NULL','SIMULTANEOUS_ASSIGNMENT','TIME_ROUND_FRACTIONAL') NOT NULL DEFAULT '',
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `character_set_client` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `body_utf8` longblob DEFAULT NULL,
  `aggregate` enum('NONE','GROUP') NOT NULL DEFAULT 'NONE',
  PRIMARY KEY (`db`,`name`,`type`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Stored Procedures';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procs_priv` (
  `Host` char(60) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8mb3 NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY') COLLATE utf8mb3_bin NOT NULL,
  `Grantor` varchar(384) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8mb3 NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proxies_priv`
--

DROP TABLE IF EXISTS `proxies_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxies_priv` (
  `Host` char(60) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Proxied_host` char(60) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Proxied_user` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `With_grant` tinyint(1) NOT NULL DEFAULT 0,
  `Grantor` varchar(384) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Host`,`User`,`Proxied_host`,`Proxied_user`),
  KEY `Grantor` (`Grantor`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='User proxy privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles_mapping`
--

DROP TABLE IF EXISTS `roles_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_mapping` (
  `Host` char(60) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(80) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Role` char(80) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Admin_option` enum('N','Y') CHARACTER SET utf8mb3 NOT NULL DEFAULT 'N',
  UNIQUE KEY `Host` (`Host`,`User`,`Role`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Granted roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` varchar(2048) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(128) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int(4) NOT NULL DEFAULT 0,
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='MySQL Foreign Servers table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `table_stats`
--

DROP TABLE IF EXISTS `table_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_stats` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `cardinality` bigint(21) unsigned DEFAULT NULL,
  PRIMARY KEY (`db_name`,`table_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='Statistics on Tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables_priv` (
  `Host` char(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `User` char(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Grantor` varchar(384) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger','Delete versioning rows') CHARACTER SET utf8mb3 NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8mb3 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY (`Transition_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL DEFAULT 0,
  `Is_DST` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb3 PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `user`
--

DROP TABLE IF EXISTS `user`;
/*!50001 DROP VIEW IF EXISTS `user`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user` (
  `Host` tinyint NOT NULL,
  `User` tinyint NOT NULL,
  `Password` tinyint NOT NULL,
  `Select_priv` tinyint NOT NULL,
  `Insert_priv` tinyint NOT NULL,
  `Update_priv` tinyint NOT NULL,
  `Delete_priv` tinyint NOT NULL,
  `Create_priv` tinyint NOT NULL,
  `Drop_priv` tinyint NOT NULL,
  `Reload_priv` tinyint NOT NULL,
  `Shutdown_priv` tinyint NOT NULL,
  `Process_priv` tinyint NOT NULL,
  `File_priv` tinyint NOT NULL,
  `Grant_priv` tinyint NOT NULL,
  `References_priv` tinyint NOT NULL,
  `Index_priv` tinyint NOT NULL,
  `Alter_priv` tinyint NOT NULL,
  `Show_db_priv` tinyint NOT NULL,
  `Super_priv` tinyint NOT NULL,
  `Create_tmp_table_priv` tinyint NOT NULL,
  `Lock_tables_priv` tinyint NOT NULL,
  `Execute_priv` tinyint NOT NULL,
  `Repl_slave_priv` tinyint NOT NULL,
  `Repl_client_priv` tinyint NOT NULL,
  `Create_view_priv` tinyint NOT NULL,
  `Show_view_priv` tinyint NOT NULL,
  `Create_routine_priv` tinyint NOT NULL,
  `Alter_routine_priv` tinyint NOT NULL,
  `Create_user_priv` tinyint NOT NULL,
  `Event_priv` tinyint NOT NULL,
  `Trigger_priv` tinyint NOT NULL,
  `Create_tablespace_priv` tinyint NOT NULL,
  `Delete_history_priv` tinyint NOT NULL,
  `ssl_type` tinyint NOT NULL,
  `ssl_cipher` tinyint NOT NULL,
  `x509_issuer` tinyint NOT NULL,
  `x509_subject` tinyint NOT NULL,
  `max_questions` tinyint NOT NULL,
  `max_updates` tinyint NOT NULL,
  `max_connections` tinyint NOT NULL,
  `max_user_connections` tinyint NOT NULL,
  `plugin` tinyint NOT NULL,
  `authentication_string` tinyint NOT NULL,
  `password_expired` tinyint NOT NULL,
  `is_role` tinyint NOT NULL,
  `default_role` tinyint NOT NULL,
  `max_statement_time` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `general_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `general_log` (
  `event_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `user_host` mediumtext NOT NULL,
  `thread_id` bigint(21) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8mb3 COMMENT='General log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `slow_log` (
  `start_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `user_host` mediumtext NOT NULL,
  `query_time` time(6) NOT NULL,
  `lock_time` time(6) NOT NULL,
  `rows_sent` int(11) NOT NULL,
  `rows_examined` int(11) NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int(11) NOT NULL,
  `insert_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `sql_text` mediumtext NOT NULL,
  `thread_id` bigint(21) unsigned NOT NULL,
  `rows_affected` int(11) NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8mb3 COMMENT='Slow log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_registry`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `transaction_registry` (
  `transaction_id` bigint(20) unsigned NOT NULL,
  `commit_id` bigint(20) unsigned NOT NULL,
  `begin_timestamp` timestamp(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000',
  `commit_timestamp` timestamp(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000',
  `isolation_level` enum('READ-UNCOMMITTED','READ-COMMITTED','REPEATABLE-READ','SERIALIZABLE') COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `commit_id` (`commit_id`),
  KEY `begin_timestamp` (`begin_timestamp`),
  KEY `commit_timestamp` (`commit_timestamp`,`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin STATS_PERSISTENT=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `Website`
--

USE `Website`;

--
-- Final view structure for view `uv_matches`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches` AS select `m`.`id` AS `id`,`mc`.`completed` AS `completed`,`mc`.`pot_valid` AS `pot_valid`,cast(`e`.`date_time` as date) AS `date`,`e`.`name` AS `event`,`t`.`name` AS `title`,`mt`.`name` AS `match_type`,`m`.`match_note` AS `match_note`,`mc`.`contestants` AS `contestants`,`m`.`team_won` AS `team_won`,`mc`.`contestants_won` AS `contestants_won`,`mc`.`contestants_lost` AS `contestants_lost`,`m`.`winner_note` AS `winner_note`,`m`.`bet_open` AS `bet_open`,`mc`.`bet_multiplier` AS `bet_multiplier`,`mc`.`base_loser_pot` AS `base_loser_pot`,`mc`.`base_winner_pot` AS `base_winner_pot`,`mc`.`base_pot` AS `base_pot`,`mc`.`base_pot` * `mc`.`bet_multiplier` AS `total_pot`,`mc`.`user_bet_cnt` AS `user_bet_cnt`,`mc`.`user_bet_loser_cnt` AS `user_bet_loser_cnt`,`mc`.`user_bet_winner_cnt` AS `user_bet_winner_cnt`,`mc`.`user_rating_avg` AS `user_rating_avg`,`mc`.`user_rating_cnt` AS `user_rating_cnt`,`m`.`event_id` AS `event_id`,`m`.`title_id` AS `title_id`,`m`.`match_type_id` AS `match_type_id`,`m`.`last_updated` AS `info_last_updated`,`m`.`last_updated_by` AS `info_last_updated_by_id`,`u`.`username` AS `info_last_updated_by_username`,`mc`.`last_updated` AS `calc_last_updated` from (((((`matches_match` `m` left join `matches_event` `e` on(`e`.`id` = `m`.`event_id`)) left join `matches_title` `t` on(`t`.`id` = `m`.`title_id`)) left join `matches_match_type` `mt` on(`mt`.`id` = `m`.`match_type_id`)) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `m`.`id`)) left join `user` `u` on(`u`.`id` = `m`.`last_updated_by`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_all`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_all`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_all`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_all` AS select `matches_match`.`id` AS `id`,`matches_match`.`event_id` AS `event_id`,cast(`matches_event`.`date_time` as date) AS `date`,`matches_event`.`name` AS `event`,`matches_match`.`title_id` AS `title_id`,`matches_title`.`name` AS `title`,`matches_match`.`match_type_id` AS `match_type_id`,`matches_match_type`.`name` AS `match_type`,`matches_match`.`match_note` AS `match_note`,group_concat(`matches_superstar`.`name` separator '; ') AS `superstars`,`matches_match`.`team_won` AS `team_won`,`matches_match`.`winner_note` AS `winner_note`,`matches_match`.`bet_open` AS `bet_open`,`matches_match`.`last_updated` AS `last_updated`,`matches_match`.`last_updated_by` AS `last_updated_by`,`uv_matches_match_rating`.`user_rating_avg` AS `user_rating_avg` from ((((((`matches_match` left join `matches_event` on(`matches_event`.`id` = `matches_match`.`event_id`)) left join `uv_matches_match_rating` on(`uv_matches_match_rating`.`id` = `matches_match`.`id`)) left join `matches_title` on(`matches_title`.`id` = `matches_match`.`title_id`)) left join `matches_match_type` on(`matches_match_type`.`id` = `matches_match`.`match_type_id`)) left join `matches_contestant` on(`matches_match`.`id` = `matches_contestant`.`match_id`)) left join `matches_superstar` on(`matches_contestant`.`superstar_id` = `matches_superstar`.`id`)) group by `matches_match`.`id` order by `matches_match`.`bet_open` desc,`matches_event`.`date_time` desc,`matches_match`.`event_id` desc,`matches_match`.`title_id` = 0,`matches_match`.`title_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_all_bets`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_all_bets`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_all_bets`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_all_bets` AS select `matches_match`.`id` AS `id`,ifnull(`matches_contestant`.`bet_multiplier`,1) AS `bet_multiplier`,ifnull(sum(if(`matches_match`.`team_won` <> `matches_bet`.`team`,`matches_bet`.`points`,0)),0) AS `base_loser_pot`,ifnull(sum(if(`matches_match`.`team_won` = `matches_bet`.`team`,`matches_bet`.`points`,0)),0) AS `base_winner_pot`,ifnull(sum(`matches_bet`.`points`),0) AS `base_pot`,ifnull(sum(`matches_bet`.`points`),0) * ifnull(`matches_contestant`.`bet_multiplier`,1) AS `total_pot`,ifnull(sum(if(`matches_match`.`team_won` <> `matches_bet`.`team`,1,0)),0) AS `loser_bet_cnt`,ifnull(sum(if(`matches_match`.`team_won` = `matches_bet`.`team`,1,0)),0) AS `winner_bet_cnt`,ifnull(sum(if(`matches_bet`.`team`,1,0)),0) AS `bet_cnt` from ((`matches_match` left join `matches_bet` on(`matches_bet`.`match_id` = `matches_match`.`id`)) left join `matches_contestant` on(`matches_contestant`.`match_id` = `matches_match`.`id` and `matches_contestant`.`team` = `matches_match`.`team_won`)) group by `matches_match`.`id` order by ifnull(sum(`matches_bet`.`points`),0) * ifnull(`matches_contestant`.`bet_multiplier`,1) desc,ifnull(sum(`matches_bet`.`points`),0) desc,count(0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_last_updated_by`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_last_updated_by`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_last_updated_by`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_last_updated_by` AS select `user`.`id` AS `user_id`,`user`.`username` AS `last_updated_by`,count(`matches_match`.`last_updated_by`) AS `match_cnt`,min(`matches_match`.`id`) AS `min_match_id`,min(`matches_match`.`last_updated`) AS `min_dt`,max(`matches_match`.`id`) AS `max_match_id`,max(`matches_match`.`last_updated`) AS `max_dt` from (`matches_match` join `user` on(`matches_match`.`last_updated_by` = `user`.`id`)) group by `matches_match`.`last_updated_by` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_match_calculation`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_match_calculation`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_match_calculation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_match_calculation` AS select `m`.`id` AS `id`,group_concat(distinct `s`.`name` separator '; ') AS `contestants`,group_concat(distinct if(`mc`.`team` = `m`.`team_won`,`s`.`name`,NULL) separator '; ') AS `contestants_won`,group_concat(distinct if(`mc`.`team` <> `m`.`team_won`,`s`.`name`,NULL) separator '; ') AS `contestants_lost`,ifnull(`wc`.`bet_multiplier`,1) AS `bet_multiplier`,ifnull(sum(`ub`.`points`),0) AS `base_pot`,ifnull(sum(if(`ub`.`team` = `m`.`team_won`,`ub`.`points`,0)),0) AS `base_winner_pot`,ifnull(sum(if(`ub`.`team` <> `m`.`team_won`,`ub`.`points`,0)),0) AS `base_loser_pot`,count(distinct `ub`.`user_id`) AS `user_bet_cnt`,count(distinct case when `ub`.`team` = `m`.`team_won` then `ub`.`user_id` end) AS `user_bet_winner_cnt`,count(distinct case when `ub`.`team` <> `m`.`team_won` then `ub`.`user_id` end) AS `user_bet_loser_cnt`,ifnull(avg(`umr`.`rating`),0) AS `user_rating_avg`,count(distinct `umr`.`user_id`) AS `user_rating_cnt` from (((((`matches_match` `m` left join `matches_contestant` `mc` on(`mc`.`match_id` = `m`.`id`)) left join `matches_superstar` `s` on(`s`.`id` = `mc`.`superstar_id`)) left join `matches_bet` `ub` on(`ub`.`match_id` = `m`.`id`)) left join `matches_match_rating` `umr` on(`umr`.`match_id` = `m`.`id`)) left join `matches_contestant` `wc` on(`wc`.`match_id` = `m`.`id` and `wc`.`team` = `m`.`team_won`)) group by `m`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_match_detail`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_match_detail`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_match_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_match_detail` AS select `m`.`id` AS `id`,`m`.`event_id` AS `event_id`,`m`.`title_id` AS `title_id`,`m`.`match_type_id` AS `match_type_id`,`m`.`match_note` AS `match_note`,`m`.`team_won` AS `team_won`,`m`.`winner_note` AS `winner_note`,`m`.`bet_open` AS `bet_open`,`m`.`last_updated_by` AS `info_last_updated_by_id`,`m`.`last_updated` AS `info_last_updated`,`mc`.`completed` AS `completed`,`mc`.`pot_valid` AS `pot_valid`,`mc`.`contestants` AS `contestants`,`mc`.`contestants_won` AS `contestants_won`,`mc`.`contestants_lost` AS `contestants_lost`,`mc`.`bet_multiplier` AS `bet_multiplier`,`mc`.`base_pot` AS `base_pot`,`mc`.`base_pot` * `mc`.`bet_multiplier` AS `total_pot`,`mc`.`base_winner_pot` AS `base_winner_pot`,`mc`.`base_loser_pot` AS `base_loser_pot`,`mc`.`user_bet_cnt` AS `user_bet_cnt`,`mc`.`user_bet_winner_cnt` AS `user_bet_winner_cnt`,`mc`.`user_bet_loser_cnt` AS `user_bet_loser_cnt`,`mc`.`user_rating_avg` AS `user_rating_avg`,`mc`.`user_rating_cnt` AS `user_rating_cnt`,`mc`.`last_updated` AS `calc_last_updated`,`e`.`name` AS `event`,cast(`e`.`date_time` as date) AS `date`,`t`.`name` AS `title`,`mt`.`name` AS `match_type`,`u`.`username` AS `last_updated_by_username` from (((((`matches_match` `m` left join `matches_event` `e` on(`e`.`id` = `m`.`event_id`)) left join `matches_title` `t` on(`t`.`id` = `m`.`title_id`)) left join `matches_match_type` `mt` on(`mt`.`id` = `m`.`match_type_id`)) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `m`.`id`)) left join `user` `u` on(`u`.`id` = `m`.`last_updated_by`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_match_rating`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_match_rating`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_match_rating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_match_rating` AS select `matches_match`.`id` AS `id`,ifnull(avg(nullif(`matches_match_rating`.`rating`,0)),0) AS `user_rating_avg`,count(0) AS `user_rating_cnt` from (`matches_match` left join `matches_match_rating` on(`matches_match_rating`.`match_id` = `matches_match`.`id`)) group by `matches_match`.`id` order by ifnull(avg(nullif(`matches_match_rating`.`rating`,0)),0) desc,count(0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_royalrumble`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_royalrumble`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_royalrumble`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_royalrumble` AS select `matches_royalrumble`.`id` AS `royalrumble_id`,`matches_event`.`date_time` AS `event_dt`,concat(year(`matches_event`.`date_time`),' ',`matches_event`.`name`) AS `event_name`,`matches_royalrumble`.`description` AS `description`,`matches_royalrumble`.`entry_max` AS `entry_max`,`matches_royalrumble`.`entry_won` AS `entry_won`,`matches_royalrumble_entry`.`user_id` AS `user_id`,ifnull(`user`.`username`,`matches_royalrumble_entry`.`display_name`) AS `display_name`,`matches_royalrumble_entry`.`entry` AS `entry`,`matches_royalrumble_entry`.`comment` AS `comment`,`matches_royalrumble_entry`.`created` AS `entered`,if(`matches_royalrumble`.`entry_won` = `matches_royalrumble_entry`.`entry` and `matches_royalrumble`.`id` = `matches_royalrumble_entry`.`royalrumble_id`,1,0) AS `winner` from (((`matches_royalrumble` left join `matches_event` on(`matches_event`.`id` = `matches_royalrumble`.`event_id`)) left join `matches_royalrumble_entry` on(`matches_royalrumble_entry`.`royalrumble_id` = `matches_royalrumble`.`id`)) left join `user` on(`user`.`id` = `matches_royalrumble_entry`.`user_id`)) order by `matches_event`.`date_time` desc,`matches_royalrumble`.`id` desc,`matches_royalrumble_entry`.`entry`,`matches_royalrumble_entry`.`created` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_season_rating`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_season_rating`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_season_rating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_season_rating` AS select `umr`.`user_id` AS `user_id`,`ms`.`season` AS `season`,count(`umr`.`match_id`) AS `rating_cnt` from (`matches_match_rating` `umr` join `matches_season` `ms` on(`umr`.`match_id` between `ms`.`start_matchid` and ifnull(`ms`.`end_matchid`,`umr`.`match_id`))) group by `umr`.`user_id`,`ms`.`season` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats` AS select `user`.`id` AS `user_id`,`user`.`username` AS `username`,`user`.`date_created` AS `date_created`,ifnull(`ufs`.`superstar_id`,1) AS `favorite_superstar_id`,`us1`.`wins` AS `s1_wins`,`us1`.`losses` AS `s1_losses`,`us1`.`ratings` AS `s1_ratings`,`us1`.`rating_points` AS `s1_rating_points`,`us1`.`daily_points` AS `s1_daily_points`,`us1`.`bet_points` AS `s1_bet_points`,`us1`.`total_points` AS `s1_total_points`,`us1`.`available_points` AS `s1_available_points`,`us2`.`wins` AS `s2_wins`,`us2`.`losses` AS `s2_losses`,`us2`.`ratings` AS `s2_ratings`,`us2`.`rating_points` AS `s2_rating_points`,`us2`.`daily_points` AS `s2_daily_points`,`us2`.`bet_points` AS `s2_bet_points`,`us2`.`total_points` AS `s2_total_points`,`us2`.`available_points` AS `s2_available_points`,`us3`.`wins` AS `s3_wins`,`us3`.`losses` AS `s3_losses`,`us3`.`ratings` AS `s3_ratings`,`us3`.`rating_points` AS `s3_rating_points`,`us3`.`daily_points` AS `s3_daily_points`,`us3`.`bet_points` AS `s3_bet_points`,`us3`.`total_points` AS `s3_total_points`,`us3`.`available_points` AS `s3_available_points`,`us4`.`wins` AS `s4_wins`,`us4`.`losses` AS `s4_losses`,`us4`.`ratings` AS `s4_ratings`,`us4`.`rating_points` AS `s4_rating_points`,`us4`.`daily_points` AS `s4_daily_points`,`us4`.`bet_points` AS `s4_bet_points`,`us4`.`total_points` AS `s4_total_points`,`us4`.`available_points` AS `s4_available_points`,`us5`.`wins` AS `s5_wins`,`us5`.`losses` AS `s5_losses`,`us5`.`ratings` AS `s5_ratings`,`us5`.`rating_points` AS `s5_rating_points`,`us5`.`daily_points` AS `s5_daily_points`,`us5`.`bet_points` AS `s5_bet_points`,`us5`.`total_points` AS `s5_total_points`,`us5`.`available_points` AS `s5_available_points`,`us6`.`wins` AS `s6_wins`,`us6`.`losses` AS `s6_losses`,`us6`.`ratings` AS `s6_ratings`,`us6`.`rating_points` AS `s6_rating_points`,`us6`.`daily_points` AS `s6_daily_points`,`us6`.`bet_points` AS `s6_bet_points`,`us6`.`total_points` AS `s6_total_points`,`us6`.`available_points` AS `s6_available_points`,ifnull(`us1`.`wins`,0) + ifnull(`us2`.`wins`,0) + ifnull(`us3`.`wins`,0) + ifnull(`us4`.`wins`,0) + ifnull(`us5`.`wins`,0) + ifnull(`us6`.`wins`,0) AS `total_wins`,ifnull(`us1`.`losses`,0) + ifnull(`us2`.`losses`,0) + ifnull(`us3`.`losses`,0) + ifnull(`us4`.`losses`,0) + ifnull(`us5`.`losses`,0) + ifnull(`us6`.`losses`,0) AS `total_losses`,ifnull(`us1`.`total_points`,0) + ifnull(`us2`.`total_points`,0) + ifnull(`us3`.`total_points`,0) + ifnull(`us4`.`total_points`,0) + ifnull(`us5`.`total_points`,0) + ifnull(`us6`.`total_points`,0) AS `total_points` from (((((((`user` left join `matches_favorite_superstar` `ufs` on(`user`.`id` = `ufs`.`user_id`)) left join `matches_stats` `us1` on(`us1`.`season` = 1 and `user`.`id` = `us1`.`user_id`)) left join `matches_stats` `us2` on(`us2`.`season` = 2 and `user`.`id` = `us2`.`user_id`)) left join `matches_stats` `us3` on(`us3`.`season` = 3 and `user`.`id` = `us3`.`user_id`)) left join `uv_matches_stats_calc_s4` `us4` on(`us4`.`season` = 4 and `user`.`id` = `us4`.`user_id`)) left join `uv_matches_stats_calc_s5` `us5` on(`us5`.`season` = 5 and `user`.`id` = `us5`.`user_id`)) left join `uv_matches_stats_calc_s6` `us6` on(`us6`.`season` = 6 and `user`.`id` = `us5`.`user_id`)) group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc` AS select `user`.`id` AS `user_id`,`user`.`date_created` AS `date_created`,ifnull(`vus1`.`wins`,0) AS `s1_wins`,ifnull(`vus1`.`losses`,0) AS `s1_losses`,ifnull(`vus1`.`ratings`,0) AS `s1_ratings`,ifnull(`vus1`.`rating_points`,0) AS `s1_rating_points`,ifnull(`vus1`.`daily_points`,0) AS `s1_daily_points`,ifnull(`vus1`.`bet_points`,0) AS `s1_bet_points`,ifnull(`vus1`.`total_points`,0) AS `s1_total_points`,ifnull(`vus1`.`available_points`,0) AS `s1_available_points`,ifnull(`vus2`.`wins`,0) AS `s2_wins`,ifnull(`vus2`.`losses`,0) AS `s2_losses`,ifnull(`vus1`.`ratings`,0) AS `s2_ratings`,ifnull(`vus1`.`rating_points`,0) AS `s2_rating_points`,ifnull(`vus2`.`daily_points`,0) AS `s2_daily_points`,ifnull(`vus2`.`bet_points`,0) AS `s2_bet_points`,ifnull(`vus2`.`total_points`,0) AS `s2_total_points`,ifnull(`vus2`.`available_points`,0) AS `s2_available_points`,ifnull(`vus3`.`wins`,0) AS `s3_wins`,ifnull(`vus3`.`losses`,0) AS `s3_losses`,ifnull(`vus1`.`ratings`,0) AS `s3_ratings`,ifnull(`vus1`.`rating_points`,0) AS `s3_rating_points`,ifnull(`vus3`.`daily_points`,0) AS `s3_daily_points`,ifnull(`vus3`.`bet_points`,0) AS `s3_bet_points`,ifnull(`vus3`.`total_points`,0) AS `s3_total_points`,ifnull(`vus3`.`available_points`,0) AS `s3_available_points`,ifnull(`vus4`.`daily_points`,0) AS `s4_daily_points`,ifnull(`vus4`.`bet_points`,0) AS `s4_bet_points`,ifnull(`vus4`.`total_points`,0) AS `s4_total_points`,ifnull(`vus4`.`available_points`,0) AS `s4_available_points`,ifnull(`vus1`.`wins`,0) + ifnull(`vus2`.`wins`,0) + ifnull(`vus3`.`wins`,0) + ifnull(`vus4`.`wins`,0) AS `total_wins`,ifnull(`vus1`.`losses`,0) + ifnull(`vus2`.`losses`,0) + ifnull(`vus3`.`losses`,0) + ifnull(`vus4`.`losses`,0) AS `total_losses`,ifnull(`vus1`.`total_points`,0) + ifnull(`vus2`.`total_points`,0) + ifnull(`vus3`.`total_points`,0) + ifnull(`vus4`.`total_points`,0) AS `total_points` from ((((`user` left join `uv_matches_stats_calc_s1` `vus1` on(`vus1`.`user_id` = `user`.`id`)) left join `uv_matches_stats_calc_s2` `vus2` on(`vus2`.`user_id` = `user`.`id`)) left join `uv_matches_stats_calc_s3` `vus3` on(`vus3`.`user_id` = `user`.`id`)) left join `uv_matches_stats_calc_s4` `vus4` on(`vus4`.`user_id` = `user`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc_s1`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc_s1`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc_s1` AS select `user`.`id` AS `user_id`,`ms`.`season` AS `season`,sum(if(`ubc`.`bet_won`,1,0)) AS `wins`,sum(if(`ubc`.`bet_won` = 0 and `mc`.`pot_valid` <> 0,1,0)) AS `losses`,ifnull(`umr`.`rating_cnt`,0) AS `ratings`,0 AS `rating_points`,(to_days(`ms`.`end_date`) - to_days(`user`.`date_created`)) * 20 AS `daily_points`,sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))) AS `bet_points`,ifnull(sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))),0) + 100 + (select `daily_points`) AS `total_points`,ifnull(sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid` <> 0 or `m`.`team_won` = 0,-`ubc`.`points`,0))),0) + 100 + (select `daily_points`) AS `available_points` from (((((`user` left join `matches_season` `ms` on(`ms`.`season` = 1)) left join `matches_bet_calculation` `ubc` on(`ubc`.`user_id` = `user`.`id` and `ubc`.`match_id` between `ms`.`start_matchid` and `ms`.`end_matchid`)) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `ubc`.`match_id`)) left join `matches_match` `m` on(`m`.`id` = `ubc`.`match_id`)) left join `uv_matches_season_rating` `umr` on(`umr`.`user_id` = `user`.`id` and `umr`.`season` = `ms`.`season`)) where `user`.`date_created` < `ms`.`end_date` + interval 1 day group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc_s2`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc_s2`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc_s2` AS select `user`.`id` AS `user_id`,`ms`.`season` AS `season`,sum(if(`ubc`.`bet_won`,1,0)) AS `wins`,sum(if(`ubc`.`bet_won` = 0 and `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0,1,0)) AS `losses`,ifnull(`umr`.`rating_cnt`,0) AS `ratings`,0 AS `rating_points`,(to_days(`ms`.`end_date`) - to_days(`user`.`date_created`)) * 20 AS `daily_points`,sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))) AS `bet_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0 and `ubc`.`bet_won` = 0 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) AS `total_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` = 1 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) AS `available_points` from ((((`user` left join `matches_season` `ms` on(`ms`.`season` = 2)) left join `matches_bet_calculation` `ubc` on(`ubc`.`user_id` = `user`.`id` and `ubc`.`match_id` between `ms`.`start_matchid` and `ms`.`end_matchid`)) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `ubc`.`match_id`)) left join `uv_matches_season_rating` `umr` on(`umr`.`user_id` = `user`.`id` and `umr`.`season` = `ms`.`season`)) where `user`.`date_created` < `ms`.`end_date` + interval 1 day group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc_s3`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc_s3`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc_s3` AS select `user`.`id` AS `user_id`,`ms`.`season` AS `season`,sum(if(`ubc`.`bet_won`,1,0)) AS `wins`,sum(if(`ubc`.`bet_won` = 0 and `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0,1,0)) AS `losses`,ifnull(`umr`.`rating_cnt`,0) AS `ratings`,(select `ratings`) * 50 AS `rating_points`,(to_days(if(current_timestamp() < `ms`.`end_date`,current_timestamp(),`ms`.`end_date`)) - to_days(`ms`.`start_date`)) * 20 AS `daily_points`,sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))) AS `bet_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0 and `ubc`.`bet_won` = 0 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `total_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` = 1 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `available_points` from ((((`user` left join `matches_season` `ms` on(`ms`.`season` = 3)) left join `matches_bet_calculation` `ubc` on(`ubc`.`user_id` = `user`.`id` and `ubc`.`match_id` between `ms`.`start_matchid` and ifnull(`ms`.`end_matchid`,`ubc`.`match_id`))) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `ubc`.`match_id`)) left join `uv_matches_season_rating` `umr` on(`umr`.`user_id` = `user`.`id` and `umr`.`season` = `ms`.`season`)) where `user`.`date_created` < `ms`.`end_date` + interval 1 day group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc_s4`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc_s4`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s4`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc_s4` AS select `user`.`id` AS `user_id`,`ms`.`season` AS `season`,sum(if(`ubc`.`bet_won`,1,0)) AS `wins`,sum(if(`ubc`.`bet_won` = 0 and `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0,1,0)) AS `losses`,ifnull(`umr`.`rating_cnt`,0) AS `ratings`,(select `ratings`) * 50 AS `rating_points`,(to_days(if(current_timestamp() < `ms`.`end_date`,current_timestamp(),`ms`.`end_date`)) - to_days(`ms`.`start_date`)) * 20 AS `daily_points`,sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))) AS `bet_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0 and `ubc`.`bet_won` = 0 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `total_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` = 1 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `available_points` from ((((`user` left join `matches_season` `ms` on(`ms`.`season` = 4)) left join `matches_bet_calculation` `ubc` on(`ubc`.`user_id` = `user`.`id` and `ubc`.`match_id` between `ms`.`start_matchid` and ifnull(`ms`.`end_matchid`,`ubc`.`match_id`))) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `ubc`.`match_id`)) left join `uv_matches_season_rating` `umr` on(`umr`.`user_id` = `user`.`id` and `umr`.`season` = `ms`.`season`)) where `user`.`date_created` < `ms`.`end_date` + interval 1 day group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc_s5`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc_s5`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s5`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc_s5` AS select `user`.`id` AS `user_id`,`ms`.`season` AS `season`,sum(if(`ubc`.`bet_won`,1,0)) AS `wins`,sum(if(`ubc`.`bet_won` = 0 and `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0,1,0)) AS `losses`,ifnull(`umr`.`rating_cnt`,0) AS `ratings`,(select `ratings`) * 50 AS `rating_points`,(to_days(if(current_timestamp() < `ms`.`end_date`,current_timestamp(),`ms`.`end_date`)) - to_days(`ms`.`start_date`)) * 20 AS `daily_points`,sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))) AS `bet_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0 and `ubc`.`bet_won` = 0 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `total_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` = 1 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `available_points` from ((((`user` left join `matches_season` `ms` on(`ms`.`season` = 5)) left join `matches_bet_calculation` `ubc` on(`ubc`.`user_id` = `user`.`id` and `ubc`.`match_id` between `ms`.`start_matchid` and ifnull(`ms`.`end_matchid`,`ubc`.`match_id`))) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `ubc`.`match_id`)) left join `uv_matches_season_rating` `umr` on(`umr`.`user_id` = `user`.`id` and `umr`.`season` = `ms`.`season`)) where `user`.`date_created` < `ms`.`end_date` + interval 1 day group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_stats_calc_s6`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_stats_calc_s6`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_stats_calc_s6`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_stats_calc_s6` AS select `user`.`id` AS `user_id`,`ms`.`season` AS `season`,sum(if(`ubc`.`bet_won`,1,0)) AS `wins`,sum(if(`ubc`.`bet_won` = 0 and `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0,1,0)) AS `losses`,ifnull(`umr`.`rating_cnt`,0) AS `ratings`,(select `ratings`) * 50 AS `rating_points`,(to_days(if(current_timestamp() < `ms`.`end_date`,current_timestamp(),`ms`.`end_date`)) - to_days(`ms`.`start_date`)) * 20 AS `daily_points`,sum(if(`ubc`.`bet_won`,`ubc`.`potential_cut_points`,if(`mc`.`pot_valid`,-`ubc`.`points`,0))) AS `bet_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` <> 0 and `mc`.`completed` <> 0 and `ubc`.`bet_won` = 0 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `total_points`,ifnull(sum(case when `ubc`.`bet_won` then `ubc`.`potential_cut_points` when `mc`.`pot_valid` = 1 then -`ubc`.`points` end),0) + 100 + (select `daily_points`) + (select `rating_points`) AS `available_points` from ((((`user` left join `matches_season` `ms` on(`ms`.`season` = 6)) left join `matches_bet_calculation` `ubc` on(`ubc`.`user_id` = `user`.`id` and `ubc`.`match_id` between `ms`.`start_matchid` and ifnull(`ms`.`end_matchid`,`ubc`.`match_id`))) left join `matches_match_calculation` `mc` on(`mc`.`match_id` = `ubc`.`match_id`)) left join `uv_matches_season_rating` `umr` on(`umr`.`user_id` = `user`.`id` and `umr`.`season` = `ms`.`season`)) where `user`.`date_created` < `ms`.`end_date` + interval 1 day group by `user`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_matches_user_bets`
--

/*!50001 DROP TABLE IF EXISTS `uv_matches_user_bets`*/;
/*!50001 DROP VIEW IF EXISTS `uv_matches_user_bets`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_matches_user_bets` AS select `mb`.`user_id` AS `user_id`,`mb`.`match_id` AS `match_id`,`mb`.`points` AS `bet_amount`,`mb`.`team` AS `bet_team`,`mb`.`dt_placed` AS `bet_placed`,`mbc`.`bet_won` AS `bet_won`,`mbc`.`team_base_pot` AS `team_base_pot`,`mbc`.`potential_pot` AS `potential_pot`,`mbc`.`potential_cut_pct` AS `potential_cut_pct`,`mbc`.`potential_cut_points` AS `potential_cut_points`,`mmc`.`completed` AS `completed`,`mmc`.`pot_valid` AS `pot_valid`,`mmc`.`base_pot` AS `base_pot`,`mmc`.`bet_multiplier` AS `bet_multiplier`,`mmc`.`bet_multiplier` * `mmc`.`base_pot` AS `total_pot`,`mmc`.`contestants` AS `contestants`,`mmc`.`contestants_won` AS `contestants_won`,`mmc`.`contestants_lost` AS `contestants_lost`,group_concat(`ms`.`name` separator '; ') AS `bet_on`,`me`.`name` AS `event_name`,`me`.`date_time` AS `event_dt` from ((((((`matches_bet` `mb` join `matches_bet_calculation` `mbc` on(`mbc`.`match_id` = `mb`.`match_id` and `mbc`.`user_id` = `mb`.`user_id`)) join `matches_match_calculation` `mmc` on(`mmc`.`match_id` = `mbc`.`match_id`)) join `matches_contestant` `mc` on(`mc`.`match_id` = `mb`.`match_id` and `mc`.`team` = `mb`.`team`)) join `matches_superstar` `ms` on(`ms`.`id` = `mc`.`superstar_id`)) join `matches_match` `mm` on(`mm`.`id` = `mb`.`match_id`)) join `matches_event` `me` on(`me`.`id` = `mm`.`event_id`)) group by `mc`.`team`,`mb`.`match_id`,`mb`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_poll_active`
--

/*!50001 DROP TABLE IF EXISTS `uv_poll_active`*/;
/*!50001 DROP VIEW IF EXISTS `uv_poll_active`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_poll_active` AS select `BIN_TO_UUID`(`poll_topic`.`id`) AS `id`,`poll_topic`.`content` AS `content`,`poll_topic`.`allow_multi` AS `allow_multi`,`poll_topic`.`hide_votes` AS `hide_votes`,`poll_topic`.`user_id` AS `user_id`,`user`.`username` AS `username`,`poll_topic`.`votes` AS `votes`,`poll_topic`.`expire_dt` AS `expire_dt`,`poll_topic`.`created_dt` AS `created_dt`,timestampdiff(SECOND,current_timestamp(),`poll_topic`.`expire_dt`) AS `ending_in`,`poll_topic`.`admin_hide` AS `admin_hide` from (`poll_topic` left join `user` on(`poll_topic`.`user_id` = `user`.`id`)) where `poll_topic`.`expire_dt` > current_timestamp() and `poll_topic`.`admin_hide` = 0 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_poll_expired`
--

/*!50001 DROP TABLE IF EXISTS `uv_poll_expired`*/;
/*!50001 DROP VIEW IF EXISTS `uv_poll_expired`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_poll_expired` AS select `BIN_TO_UUID`(`poll_topic`.`id`) AS `id`,`poll_topic`.`content` AS `content`,`poll_topic`.`allow_multi` AS `allow_multi`,`poll_topic`.`hide_votes` AS `hide_votes`,`poll_topic`.`user_id` AS `user_id`,`user`.`username` AS `username`,`poll_topic`.`votes` AS `votes`,`poll_topic`.`expire_dt` AS `expire_dt`,`poll_topic`.`created_dt` AS `created_dt`,timestampdiff(SECOND,current_timestamp(),`poll_topic`.`expire_dt`) AS `ending_in`,`poll_topic`.`admin_hide` AS `admin_hide` from (`poll_topic` left join `user` on(`poll_topic`.`user_id` = `user`.`id`)) where `poll_topic`.`expire_dt` < current_timestamp() and `poll_topic`.`admin_hide` = 0 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_poll_info`
--

/*!50001 DROP TABLE IF EXISTS `uv_poll_info`*/;
/*!50001 DROP VIEW IF EXISTS `uv_poll_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_poll_info` AS select `BIN_TO_UUID`(`poll_topic`.`id`) AS `id`,`poll_topic`.`content` AS `content`,`poll_topic`.`allow_multi` AS `allow_multi`,`poll_topic`.`hide_votes` AS `hide_votes`,`poll_topic`.`user_id` AS `user_id`,ifnull(`user`.`username`,'Unregistered User') AS `username`,`poll_topic`.`votes` AS `votes`,`poll_topic`.`expire_dt` AS `expire_dt`,`poll_topic`.`created_dt` AS `created_dt`,timestampdiff(SECOND,current_timestamp(),`poll_topic`.`expire_dt`) AS `ending_in`,`poll_topic`.`admin_hide` AS `admin_hide` from (`poll_topic` left join `user` on(`user`.`id` = `poll_topic`.`user_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_table_size_on_disk`
--

/*!50001 DROP TABLE IF EXISTS `uv_table_size_on_disk`*/;
/*!50001 DROP VIEW IF EXISTS `uv_table_size_on_disk`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_table_size_on_disk` AS select `information_schema`.`TABLES`.`TABLE_SCHEMA` AS `Database`,`information_schema`.`TABLES`.`TABLE_NAME` AS `Table`,round((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`) / 1024 / 1024,0) AS `Size (MB)` from `information_schema`.`TABLES` order by `information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_traffic`
--

/*!50001 DROP TABLE IF EXISTS `uv_traffic`*/;
/*!50001 DROP VIEW IF EXISTS `uv_traffic`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_traffic` AS select `traffic`.`created` AS `created`,`traffic`.`response_code` AS `response_code`,`traffic_request`.`request` AS `request`,`traffic`.`auth_user_id` AS `auth_user_id`,`user`.`username` AS `auth_user_username`,inet6_ntoa(`traffic_ip`.`ip`) AS `inet6_ntoa(traffic_ip.ip)`,`traffic_user_agent`.`user_agent` AS `user_agent` from ((((`traffic` join `traffic_request` on(`traffic`.`request_id` = `traffic_request`.`id`)) join `traffic_user_agent` on(`traffic`.`user_agent_id` = `traffic_user_agent`.`id`)) join `traffic_ip` on(`traffic`.`ip_id` = `traffic_ip`.`id`)) left join `user` on(`traffic`.`auth_user_id` = `user`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_traffic_general_daily`
--

/*!50001 DROP TABLE IF EXISTS `uv_traffic_general_daily`*/;
/*!50001 DROP VIEW IF EXISTS `uv_traffic_general_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_traffic_general_daily` AS select count(`traffic`.`id`) AS `total_traffic`,count(distinct `traffic`.`ip_id`) AS `unique_ips`,cast(`traffic`.`created` as date) AS `date` from `traffic` group by cast(`traffic`.`created` as date) order by cast(`traffic`.`created` as date) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_traffic_ip_daily`
--

/*!50001 DROP TABLE IF EXISTS `uv_traffic_ip_daily`*/;
/*!50001 DROP VIEW IF EXISTS `uv_traffic_ip_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_traffic_ip_daily` AS select inet6_ntoa(`traffic_ip`.`ip`) AS `ip`,count(`traffic`.`ip_id`) AS `total_hits`,cast(`traffic`.`created` as date) AS `date` from (`traffic` join `traffic_ip` on(`traffic_ip`.`id` = `traffic`.`ip_id`)) group by cast(`traffic`.`created` as date),`traffic`.`ip_id` order by cast(`traffic`.`created` as date) desc,count(`traffic`.`ip_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_web_traffic`
--

/*!50001 DROP TABLE IF EXISTS `uv_web_traffic`*/;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_web_traffic` AS select locate('bot',`web_user_agent`.`user_agent`) > 0 AS `bot`,`web_traffic`.`dt` AS `created`,`web_traffic`.`user_id` AS `user_id`,`user`.`username` AS `username`,inet6_ntoa(`web_ip`.`ip`) AS `ip`,`web_uri`.`uri` AS `uri`,`web_user_action`.`user_action` AS `user_action`,`web_user_agent`.`user_agent` AS `user_agent` from (((((`web_traffic` join `web_uri` on(`web_uri`.`id` = `web_traffic`.`uri_id`)) join `web_user_action` on(`web_user_action`.`id` = `web_traffic`.`user_action_id`)) join `web_user_agent` on(`web_user_agent`.`id` = `web_traffic`.`user_agent_id`)) join `web_ip` on(`web_ip`.`id` = `web_traffic`.`ip_id`)) left join `user` on(`user`.`id` = `web_traffic`.`user_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_web_traffic_general_daily`
--

/*!50001 DROP TABLE IF EXISTS `uv_web_traffic_general_daily`*/;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_general_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_web_traffic_general_daily` AS select count(`web_traffic`.`ip_id`) AS `total_traffic`,count(distinct `web_traffic`.`ip_id`) AS `unique_ips`,cast(`web_traffic`.`dt` as date) AS `date` from `web_traffic` group by cast(`web_traffic`.`dt` as date) order by cast(`web_traffic`.`dt` as date) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_web_traffic_ip_daily`
--

/*!50001 DROP TABLE IF EXISTS `uv_web_traffic_ip_daily`*/;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_ip_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_web_traffic_ip_daily` AS select inet6_ntoa(`web_ip`.`ip`) AS `ip`,count(`web_traffic`.`ip_id`) AS `total_hits`,cast(`web_traffic`.`dt` as date) AS `date` from (`web_traffic` join `web_ip` on(`web_ip`.`id` = `web_traffic`.`ip_id`)) group by cast(`web_traffic`.`dt` as date),`web_traffic`.`ip_id` order by cast(`web_traffic`.`dt` as date) desc,count(`web_traffic`.`ip_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_web_traffic_uri_daily`
--

/*!50001 DROP TABLE IF EXISTS `uv_web_traffic_uri_daily`*/;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_uri_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_web_traffic_uri_daily` AS select `web_uri`.`uri` AS `uri`,count(`web_traffic`.`id`) AS `total_traffic`,count(distinct `web_traffic`.`ip_id`) AS `unique_ips`,cast(`web_traffic`.`dt` as date) AS `date` from (`web_traffic` join `web_uri` on(`web_uri`.`id` = `web_traffic`.`uri_id`)) group by cast(`web_traffic`.`dt` as date),`web_traffic`.`uri_id` order by cast(`web_traffic`.`dt` as date) desc,count(`web_traffic`.`id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `uv_web_traffic_useragent_daily`
--

/*!50001 DROP TABLE IF EXISTS `uv_web_traffic_useragent_daily`*/;
/*!50001 DROP VIEW IF EXISTS `uv_web_traffic_useragent_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `uv_web_traffic_useragent_daily` AS select `web_user_agent`.`user_agent` AS `user_agent`,count(`web_traffic`.`user_agent_id`) AS `total_traffic`,count(distinct `web_traffic`.`ip_id`) AS `unique_ips`,cast(`web_traffic`.`dt` as date) AS `date` from (`web_traffic` join `web_user_agent` on(`web_user_agent`.`id` = `web_traffic`.`user_agent_id`)) group by cast(`web_traffic`.`dt` as date),`web_traffic`.`user_agent_id` order by cast(`web_traffic`.`dt` as date) desc,count(`web_traffic`.`user_agent_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `mysql`
--

USE `mysql`;

--
-- Final view structure for view `user`
--

/*!50001 DROP TABLE IF EXISTS `user`*/;
/*!50001 DROP VIEW IF EXISTS `user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `user` AS select `global_priv`.`Host` AS `Host`,`global_priv`.`User` AS `User`,if(json_value(`global_priv`.`Priv`,'$.plugin') in ('mysql_native_password','mysql_old_password'),ifnull(json_value(`global_priv`.`Priv`,'$.authentication_string'),''),'') AS `Password`,if(json_value(`global_priv`.`Priv`,'$.access') & 1,'Y','N') AS `Select_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 2,'Y','N') AS `Insert_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 4,'Y','N') AS `Update_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 8,'Y','N') AS `Delete_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 16,'Y','N') AS `Create_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 32,'Y','N') AS `Drop_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 64,'Y','N') AS `Reload_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 128,'Y','N') AS `Shutdown_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 256,'Y','N') AS `Process_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 512,'Y','N') AS `File_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 1024,'Y','N') AS `Grant_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 2048,'Y','N') AS `References_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 4096,'Y','N') AS `Index_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 8192,'Y','N') AS `Alter_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 16384,'Y','N') AS `Show_db_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 32768,'Y','N') AS `Super_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 65536,'Y','N') AS `Create_tmp_table_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 131072,'Y','N') AS `Lock_tables_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 262144,'Y','N') AS `Execute_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 524288,'Y','N') AS `Repl_slave_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 1048576,'Y','N') AS `Repl_client_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 2097152,'Y','N') AS `Create_view_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 4194304,'Y','N') AS `Show_view_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 8388608,'Y','N') AS `Create_routine_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 16777216,'Y','N') AS `Alter_routine_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 33554432,'Y','N') AS `Create_user_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 67108864,'Y','N') AS `Event_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 134217728,'Y','N') AS `Trigger_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 268435456,'Y','N') AS `Create_tablespace_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 536870912,'Y','N') AS `Delete_history_priv`,elt(ifnull(json_value(`global_priv`.`Priv`,'$.ssl_type'),0) + 1,'','ANY','X509','SPECIFIED') AS `ssl_type`,ifnull(json_value(`global_priv`.`Priv`,'$.ssl_cipher'),'') AS `ssl_cipher`,ifnull(json_value(`global_priv`.`Priv`,'$.x509_issuer'),'') AS `x509_issuer`,ifnull(json_value(`global_priv`.`Priv`,'$.x509_subject'),'') AS `x509_subject`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_questions'),0) as unsigned) AS `max_questions`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_updates'),0) as unsigned) AS `max_updates`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_connections'),0) as unsigned) AS `max_connections`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_user_connections'),0) as signed) AS `max_user_connections`,ifnull(json_value(`global_priv`.`Priv`,'$.plugin'),'') AS `plugin`,ifnull(json_value(`global_priv`.`Priv`,'$.authentication_string'),'') AS `authentication_string`,if(ifnull(json_value(`global_priv`.`Priv`,'$.password_last_changed'),1) = 0,'Y','N') AS `password_expired`,elt(ifnull(json_value(`global_priv`.`Priv`,'$.is_role'),0) + 1,'N','Y') AS `is_role`,ifnull(json_value(`global_priv`.`Priv`,'$.default_role'),'') AS `default_role`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_statement_time'),0.0) as decimal(12,6)) AS `max_statement_time` from `global_priv` */;
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

-- Dump completed on 2022-04-23 23:47:05
