<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class BetDetail implements JsonSerializable
{
    private $user_id;
    private $match_id;
    private $bet_amount;
    private $bet_placed;
    private $bet_team;
    private $bet_won;
    private $team_base_pot;
    private $potential_pot;
    private $potential_cut_pct;
    private $potential_cut_points;
    private $completed;
    private $pot_valid;
    private $bet_multiplier;
    private $total_pot;
    private $contestants;
    private $contestants_won;
    private $contestants_lost;
    private $bet_on;
    private $event_name;
    private $event_dt;

    public function __construct()
    {
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getUserId(): ?int
    {
        return $this->user_id;
    }

    public function getMatchId(): ?int
    {
        return $this->match_id;
    }

    public function jsonSerialize()
    {
        return [
            'user_id' => $this->user_id,
            'match_id' => $this->match_id,
            'bet_amount' => $this->bet_amount,
            'bet_placed' => $this->bet_placed,
            'bet_team' => $this->bet_team,
            'bet_won' => $this->bet_won,
            'team_base_pot' => $this->team_base_pot,
            'potential_pot' => $this->potential_pot,
            'potential_cut_pct' => $this->potential_cut_pct,
            'potential_cut_points' => $this->potential_cut_points,
            'completed' => $this->completed,
            'pot_valid' => $this->pot_valid,
            'bet_multiplier' => $this->bet_multiplier,
            'total_pot' => $this->total_pot,
            'contestants' => $this->contestants,
            'contestants_won' => $this->contestants_won,
            'contestants_lost' => $this->contestants_lost,
            'bet_on' => $this->bet_on,
            'event_name' => $this->event_name,
            'event_dt' => $this->event_dt,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->match_id = $row['match_id'];
        $this->bet_amount = $row['bet_amount'];
        $this->bet_placed = $row['bet_placed'];
        $this->bet_team = $row['bet_team'];
        $this->bet_won = $row['bet_won'];
        $this->team_base_pot = $row['team_base_pot'];
        $this->potential_pot = $row['potential_pot'];
        $this->potential_cut_pct = $row['potential_cut_pct'];
        $this->potential_cut_points = $row['potential_cut_points'];
        $this->completed = $row['completed'];
        $this->pot_valid = $row['pot_valid'];
        $this->bet_multiplier = $row['bet_multiplier'];
        $this->contestants = $row['contestants'];
        $this->contestants_won = $row['contestants_won'];
        $this->contestants_lost = $row['contestants_lost'];
        $this->bet_on = $row['bet_on'];
        $this->event_name = $row['event_name'];
        $this->event_dt = $row['event_dt'];
    }
}
