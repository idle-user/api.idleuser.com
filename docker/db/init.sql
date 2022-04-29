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

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;


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

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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


DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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

DROP TABLE IF EXISTS `matches_stable_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches_stable_member` (
  `stable_id` int(11) NOT NULL,
  `superstar_id` int(11) NOT NULL,
  PRIMARY KEY (`stable_id`,`superstar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

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

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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

DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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


/*!50003 DROP FUNCTION IF EXISTS `BIN_TO_UUID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE FUNCTION `BIN_TO_UUID`(_bin BINARY(16)) RETURNS char(36) CHARSET utf8mb4
    DETERMINISTIC
    SQL SECURITY INVOKER
RETURN
        LCASE(CONCAT_WS('-',
            HEX(SUBSTR(_bin,  5, 4)),
            HEX(SUBSTR(_bin,  3, 2)),
            HEX(SUBSTR(_bin,  1, 2)),
            HEX(SUBSTR(_bin,  9, 2)),
            HEX(SUBSTR(_bin, 11))
                 )) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_matches_current_season` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE FUNCTION `func_matches_current_season`() RETURNS int(11)
BEGIN
	DECLARE current_season INT;
    SET current_season = 0;
	SELECT season INTO `current_season`
		FROM `matches_season`
		WHERE NOW() BETWEEN start_date AND end_date;
RETURN current_season;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `func_matches_match_season` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE FUNCTION `func_matches_match_season`(match_id INT) RETURNS int(11)
BEGIN
	DECLARE out_match_season INT;
    SET out_match_season = 0;
	SELECT season INTO out_match_season
		FROM `matches_season`
		WHERE match_id BETWEEN start_matchid AND IFNULL(end_matchid,match_id);
RETURN out_match_season;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `UUID_TO_BIN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE FUNCTION `UUID_TO_BIN`(_uuid BINARY(36)) RETURNS binary(16)
    DETERMINISTIC
    SQL SECURITY INVOKER
RETURN
        UNHEX(CONCAT(
            SUBSTR(_uuid, 15, 4),
            SUBSTR(_uuid, 10, 4),
            SUBSTR(_uuid,  1, 8),
            SUBSTR(_uuid, 20, 4),
            SUBSTR(_uuid, 25) )) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_api_ins_auth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_api_ins_auth`(
	IN in_uid INT(11) UNSIGNED,
    IN in_token BINARY(32)
)
BEGIN

    DECLARE t_now DATETIME;
    DECLARE t_exp DATETIME;
    DECLARE t_access INT;

    SELECT NOW() INTO t_now;
    SELECT t_now + INTERVAL 1 YEAR INTO t_exp;
    SELECT access INTO t_access FROM `user` WHERE id=in_uid;

	INSERT INTO `api_auth`
		(auth_token, auth_token_exp, access_level, user_id, created, last_updated)
	VALUES
        (in_token, t_exp, t_access, in_uid, t_now, t_now)
    ON DUPLICATE KEY UPDATE
		auth_token=in_token,
        auth_token_exp=t_exp,
        access_level=t_access,
		last_updated=t_now;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_chatroom_sel_command` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_chatroom_sel_command`(
	IN in_command VARCHAR(45))
BEGIN
	DECLARE res_success INT;
    DECLARE res_message TEXT;

	SET res_success=0;
    SET res_message='Command not found';


	SELECT
		1, response
        INTO
        res_success, res_message
	FROM
		`chatroom_command`
	WHERE
		command=in_command;


    SELECT
		res_message AS message,
        res_success AS success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_ins_bet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_ins_bet`(
	IN in_user_id INT,
    IN in_match_id INT,
    IN in_team INT,
    IN in_points BIGINT)
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);
	DECLARE match_season INT;
    DECLARE date_season INT;

    SET res_success=0;
    SET res_message='Unhandled Exception';


	IF in_points<=0
		THEN
			SET res_message='Invalid bet amount';
	ELSE

        SET match_season=(SELECT `func_matches_match_season`(in_match_id));
		SET date_season=(SELECT `func_matches_current_season`());
		IF date_season=0
			THEN
				SET res_message='Could not find season for current date';
		ELSEIF match_season=0
			THEN
				SET res_message='Could not find season for the match';
		ELSEIF date_season<>match_season
			THEN
				SET res_message='Match and date seasons do not match';

		ELSEIF (SELECT 1 FROM `matches_bet` WHERE user_id=in_user_id AND match_id=in_match_id)=1
			THEN
				SET res_message='Match already bet on';

		ELSEIF  (SELECT match_type_id FROM `matches_match` WHERE id=in_match_id)=0
			THEN
				SET res_message='Invalid match';

		ELSEIF  (SELECT bet_open FROM `matches_match` WHERE id=in_match_id)=0
			THEN
				SET res_message='Match bets are closed';

		ELSEIF CURDATE()>(SELECT DATE(date_time) FROM `matches_match`,`matches_event` WHERE `matches_match`.event_id=`matches_event`.id AND `matches_match`.id=in_match_id)
			THEN
				SET res_message='Cannot bet on match after event';

		ELSEIF (SELECT 1 FROM `matches_contestant` WHERE match_id=in_match_id AND team=in_team LIMIT 1) IS NULL
			THEN
				SET res_message='Invalid team for bet';
		ELSE

			CALL `usp_matches_upd_stats_all`(match_season);
			IF in_points>(SELECT available_points FROM `matches_stats` WHERE user_id=in_user_id AND season=match_season)
				THEN
					SET res_message='Not enough points available';

            ELSE
				INSERT INTO `matches_bet`
					(user_id, match_id, team, points, dt_placed)
				VALUES
					(in_user_id, in_match_id, in_team, in_points, NOW());
                IF ROW_COUNT()=1
					THEN
						SET res_success=1;
						SET res_message='Bet placed';
				ELSE
					SET res_message='Failed to place bet';
				END IF;
			END IF;
		END IF;
	END IF;

    SELECT
		res_message AS message,
        res_success AS success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_ins_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_ins_rating`(
	IN in_user_id INT,
    IN in_match_id INT,
    IN in_rating DOUBLE)
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);

	SET res_success=0;
    SET res_message='Unhandled Exception';


	IF in_rating<=0 OR in_rating>5
		THEN
			SET res_message='Invalid rating';

    ELSEIF (SELECT 1 FROM `matches_match` WHERE `matches_match`.id=in_match_id) IS NULL
		THEN
			SET res_message='Invalid match';

    ELSEIF (SELECT team_won FROM `matches_match` WHERE `matches_match`.id=in_match_id)=0
		THEN
			SET res_message='Cannot rate a match that has not ended';

    ELSEIF CURDATE()<(SELECT DATE(date_time) FROM `matches_match`,`matches_event` WHERE `matches_match`.event_id=`matches_event`.id AND `matches_match`.id=in_match_id)
		THEN
			SET res_message='Cannot rate a future match';
    ELSE
		INSERT INTO `matches_match_rating`
			(user_id, match_id, rating, updated)
		VALUES
			(in_user_id, in_match_id, in_rating, NOW())
		ON DUPLICATE KEY UPDATE
			rating=in_rating,
			updates=updates+1,
			updated=NOW();

        IF ROW_COUNT()=1
			THEN
				SET res_success=1;
				SET res_message='Match rated';

        ELSEIF ROW_COUNT()=2
			THEN
				SET res_success=1;
				SET res_message='Match rating updated';
		ELSE
			SET res_message='Failed to rate match';
		END IF;
	END IF;

	SELECT
		res_message AS message,
        res_success AS success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_ins_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_ins_stats`(
	IN in_uid INT UNSIGNED
)
BEGIN
	INSERT INTO `matches_stats` (user_id, season) values (in_uid, `func_matches_current_season`());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_current_bets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_current_bets`(IN in_user_id INT)
BEGIN
	SELECT
		`matches_bet`.match_id AS match_id,
		`matches_bet`.user_id AS user_id,
		GROUP_CONCAT(`matches_superstar`.name) AS 'contestants',
		`matches_bet`.points AS points,
		ubc.potential_cut_pct AS potential_cut_pct,
		ubc.potential_cut_points AS potential_cut_points
	FROM `matches_bet`
	JOIN `matches_bet_calculation` ubc ON ubc.match_id=`matches_bet`.match_id AND ubc.user_id=`matches_bet`.user_id
	JOIN `matches_match` ON `matches_match`.id=`matches_bet`.match_id
	JOIN `matches_contestant` mc ON mc.match_id=`matches_bet`.match_id AND mc.team=`matches_bet`.team
	JOIN `matches_superstar` ON `matches_superstar`.id=mc.superstar_id
	WHERE `matches_match`.team_won=0 AND `matches_bet`.user_id=in_user_id
	GROUP BY `matches_bet`.match_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_current_match` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_current_match`()
BEGIN
	SELECT
		`matches_match`.id AS id,
		`matches_match_calculation`.completed AS completed,
		`matches_match`.bet_open AS bet_open,
		`matches_match_calculation`.pot_valid AS pot_valid,
		`matches_event`.name AS `matches_event`,
		`matches_event`.date_time AS `date`,
		`matches_title`.name AS title,
		`matches_match_type`.name AS match_type,
		`matches_match`.match_note AS match_note,
		`matches_match`.team_won AS team_won,
		`matches_match`.winner_note AS winner_note,
		`matches_match_calculation`.contestants AS contestants,
		`matches_match_calculation`.contestants_won AS contestants_won,
		`matches_match_calculation`.contestants_lost AS contestants_lost,
		`matches_match_calculation`.bet_multiplier AS bet_multiplier,
		`matches_match_calculation`.base_pot AS base_pot,
		`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier AS total_pot,
		`matches_match_calculation`.base_winner_pot AS base_winner_pot,
		`matches_match_calculation`.base_loser_pot AS base_loser_pot,
		`matches_match_calculation`.user_bet_cnt AS user_bet_cnt,
		`matches_match_calculation`.user_bet_winner_cnt AS user_bet_winner_cnt,
		`matches_match_calculation`.user_bet_loser_cnt AS user_bet_loser_cnt,
		`matches_match_calculation`.user_rating_avg AS user_rating_avg,
		`matches_match_calculation`.user_rating_cnt AS user_rating_cnt
	FROM
		`matches_match`
	LEFT JOIN
		`matches_event` ON `matches_event`.id=`matches_match`.event_id
	LEFT JOIN
		`matches_title` ON `matches_title`.id=`matches_match`.title_id
	LEFT JOIN
		`matches_match_type` ON `matches_match_type`.id=`matches_match`.match_type_id
	LEFT JOIN
		`matches_match_calculation` ON `matches_match_calculation`.match_id=`matches_match`.id
	WHERE
		`matches_match_calculation`.completed=0 AND
		`matches_match_calculation`.pot_valid AND
        `matches_match`.bet_open=0
	GROUP BY
		`matches_match`.id
	ORDER BY
		`matches_match`.last_updated DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_future_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_future_event`(
	IN in_ppv_check INT)
BEGIN
	SELECT
		*
	FROM
		`matches_event`
	WHERE
		date_time>NOW() AND
        ppv=IF(in_ppv_check=1,1,ppv)
	ORDER BY
		date_time;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_leaderboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_leaderboard`(
	IN in_season INT)
BEGIN

	SELECT
		us.*,
        u.username
	FROM
		`matches_stats` us
	JOIN
		`user` u ON u.id=us.user_id
    WHERE
		wins+losses>0 AND
        season=in_season
	ORDER BY
		total_points DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_match_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_match_by_id`(
	IN in_match_id INT)
BEGIN
	SELECT
		`matches_match`.id AS id,
		`matches_match_calculation`.completed AS completed,
		`matches_match`.bet_open AS bet_open,
		`matches_match_calculation`.pot_valid AS pot_valid,
		`matches_event`.name AS `event`,
        `matches_event`.date_time AS `date`,
		`matches_title`.name AS title,
		`matches_match_type`.name AS match_type,
		`matches_match`.match_note AS match_note,
        `matches_match`.team_won AS team_won,
		`matches_match`.winner_note AS winner_note,
		`matches_match_calculation`.contestants AS contestants,
		`matches_match_calculation`.contestants_won AS contestants_won,
		`matches_match_calculation`.contestants_lost AS contestants_lost,
		`matches_match_calculation`.bet_multiplier AS bet_multiplier,
		`matches_match_calculation`.base_pot AS base_pot,
        `matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier AS total_pot,
		`matches_match_calculation`.base_winner_pot AS base_winner_pot,
		`matches_match_calculation`.base_loser_pot AS base_loser_pot,
		`matches_match_calculation`.user_bet_cnt AS user_bet_cnt,
		`matches_match_calculation`.user_bet_winner_cnt AS user_bet_winner_cnt,
		`matches_match_calculation`.user_bet_loser_cnt AS user_bet_loser_cnt,
		`matches_match_calculation`.user_rating_avg AS user_rating_avg,
		`matches_match_calculation`.user_rating_cnt AS user_rating_cnt
	FROM
		`matches_match`
	LEFT JOIN
		`matches_event` ON `matches_event`.id=`matches_match`.event_id
	LEFT JOIN
		`matches_title` ON `matches_title`.id=`matches_match`.title_id
	LEFT JOIN
		`matches_match_type` ON `matches_match_type`.id=`matches_match`.match_type_id
	LEFT JOIN
		`matches_match_calculation` ON `matches_match_calculation`.match_id=`matches_match`.id
	WHERE
		`matches_match`.id=in_match_id
	GROUP BY
		`matches_match`.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_match_by_superstar_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_match_by_superstar_name`(
	IN in_superstar_name VARCHAR(45))
BEGIN
	SELECT
		`matches_match`.id AS id,
		`matches_match_calculation`.completed AS completed,
		`matches_match`.bet_open AS bet_open,
		`matches_match_calculation`.pot_valid AS pot_valid,
		`matches_event`.name AS `matches_event`,
        `matches_event`.date_time AS `date`,
		`matches_title`.name AS title,
		`matches_match_type`.name AS match_type,
		`matches_match`.match_note AS match_note,
        `matches_match`.team_won AS team_won,
		`matches_match`.winner_note AS winner_note,
		`matches_match_calculation`.contestants AS contestants,
		`matches_match_calculation`.contestants_won AS contestants_won,
		`matches_match_calculation`.contestants_lost AS contestants_lost,
		`matches_match_calculation`.bet_multiplier AS bet_multiplier,
		`matches_match_calculation`.base_pot AS base_pot,
		`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier AS total_pot,
		`matches_match_calculation`.base_winner_pot AS base_winner_pot,
		`matches_match_calculation`.base_loser_pot AS base_loser_pot,
		`matches_match_calculation`.user_bet_cnt AS user_bet_cnt,
		`matches_match_calculation`.user_bet_winner_cnt AS user_bet_winner_cnt,
		`matches_match_calculation`.user_bet_loser_cnt AS user_bet_loser_cnt,
		`matches_match_calculation`.user_rating_avg AS user_rating_avg,
		`matches_match_calculation`.user_rating_cnt AS user_rating_cnt
	FROM
		`matches_match`
	LEFT JOIN
		`matches_event` ON `matches_event`.id=`matches_match`.event_id
	LEFT JOIN
		`matches_title` ON `matches_title`.id=`matches_match`.title_id
	LEFT JOIN
		`matches_match_type` ON `matches_match_type`.id=`matches_match`.match_type_id
	LEFT JOIN
		`matches_match_calculation` ON `matches_match_calculation`.match_id=`matches_match`.id
	WHERE
		`matches_match_calculation`.contestants LIKE CONCAT('%',in_superstar_name,'%')
	GROUP BY
		`matches_match`.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_match_recent_completed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_match_recent_completed`()
BEGIN
	SELECT
		`matches_match`.id AS id,
		`matches_match_calculation`.completed AS completed,
		`matches_match`.bet_open AS bet_open,
		`matches_match_calculation`.pot_valid AS pot_valid,
		`matches_event`.name AS `matches_event`,
		`matches_event`.date_time AS `date`,
		`matches_title`.name AS title,
		`matches_match_type`.name AS match_type,
		`matches_match`.match_note AS match_note,
		`matches_match`.team_won AS team_won,
		`matches_match`.winner_note AS winner_note,
		`matches_match_calculation`.contestants AS contestants,
		`matches_match_calculation`.contestants_won AS contestants_won,
		`matches_match_calculation`.contestants_lost AS contestants_lost,
		`matches_match_calculation`.bet_multiplier AS bet_multiplier,
		`matches_match_calculation`.base_pot AS base_pot,
		`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier AS total_pot,
		`matches_match_calculation`.base_winner_pot AS base_winner_pot,
		`matches_match_calculation`.base_loser_pot AS base_loser_pot,
		`matches_match_calculation`.user_bet_cnt AS user_bet_cnt,
		`matches_match_calculation`.user_bet_winner_cnt AS user_bet_winner_cnt,
		`matches_match_calculation`.user_bet_loser_cnt AS user_bet_loser_cnt,
		`matches_match_calculation`.user_rating_avg AS user_rating_avg,
		`matches_match_calculation`.user_rating_cnt AS user_rating_cnt
	FROM
		`matches_match`
	LEFT JOIN
		`matches_event` ON `matches_event`.id=`matches_match`.event_id
	LEFT JOIN
		`matches_title` ON `matches_title`.id=`matches_match`.title_id
	LEFT JOIN
		`matches_match_type` ON `matches_match_type`.id=`matches_match`.match_type_id
	LEFT JOIN
		`matches_match_calculation` ON `matches_match_calculation`.match_id=`matches_match`.id
	WHERE
		`matches_match_calculation`.completed=1 AND
		`matches_match`.last_updated > NOW() - INTERVAL 10 MINUTE
	GROUP BY
		`matches_match`.id
	ORDER BY
		`matches_match`.last_updated DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_match_teams` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_match_teams`(
	IN in_match_id INT)
BEGIN
	SELECT
		`matches_contestant`.match_id,
		`matches_contestant`.team,
		`matches_contestant`.bet_multiplier,
		GROUP_CONCAT(`matches_superstar`.name) AS members
	FROM `matches_contestant`
	JOIN `matches_superstar` ON `matches_superstar`.id=`matches_contestant`.superstar_id
	WHERE `matches_contestant`.match_id=in_match_id
	GROUP BY team
	ORDER BY team;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_match_teams_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_match_teams_by_id`(
	IN in_match_id INT)
BEGIN
	SELECT
		`matches_contestant`.team,
		`matches_contestant`.bet_multiplier,
		GROUP_CONCAT(`matches_superstar`.name) AS members
	FROM `matches_contestant`
	JOIN `matches_superstar` ON `matches_superstar`.id=`matches_contestant`.superstar_id
	WHERE `matches_contestant`.match_id=in_match_id
	GROUP BY team
	ORDER BY team;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_stats_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_stats_by_id`(
	IN in_user_id INT,
    IN in_season INT)
BEGIN
	IF in_season=`func_matches_current_season`()
		THEN
			CALL `usp_matches_upd_stats_all`(in_season);
	END IF;

    SELECT
		*,
        IFNULL(wins/losses, 'N/A') AS winloss_ratio
    FROM
		`matches_stats` us
	WHERE
		user_id=in_user_id AND season=in_season;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_stats_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_stats_by_name`(
	IN in_username VARCHAR(255),
    IN in_season INT)
BEGIN
	IF in_season=`func_matches_current_season`()
		THEN
			CALL `usp_matches_upd_stats_all`(in_season);
	END IF;

    SELECT
		us.*,
        u.username,
        IFNULL(wins/losses, 'N/A') AS winloss_ratio
    FROM
		`matches_stats` us
	JOIN
		`user` u ON u.id=us.user_id
	WHERE
		us.season=in_season
        AND u.username LIKE CONCAT('%', in_username, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_superstar_birthday_upcoming` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_superstar_birthday_upcoming`()
BEGIN
	SELECT
		*
	FROM
		`matches_superstar`
	LEFT JOIN
		`matches_superstar_social` ON `matches_superstar`.id=superstar_id
	WHERE
		brand_id<5 AND
		MONTH(dob)>=MONTH(CURRENT_TIMESTAMP) AND
		DAY(dob)>=DAY(CURRENT_TIMESTAMP)
	ORDER BY
		DAYOFYEAR(dob)
	LIMIT 15;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_superstar_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_superstar_by_id`(IN in_superstar_id INT)
BEGIN
	SELECT
		`matches_superstar`.*,
        YEAR(CURRENT_TIMESTAMP) - YEAR(dob) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(dob, 5)) AS age
	FROM
		`matches_superstar`
	WHERE
		`matches_superstar`.id=in_superstar_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_superstar_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_superstar_by_name`(IN in_superstar_name VARCHAR(255))
BEGIN
	SELECT
		`matches_superstar`.*,
        YEAR(CURRENT_TIMESTAMP) - YEAR(dob) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(dob, 5)) AS age
	FROM
		`matches_superstar`
	WHERE
		`matches_superstar`.name LIKE CONCAT('%',in_superstar_name,'%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_sel_validate_bet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_sel_validate_bet`(
    IN in_user_id INT,
    IN in_match_id INT,
    IN in_team INT,
    IN in_points BIGINT)
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);
	DECLARE match_season INT;
    DECLARE date_season INT;

    SET res_success=0;
    SET res_message='Unhandled Exception';


	IF in_points<=0
		THEN
			SET res_message='Invalid bet amount';
	ELSE

        SET match_season=(SELECT `func_matches_match_season`(in_match_id));
		SET date_season=(SELECT `func_matches_current_season`());
		IF date_season=0
			THEN
				SET res_message='Could not find season for current date';
		ELSEIF match_season=0
			THEN
				SET res_message='Could not find season for the match';
		ELSEIF date_season<>match_season
			THEN
				SET res_message='Match and date seasons do not match';

		ELSEIF (SELECT 1 FROM `matches_bet` WHERE user_id=in_user_id AND match_id=in_match_id)=1
			THEN
				SET res_message='Match already bet on';

		ELSEIF  (SELECT match_type_id FROM `matches_match` WHERE id=in_match_id)=0
			THEN
				SET res_message='Invalid match';

		ELSEIF  (SELECT bet_open FROM `matches_match` WHERE id=in_match_id)=0
			THEN
				SET res_message='Match bets are closed';

		ELSEIF CURDATE()>(SELECT DATE(date_time) FROM `matches_match`,`matches_event` WHERE `matches_match`.event_id=`matches_event`.id AND `matches_match`.id=in_match_id)
			THEN
				SET res_message='Cannot bet on match after event';

		ELSEIF (SELECT 1 FROM `matches_contestant` WHERE match_id=in_match_id AND team=in_team LIMIT 1) IS NULL
			THEN
				SET res_message='Invalid team for bet';
		ELSE

			CALL `usp_matches_upd_stats_all`(match_season);
			IF in_points>(SELECT available_points FROM `matches_stats` WHERE user_id=in_user_id AND season=match_season)
				THEN
					SET res_message='Not enough points available';

            ELSE
				SET res_success=1;
				SET res_message='Valid';
			END IF;
		END IF;
	END IF;

    SELECT
		res_message AS message,
        res_success AS success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_upd_bet_calculation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_upd_bet_calculation`(IN in_match_id INT)
BEGIN
	INSERT INTO `matches_bet_calculation` (
		match_id
        ,user_id
		,points
		,team_base_pot
		,potential_pot
		,potential_cut_pct
		,potential_cut_points
		,bet_won
		,last_updated
    )
		SELECT
			ub.match_id AS t_match_id
			,ub.user_id AS t_user_id
			,ub.points AS t_points
			,SUM(IF(tub.team=ub.team,tub.points,0)) AS t_team_base_pot
			,SUM(tub.points)*bm.bet_multiplier AS t_potential_pot
			,CAST(ub.points AS DECIMAL(40,20))/SUM(IF(tub.team=ub.team,tub.points,0)) AS t_potential_cut_pct
			,(SUM(tub.points)*bm.bet_multiplier)*(CAST(ub.points AS DECIMAL(40,20))/SUM(IF(tub.team=ub.team,tub.points,0))) AS t_potential_cut_points
			,IF(ub.team=m.team_won,1,0) AS t_bet_won
			,NOW() AS t_last_updated
		FROM
			`matches_bet` ub
		JOIN `matches_match` m ON m.id=ub.match_id
		JOIN (
			SELECT t.match_id, t.team, t.bet_multiplier
			FROM `matches_contestant` t
			WHERE t.match_id=in_match_id
			GROUP BY t.team) bm ON bm.team=ub.team
		JOIN (
			SELECT t.match_id,t.team AS team,SUM(t.points) AS points
			FROM `matches_bet` t
			WHERE t.match_id=in_match_id
			GROUP BY t.match_id, t.team) tub ON tub.match_id=ub.match_id
		WHERE ub.match_id=in_match_id
		GROUP BY ub.user_id
	ON DUPLICATE KEY UPDATE
		points=values(points)
		,team_base_pot=values(team_base_pot)
		,potential_pot=values(potential_pot)
		,potential_cut_pct=values(potential_cut_pct)
		,potential_cut_points=values(potential_cut_points)
		,bet_won=values(bet_won)
		,last_updated=values(last_updated);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_upd_match_calculation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_upd_match_calculation`(IN in_match_id INT)
