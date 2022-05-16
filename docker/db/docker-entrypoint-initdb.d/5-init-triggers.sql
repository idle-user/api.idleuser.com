DELIMITER $$
CREATE TRIGGER `user_bet_AFTER_INSERT` AFTER INSERT ON `matches_bet` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
	CALL `usp_matches_upd_bet_calculation`(NEW.match_id);
	
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
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_bet_AFTER_UPDATE` AFTER UPDATE ON `matches_bet` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
	CALL `usp_matches_upd_bet_calculation`(NEW.match_id);

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
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `match_contestant_AFTER_INSERT` AFTER INSERT ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `match_contestant_AFTER_UPDATE` AFTER UPDATE ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `match_contestant_AFTER_DELETE` AFTER DELETE ON `matches_contestant` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(OLD.match_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `match_AFTER_INSERT` AFTER INSERT ON `matches_match` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `match_AFTER_UPDATE` AFTER UPDATE ON `matches_match` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.id);
    CALL `usp_matches_upd_bet_calculation`(NEW.id);

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
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_match_rating_AFTER_INSERT` AFTER INSERT ON `matches_match_rating` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_match_rating_AFTER_UPDATE` AFTER UPDATE ON `matches_match_rating` FOR EACH ROW
BEGIN
	CALL `usp_matches_upd_match_calculation`(NEW.match_id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `poll_vote_AFTER_INSERT` AFTER INSERT ON `poll_vote` FOR EACH ROW
BEGIN
    UPDATE `poll_item`
    SET `poll_item`.`votes`=`poll_item`.`votes`+1
    WHERE `poll_item`.`id`=NEW.item_id;

    UPDATE `poll_topic`
    SET `poll_topic`.`votes`=`poll_topic`.`votes`+1
    WHERE `poll_topic`.`id`=NEW.topic_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_AFTER_INSERT` AFTER INSERT ON `user` FOR EACH ROW
BEGIN
	CALL `usp_matches_ins_stats`(NEW.id);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_AFTER_UPDATE` AFTER UPDATE ON `user` FOR EACH ROW
BEGIN
	IF NOT (NEW.username <=> OLD.username) THEN
		INSERT INTO `user_username_history`
			(`id`, `user_id`, `old_username`,  `new_username`, `created`)
        VALUES
			(UUID_TO_BIN(UUID()), NEW.id, OLD.username, NEW.username, NOW());
    END IF;
END$$
DELIMITER ;
