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

CREATE TABLE `chatroom` (
  `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `chatroom_command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` varchar(45) NOT NULL,
  `response` text NOT NULL,
  `description` varchar(120) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prefix_UNIQUE` (`command`)
) ENGINE=InnoDB AUTO_INCREMENT=625 DEFAULT CHARSET=utf8mb3;

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

CREATE TABLE `command_image` (
  `command` varchar(45) NOT NULL,
  `local_url` varchar(250) NOT NULL,
  `imgur_url` varchar(250) DEFAULT NULL,
  `meta` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`command`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `guild_info` (
  `id` varchar(45) NOT NULL,
  `name` varchar(200) NOT NULL,
  `owner_id` varchar(45) NOT NULL,
  `prefix` varchar(3) NOT NULL DEFAULT '!',
  `created_on` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

CREATE TABLE `matches_bet` (
  `user_id` int(11) unsigned NOT NULL,
  `match_id` int(10) unsigned NOT NULL,
  `team` int(10) unsigned NOT NULL,
  `points` bigint(20) unsigned NOT NULL,
  `dt_placed` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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

CREATE TABLE `matches_brand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_contestant` (
  `match_id` int(10) unsigned NOT NULL DEFAULT 0,
  `superstar_id` int(10) unsigned NOT NULL DEFAULT 1,
  `team` int(10) unsigned NOT NULL DEFAULT 0,
  `bet_multiplier` decimal(10,2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`match_id`,`superstar_id`,`team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ppv` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=435 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_favorite_superstar` (
  `user_id` int(11) NOT NULL,
  `superstar_id` int(11) NOT NULL DEFAULT 1,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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
) ENGINE=InnoDB AUTO_INCREMENT=1276 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_match_calculation` (
  `match_id` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `pot_valid` tinyint(1) NOT NULL,
  `contestants` text NOT NULL,
  `contestants_won` text NOT NULL,
  `contestants_lost` text NOT NULL,
  `bet_multiplier` decimal(10,2) unsigned NOT NULL,
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

CREATE TABLE `matches_match_rating` (
  `user_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `rating` double unsigned NOT NULL,
  `updates` int(10) unsigned NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_match_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_royalrumble` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `event_id` int(11) unsigned NOT NULL,
  `entry_max` tinyint(2) NOT NULL DEFAULT 30,
  `entry_won` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matches_royalrumble_entry` (
  `royalrumble_id` int(11) NOT NULL,
  `display_name` varchar(25) NOT NULL,
  `entry` tinyint(2) NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  PRIMARY KEY (`royalrumble_id`,`display_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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

CREATE TABLE `matches_stable_member` (
  `stable_id` int(11) NOT NULL,
  `superstar_id` int(11) NOT NULL,
  PRIMARY KEY (`stable_id`,`superstar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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

CREATE TABLE `matches_title` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `poll_item` (
  `id` binary(16) NOT NULL,
  `topic_id` binary(16) NOT NULL,
  `content` varchar(50) NOT NULL,
  `votes` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

CREATE TABLE `poll_vote` (
  `id` binary(16) NOT NULL,
  `topic_id` binary(16) NOT NULL,
  `item_id` binary(16) NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `created_dt` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Update vote count on poll_item and poll_topic';

CREATE TABLE `quote` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `quote` varchar(200) DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `social_type` (
  `id` binary(16) NOT NULL,
  `name` varchar(45) NOT NULL,
  `url` varchar(200) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `traffic` (
  `id` binary(16) NOT NULL,
  `domain_id` binary(16) NOT NULL,
  `request_id` binary(16) NOT NULL,
  `user_agent_id` binary(16) NOT NULL,
  `ip_id` binary(16) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `response_code` int(10) unsigned DEFAULT NULL,
  `response_updated` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `traffic_domain` (
  `id` binary(16) NOT NULL,
  `domain` text NOT NULL,
  `md5hash` binary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  `access_cnt` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5hash_UNIQUE` (`md5hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `traffic_ip` (
  `id` binary(16) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  `access_cnt` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_UNIQUE` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `login_token_UNIQUE` (`login_token`),
  UNIQUE KEY `temp_secret_UNIQUE` (`temp_secret`)
) ENGINE=InnoDB AUTO_INCREMENT=411 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `user_social` (
  `user_id` int(11) NOT NULL,
  `social_type_id` binary(16) NOT NULL,
  `social_id` varchar(45) NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`social_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_username_history` (
  `id` binary(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `old_username` varchar(25) NOT NULL,
  `new_username` varchar(25) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

CREATE TABLE `email_ignore` (
  `id` int(11) unsigned NOT NULL,
  `contains` varchar(45) NOT NULL,
  `hits` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `contains_UNIQUE` (`contains`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;