BEGIN

	DECLARE t_completed INT;
	DECLARE t_pot_valid TINYINT;
	DECLARE t_contestants TEXT;
	DECLARE t_contestants_won TEXT;
	DECLARE t_contestants_lost TEXT;
    DECLARE t_bet_multiplier INT;
	DECLARE t_base_pot BIGINT;
	DECLARE t_base_winner_pot BIGINT;
	DECLARE t_base_loser_pot BIGINT;
	DECLARE t_user_bet_cnt INT;
	DECLARE t_user_bet_winner_cnt INT;
    DECLARE t_user_bet_loser_cnt INT;
	DECLARE t_user_rating_cnt INT;
	DECLARE t_user_rating_avg DOUBLE;
	DECLARE t_last_updated DATETIME;

	SELECT
		IF(m.team_won<>0,1,0) AS completed
		,IF(m.team_won<>999,1,0) AS pot_valid
		,IFNULL(GROUP_CONCAT(DISTINCT s.name SEPARATOR '; '),'') AS contestants
		,IFNULL(GROUP_CONCAT(DISTINCT IF(m.team_won=mc.team,s.name,NULL) SEPARATOR '; '),'') AS contestants_won
		,IFNULL(GROUP_CONCAT(DISTINCT IF(m.team_won=mc.team OR m.team_won=0 OR m.team_won=999, NULL, s.name) SEPARATOR '; '),'') AS contestants_lost
		,IFNULL(wc.bet_multiplier, 1) AS `bet_multiplier`
        ,ub.base_pot AS base_pot
		,ub.base_winner_pot AS base_winner_pot
		,ub.base_loser_pot AS base_loser_pot
		,ub.user_bet_cnt AS user_bet_cnt
		,ub.user_bet_winner_cnt AS user_bet_winner_cnt
		,ub.user_bet_loser_cnt AS user_bet_loser_cnt
		,COUNT(DISTINCT umr.user_id) AS user_rating_cnt
		,IFNULL(AVG(umr.rating),0) AS user_rating_avg
		,NOW() as last_updated
	INTO
		t_completed
		,t_pot_valid
		,t_contestants
		,t_contestants_won
		,t_contestants_lost
        ,t_bet_multiplier
		,t_base_pot
		,t_base_winner_pot
		,t_base_loser_pot
		,t_user_bet_cnt
		,t_user_bet_winner_cnt
        ,t_user_bet_loser_cnt
		,t_user_rating_cnt
		,t_user_rating_avg
		,t_last_updated
	FROM `matches_match` m
	LEFT JOIN `matches_contestant` mc ON mc.match_id=m.id
	LEFT JOIN `matches_superstar` s ON s.id=mc.superstar_id
	LEFT JOIN `matches_match_rating` umr ON umr.match_id=m.id
    LEFT JOIN `matches_contestant` wc ON wc.match_id=m.id AND wc.team=m.team_won
	LEFT JOIN (
		SELECT
			t.id AS match_id
			,IFNULL(SUM(tub.points),0) AS base_pot
			,IFNULL(SUM(IF(tub.team=t.team_won,tub.points,0)),0) AS base_winner_pot
			,IFNULL(SUM(IF(tub.team=t.team_won OR t.team_won=0 OR t.team_won=999,0,tub.points)),0) AS base_loser_pot
			,COUNT(tub.user_id) AS user_bet_cnt
			,IFNULL(SUM(IF(tub.team=t.team_won,1,0)),0) as user_bet_winner_cnt
			,IFNULL(SUM(IF(tub.team=t.team_won OR t.team_won=0 OR t.team_won=999,0,1)),0) AS user_bet_loser_cnt
		FROM
			`matches_match` t
		JOIN `matches_bet` tub ON t.id=tub.match_id
		WHERE t.id=in_match_id
		) ub ON ub.match_id=m.id
	WHERE m.id=in_match_id;

    INSERT INTO `matches_match_calculation` (
		match_id
        ,completed
        ,pot_valid
		,contestants
		,contestants_won
		,contestants_lost
		,bet_multiplier
		,base_pot
		,base_winner_pot
		,base_loser_pot
		,user_bet_cnt
		,user_bet_winner_cnt
		,user_bet_loser_cnt
		,user_rating_avg
		,user_rating_cnt
		,last_updated)
	VALUES (
		in_match_id
		,t_completed
		,t_pot_valid
		,t_contestants
		,t_contestants_won
		,t_contestants_lost
		,t_bet_multiplier
		,t_base_pot
		,t_base_winner_pot
		,t_base_loser_pot
		,t_user_bet_cnt
		,t_user_bet_winner_cnt
        ,t_user_bet_loser_cnt
		,t_user_rating_cnt
		,t_user_rating_avg
		,t_last_updated
		) ON DUPLICATE KEY UPDATE
		completed=t_completed
		,pot_valid=t_pot_valid
		,contestants=t_contestants
		,contestants_won=t_contestants_won
		,contestants_lost=t_contestants_lost
		,bet_multiplier=t_bet_multiplier
		,base_pot=t_base_pot
		,base_winner_pot=t_base_winner_pot
		,base_loser_pot=t_base_loser_pot
		,user_bet_cnt=t_user_bet_cnt
		,user_bet_winner_cnt=t_user_bet_winner_cnt
        ,user_bet_loser_cnt=t_user_bet_loser_cnt
		,user_rating_cnt=t_user_rating_cnt
		,user_rating_avg=t_user_rating_avg
		,last_updated=t_last_updated;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_matches_upd_stats_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_matches_upd_stats_all`(
	IN in_season INT)
BEGIN
	CASE
		WHEN in_season=1 THEN
		 SELECT 1;
		WHEN in_season=2 THEN
         SELECT 1;
		WHEN in_season=3 THEN
          SELECT 1;
		WHEN in_season=4 THEN
		  SELECT 1;
		WHEN in_season=5 THEN
		  SELECT 1;
		WHEN in_season=6 THEN
			INSERT INTO `matches_stats` (user_id, season, wins, losses, ratings, rating_points, daily_points, bet_points, total_points, available_points, updated)
				SELECT *, NOW() FROM `uv_matches_stats_calc_s6` vusc
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
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_poll_upd_item_votes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_poll_upd_item_votes`()
BEGIN
	UPDATE `poll_item` pi
    SET pi.votes = (SELECT COUNT(*) FROM `poll_vote` pv WHERE pv.item_id=pi.id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_traffic_ins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_traffic_ins`(
    IN in_request TEXT,
	IN in_user_agent TEXT,
    IN in_ip TEXT,
    IN in_auth_user_id INT
)
BEGIN

    DECLARE t_now DATETIME;
    DECLARE t_id CHAR(36);
	DECLARE t_request_id BINARY(16);
    DECLARE t_user_agent_id BINARY(16);
	DECLARE t_ip_id BINARY(16);

    SELECT NOW() INTO t_now;


	INSERT INTO `traffic_request`
		(id, request, md5hash, created, last_accessed, access_cnt)
	VALUES
        (UUID_TO_BIN(UUID()), in_request, UNHEX(MD5(in_request)), t_now, t_now, 1)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now,
        access_cnt=access_cnt+1;
	SELECT id INTO t_request_id FROM `traffic_request` WHERE md5hash=UNHEX(MD5(in_request));


	INSERT INTO `traffic_user_agent`
		(id, user_agent, md5hash, created, last_accessed, access_cnt)
	VALUES
        (UUID_TO_BIN(UUID()), in_user_agent, UNHEX(MD5(in_user_agent)), t_now, t_now, 1)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now,
		access_cnt=access_cnt+1;
	SELECT id INTO t_user_agent_id FROM `traffic_user_agent` WHERE md5hash=UNHEX(MD5(in_user_agent));

    INSERT INTO `traffic_ip`
		(id, ip, created, last_accessed, access_cnt)
	VALUES
        (UUID_TO_BIN(UUID()), INET6_ATON(in_ip), t_now, t_now, 1)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now,
        access_cnt=access_cnt+1;
	SELECT id INTO t_ip_id FROM `traffic_ip` WHERE ip=INET6_ATON(in_ip);

    SELECT UUID() INTO t_id;

    INSERT INTO `traffic`
		(id, request_id, user_agent_id, ip_id, auth_user_id, created)
	VALUES
		(UUID_TO_BIN(t_id), t_request_id, t_user_agent_id, t_ip_id, in_auth_user_id, t_now);


    SELECT t_id AS `uuid`, `traffic`.* FROM `traffic` WHERE id=UUID_TO_BIN(t_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_user_ins_from_chatango` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_user_ins_from_chatango`(
	IN in_username VARCHAR(45))
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);

    SET res_success=0;
    SET res_message='Unhandled Exception';


    IF EXISTS (SELECT username FROM `user` WHERE username=in_username)
		THEN
			SET res_message='Username already exists';
	ELSEIF EXISTS (SELECT chatango_id FROM `user` WHERE chatango_id=in_username)
		THEN
			SET res_message='Chatango ID already exists';
    ELSE
		INSERT INTO `user`
			(username, chatango_id, date_created, chatango_last_updated)
		VALUES
			(in_username, in_username, NOW(), NOW());
		IF ROW_COUNT()=1
			THEN
				SET res_success=1;
				SET res_message='Successfully registered';
		ELSE
			SET res_message='Failed to register';
		END IF;
	END IF;

	SELECT
		res_message AS message,
        res_success AS success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_user_ins_from_discord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_user_ins_from_discord`(
	IN in_username VARCHAR(45),
    IN in_discord_id VARCHAR(45))
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);

    SET res_success=0;
    SET res_message='Unhandled Exception';


    IF EXISTS (SELECT username FROM `user` WHERE username=in_username)
		THEN
			SET res_message='Username already exists';
	ELSEIF EXISTS (SELECT discord_id FROM `user` WHERE discord_id=in_discord_id)
		THEN
			SET res_message='Discord ID already exists';
    ELSE
		INSERT INTO `user`
			(username, discord_id, date_created, discord_last_updated)
		VALUES
			(in_username, in_discord_id, NOW(), NOW());
		IF ROW_COUNT()=1
			THEN
				SET res_success=1;
				SET res_message='Successfully registered';
		ELSE
			SET res_message='Failed to register';
		END IF;
	END IF;

	SELECT
		res_message AS message,
        res_success AS success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_web_ins_traffic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `usp_web_ins_traffic`(
	IN in_uid INT(11) UNSIGNED,
    IN in_ip TEXT,
    IN in_uri TEXT,
    IN in_user_agent TEXT,
    IN in_user_action TEXT
)
BEGIN

    DECLARE t_now DATETIME;
    DECLARE t_ip_id BINARY(16);
    DECLARE t_uri_id BINARY(16);
    DECLARE t_user_agent_id BINARY(16);
    DECLARE t_user_action_id BINARY(16);

    SELECT NOW() INTO t_now;


    INSERT INTO `web_ip`
		(id, ip, created, last_accessed)
	VALUES
        (UUID_TO_BIN(UUID()), INET6_ATON(in_ip), t_now, t_now)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now;
	SELECT id INTO t_ip_id FROM `web_ip` WHERE ip=INET6_ATON(in_ip);


	INSERT INTO `web_uri`
		(id, uri, md5hash, created, last_accessed)
	VALUES
        (UUID_TO_BIN(UUID()), in_uri, UNHEX(MD5(in_uri)), t_now, t_now)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now;
	SELECT id INTO t_uri_id FROM `web_uri` WHERE md5hash=UNHEX(MD5(in_uri));


	INSERT INTO `web_user_agent`
		(id, user_agent, md5hash, created, last_accessed)
	VALUES
        (UUID_TO_BIN(UUID()), in_user_agent, UNHEX(MD5(in_user_agent)), t_now, t_now)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now;
	SELECT id INTO t_user_agent_id FROM `web_user_agent` WHERE md5hash=UNHEX(MD5(in_user_agent));


	INSERT INTO `web_user_action`
		(id, user_action, md5hash, created, last_accessed)
	VALUES
        (UUID_TO_BIN(UUID()), in_user_action, UNHEX(MD5(in_user_action)), t_now, t_now)
    ON DUPLICATE KEY UPDATE
		last_accessed=t_now;
	SELECT id INTO t_user_action_id FROM `web_user_action` WHERE md5hash=UNHEX(MD5(in_user_action));


    INSERT INTO `web_traffic`
		(id, user_id, ip_id, uri_id, user_agent_id, user_action_id, dt)
	VALUES
		(UUID_TO_BIN(UUID()), in_uid, t_ip_id, t_uri_id, t_user_agent_id, t_user_action_id, t_now);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `user_bet_AFTER_INSERT` AFTER INSERT ON `matches_bet` FOR EACH ROW
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
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `user_bet_AFTER_UPDATE` AFTER UPDATE ON `matches_bet` FOR EACH ROW
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `match_contestant_AFTER_INSERT` AFTER INSERT ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END */;;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `match_contestant_AFTER_UPDATE` AFTER UPDATE ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END */;;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `match_contestant_AFTER_DELETE` AFTER DELETE ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(OLD.match_id);
END */;;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `match_AFTER_INSERT` AFTER INSERT ON `matches_match` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.id);
END */;;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `match_AFTER_UPDATE` AFTER UPDATE ON `matches_match` FOR EACH ROW
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
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `user_match_rating_AFTER_INSERT` AFTER INSERT ON `matches_match_rating` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END */;;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `user_match_rating_AFTER_UPDATE` AFTER UPDATE ON `matches_match_rating` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END */;;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `user_AFTER_INSERT` AFTER INSERT ON `user` FOR EACH ROW
BEGIN
	CALL `usp_matches_ins_stats`(NEW.id);
END */;;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `user_AFTER_UPDATE` AFTER UPDATE ON `user` FOR EACH ROW
BEGIN
	IF NOT (NEW.username <=> OLD.username) THEN
		INSERT INTO `user_username_history`
			(`id`, `user_id`, `old_username`,  `new_username`, `created`)
        VALUES
			(UUID_TO_BIN(UUID()), NEW.id, OLD.username, NEW.username, NOW());
    END IF;
END */;;

INSERT INTO `user` (`username`, `secret`, `access`, `date_created`) VALUES ('admin', '$2y$10$z21CfhGFmUqFImVjHq.EW.2NuYCN5Gc/IDxOHY2glMhWe4WKioWZO', 3, NOW());
