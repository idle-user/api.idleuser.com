DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_matches_ins_stats`(
	IN in_uid INT UNSIGNED
)
BEGIN
	INSERT INTO `matches_stats` (user_id, season) values (in_uid, `func_matches_current_season`());
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
        `matches_match_calculation`.base_pot+(`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier) AS total_pot,
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
        `matches_match_calculation`.base_pot+(`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier) AS total_pot,
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
END$$
DELIMITER ;

DELIMITER $$
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
        `matches_match_calculation`.base_pot+(`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier) AS total_pot,
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
END$$
DELIMITER ;

DELIMITER $$
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
        `matches_match_calculation`.base_pot+(`matches_match_calculation`.base_pot*`matches_match_calculation`.bet_multiplier) AS total_pot,
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_matches_sel_superstar_by_id`(IN in_superstar_id INT)
BEGIN
	SELECT
		`matches_superstar`.*,
        YEAR(CURRENT_TIMESTAMP) - YEAR(dob) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(dob, 5)) AS age
	FROM
		`matches_superstar`
	WHERE
		`matches_superstar`.id=in_superstar_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_matches_sel_superstar_by_name`(IN in_superstar_name VARCHAR(255))
BEGIN
	SELECT
		`matches_superstar`.*,
        YEAR(CURRENT_TIMESTAMP) - YEAR(dob) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(dob, 5)) AS age
	FROM
		`matches_superstar`
	WHERE
		`matches_superstar`.name LIKE CONCAT('%',in_superstar_name,'%');
END$$
DELIMITER ;

DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
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
			,SUM(tub.points)+(SUM(IF(tub.team=ub.team,tub.points,0))*bm.bet_multiplier) AS t_potential_pot
			,ub.points/SUM(IF(tub.team=ub.team,tub.points,0)) AS t_potential_cut_pct
			,(SUM(tub.points)+(SUM(IF(tub.team=ub.team,tub.points,0))*bm.bet_multiplier)) * (ub.points/SUM(IF(tub.team=ub.team,tub.points,0))) AS t_potential_cut_points
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_matches_upd_match_calculation`(IN in_match_id INT)
BEGIN

	DECLARE t_completed INT;
	DECLARE t_pot_valid TINYINT;
	DECLARE t_contestants TEXT;
	DECLARE t_contestants_won TEXT;
	DECLARE t_contestants_lost TEXT;
    DECLARE t_bet_multiplier DECIMAL(10,2);
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
		,IFNULL(wc.bet_multiplier, 0) AS `bet_multiplier`
		,IFNULL(ub.base_pot, 0) AS base_pot
		,IFNULL(ub.base_winner_pot, 0) AS base_winner_pot
		,IFNULL(ub.base_loser_pot, 0) AS base_loser_pot
		,IFNULL(ub.user_bet_cnt, 0) AS user_bet_cnt
		,IFNULL(ub.user_bet_winner_cnt, 0) AS user_bet_winner_cnt
		,IFNULL(ub.user_bet_loser_cnt, 0) AS user_bet_loser_cnt
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_matches_upd_stats_all`(
	IN in_season INT)
BEGIN
	CASE
		WHEN in_season=7 THEN
			INSERT INTO `matches_stats` (user_id, season, wins, losses, ratings, rating_points, daily_points, bet_points, total_points, available_points, updated)
				SELECT *, NOW() FROM `uv_matches_stats_calc_s7` vusc
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_poll_upd_item_votes`()
BEGIN
	UPDATE `poll_item` pi
    SET pi.votes = (SELECT COUNT(*) FROM `poll_vote` pv WHERE pv.item_id=pi.id);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_traffic_ins`(
      IN in_domain TEXT,
    IN in_request TEXT,
	  IN in_user_agent TEXT,
    IN in_ip TEXT,
    IN in_user_id INT,
    IN in_note TEXT
)
BEGIN

    DECLARE t_now DATETIME;
    DECLARE t_id CHAR(36);
    DECLARE t_domain_id BINARY(16);
	  DECLARE t_request_id BINARY(16);
    DECLARE t_user_agent_id BINARY(16);
	  DECLARE t_ip_id BINARY(16);

    SELECT NOW() INTO t_now;


	INSERT INTO `traffic_domain`
		(id, domain, md5hash, created, last_accessed, access_cnt)
	VALUES
        (UUID_TO_BIN(UUID()), in_domain, UNHEX(MD5(in_domain)), t_now, t_now, 1)
    ON DUPLICATE KEY UPDATE
		  last_accessed=t_now,
      access_cnt=access_cnt+1;
	SELECT id INTO t_domain_id FROM `traffic_domain` WHERE md5hash=UNHEX(MD5(in_domain));


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
		(id, domain_id, request_id, user_agent_id, ip_id, user_id, note, created)
	VALUES
		(UUID_TO_BIN(t_id), t_domain_id, t_request_id, t_user_agent_id, t_ip_id, in_user_id, in_note, t_now);


    SELECT t_id AS `uuid`, `traffic`.* FROM `traffic` WHERE id=UUID_TO_BIN(t_id);


END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_user_ins_from_chatango`(
	IN in_username VARCHAR(45))
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);
    DECLARE social_type_chatango_id BINARY(16);

    SET res_success=0;
    SET res_message='Unhandled Exception';
	SET social_type_chatango_id = (SELECT id FROM social_type WHERE name='Chatango');


    IF EXISTS (SELECT username FROM `user` WHERE username=in_username)
		THEN
			SET res_message='Username already exists';
	ELSEIF EXISTS (SELECT social_id FROM `user_social` WHERE social_id=in_username AND social_type_id=social_type_chatango_id)
		THEN
			SET res_message='Chatango ID already exists';
    ELSE
		INSERT INTO `user`
			(username, date_created)
		VALUES
			(in_username, NOW());
		INSERT INTO `user_social`
			(user_id, social_type_id, social_id, last_updated)
        VALUES
			((SELECT id FROM user WHERE username=in_username), social_type_chatango_id, in_username, NOW());
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `usp_user_ins_from_discord`(
	IN in_username VARCHAR(45),
    IN in_discord_id VARCHAR(45))
BEGIN
	DECLARE res_success INT;
    DECLARE res_message VARCHAR(255);
    DECLARE social_type_discord_id BINARY(16);

    SET res_success=0;
    SET res_message='Unhandled Exception';
    SET social_type_discord_id = (SELECT id FROM social_type WHERE name='Discord');

    IF EXISTS (SELECT username FROM `user` WHERE username=in_username)
		THEN
			SET res_message='Username already exists';
	ELSEIF EXISTS (SELECT social_id FROM `user_social` WHERE social_id=in_username AND social_type_id=social_type_discord_id)
		THEN
			SET res_message='Discord ID already exists';
    ELSE
		INSERT INTO `user`
			(username, date_created)
		VALUES
			(in_username, NOW());
		INSERT INTO `user_social`
			(user_id, social_type_id, social_id, last_updated)
        VALUES
			((SELECT id FROM user WHERE username=in_username), social_type_discord_id, in_username, NOW());
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
END$$
DELIMITER ;
