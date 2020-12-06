<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class MatchDetail implements JsonSerializable
{
    private $id;
    private $event_id;
    private $title_id;
    private $match_type_id;
    private $match_note;
    private $team_won;
    private $winner_note;
    private $bet_open;
    private $info_last_updated_by_id;
    private $info_last_updated;
    private $completed;
    private $pot_valid;
    private $contestants;
    private $contestants_won;
    private $contestants_lost;
    private $bet_multiplier;
    private $base_pot;
    private $total_pot;
    private $base_winner_pot;
    private $base_loser_pot;
    private $user_bet_cnt;
    private $user_bet_winner_cnt;
    private $user_bet_loser_cnt;
    private $user_rating_avg;
    private $user_rating_cnt;
    private $calc_last_updated;
    private $event;
    private $date;
    private $title;
    private $match_type;
    private $last_updated_by_username;

    public function __construct()
    {
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'event_id' => $this->event_id,
            'title_id' => $this->title_id,
            'match_type_id' => $this->match_type_id,
            'match_note' => $this->match_note,
            'team_won' => $this->team_won,
            'winner_note' => $this->winner_note,
            'bet_open' => $this->bet_open,
            'info_last_updated_by_id' => $this->info_last_updated_by_id,
            'info_last_updated' => $this->info_last_updated,
            'completed' => $this->completed,
            'pot_valid' => $this->pot_valid,
            'contestants' => $this->contestants,
            'contestants_won' => $this->contestants_won,
            'contestants_lost' => $this->contestants_lost,
            'bet_multiplier' => $this->bet_multiplier,
            'base_pot' => $this->base_pot,
            'total_pot' => $this->total_pot,
            'base_winner_pot' => $this->base_winner_pot,
            'base_loser_pot' => $this->base_loser_pot,
            'user_bet_cnt' => $this->user_bet_cnt,
            'user_bet_winner_cnt' => $this->user_bet_winner_cnt,
            'user_bet_loser_cnt' => $this->user_bet_loser_cnt,
            'user_rating_avg' => $this->user_rating_avg,
            'user_rating_cnt' => $this->user_rating_cnt,
            'calc_last_updated' => $this->calc_last_updated,
            'event' => $this->event,
            'date' => $this->date,
            'title' => $this->title,
            'match_type' => $this->match_type,
            'last_updated_by_username' => $this->last_updated_by_username,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->event_id = $row['event_id'];
        $this->title_id = $row['title_id'];
        $this->match_type_id = $row['match_type_id'];
        $this->match_note = $row['match_note'];
        $this->team_won = $row['team_won'];
        $this->winner_note = $row['winner_note'];
        $this->bet_open = $row['bet_open'];
        $this->info_last_updated_by_id = $row['info_last_updated_by_id'];
        $this->info_last_updated = $row['info_last_updated'];
        $this->completed = $row['completed'];
        $this->pot_valid = $row['pot_valid'];
        $this->contestants = $row['contestants'];
        $this->contestants_won = $row['contestants_won'];
        $this->contestants_lost = $row['contestants_lost'];
        $this->bet_multiplier = $row['bet_multiplier'];
        $this->base_pot = $row['base_pot'];
        $this->total_pot = $row['total_pot'];
        $this->base_winner_pot = $row['base_winner_pot'];
        $this->base_loser_pot = $row['base_loser_pot'];
        $this->user_bet_cnt = $row['user_bet_cnt'];
        $this->user_bet_winner_cnt = $row['user_bet_winner_cnt'];
        $this->user_bet_loser_cnt = $row['user_bet_loser_cnt'];
        $this->user_rating_avg = $row['user_rating_avg'];
        $this->user_rating_cnt = $row['user_rating_cnt'];
        $this->calc_last_updated = $row['calc_last_updated'];
        $this->event = $row['event'];
        $this->date = $row['date'];
        $this->title = $row['title'];
        $this->match_type = $row['match_type'];
        $this->last_updated_by_username = $row['last_updated_by_username'];
    }
}
