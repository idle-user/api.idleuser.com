DELIMITER $$
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
                 ))$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `func_matches_current_season`() RETURNS int(11)
BEGIN
	DECLARE current_season INT;
    SET current_season = 0;
	SELECT season INTO `current_season`
		FROM `matches_season`
		WHERE CURDATE() BETWEEN start_date AND end_date;
RETURN current_season;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `func_matches_match_season`(match_id INT) RETURNS int(11)
BEGIN
	DECLARE out_match_season INT;
    SET out_match_season = 0;
	SELECT season INTO out_match_season
		FROM `matches_season`
		WHERE match_id BETWEEN start_matchid AND IFNULL(end_matchid,match_id);
RETURN out_match_season;
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `UUID_TO_BIN`(_uuid BINARY(36)) RETURNS binary(16)
    DETERMINISTIC
    SQL SECURITY INVOKER
RETURN
        UNHEX(CONCAT(
            SUBSTR(_uuid, 15, 4),
            SUBSTR(_uuid, 10, 4),
            SUBSTR(_uuid,  1, 8),
            SUBSTR(_uuid, 20, 4),
            SUBSTR(_uuid, 25) ))$$
DELIMITER ;
