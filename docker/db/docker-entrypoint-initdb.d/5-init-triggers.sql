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
