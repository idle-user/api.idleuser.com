<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class BetCalculation implements JsonSerializable
{
    private $user_id;
    private $match_id;
    private $points;
    private $team_base_pot;
    private $potential_cut_pct;
    private $potential_cut_points;
    private $bet_won;
    private $last_updated;

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
            'points' => $this->points,
            'team_base_pot' => $this->team_base_pot,
            'potential_cut_pct' => $this->potential_cut_pct,
            'potential_cut_points' => $this->potential_cut_points,
            'bet_won' => $this->bet_won,
            'last_updated' => $this->last_updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->match_id = $row['match_id'];
        $this->points = $row['points'];
        $this->team_base_pot = $row['team_base_pot'];
        $this->potential_cut_pct = $row['potential_cut_pct'];
        $this->potential_cut_points = $row['potential_cut_points'];
        $this->bet_won = $row['bet_won'];
        $this->last_updated = $row['last_updated'];
    }
}
