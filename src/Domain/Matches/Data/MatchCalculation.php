<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class MatchCalculation implements JsonSerializable
{
    private $match_id;
    private $completed;
    private $pot_valid;
    private $contestants;
    private $contestants_won;
    private $contestants_lost;
    private $bet_multiplier;
    private $base_pot;
    private $base_winner_pot;
    private $base_loser_pot;
    private $user_bet_cnt;
    private $user_bet_winner_cnt;
    private $user_bet_loser_cnt;
    private $user_rating_avg;
    private $user_rating_cnt;
    private $last_updated;

    public function __construct()
    {
    }

    public static function create()
    {
        $instance = new self();
        return $instance;
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getMatchId(): ?int
    {
        return $this->match_id;
    }

    public function jsonSerialize()
    {
        return [
            'match_id' => $this->match_id,
            'completed' => $this->completed,
            'pot_valid' => $this->pot_valid,
            'contestants' => $this->contestants,
            'contestants_won' => $this->contestants_won,
            'contestants_lost' => $this->contestants_lost,
            'bet_multiplier' => $this->bet_multiplier,
            'base_pot' => $this->base_pot,
            'base_winner_pot' => $this->base_winner_pot,
            'base_loser_pot' => $this->base_loser_pot,
            'user_bet_cnt' => $this->user_bet_cnt,
            'user_bet_winner_cnt' => $this->user_bet_winner_cnt,
            'user_bet_loser_cnt' => $this->user_bet_loser_cnt,
            'user_rating_avg' => $this->user_rating_avg,
            'user_rating_cnt' => $this->user_rating_cnt,
            'last_updated' => $this->last_updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->match_id = $row['match_id'];
        $this->completed = $row['completed'];
        $this->pot_valid = $row['pot_valid'];
        $this->contestants = $row['contestants'];
        $this->contestants_won = $row['contestants_won'];
        $this->contestants_lost = $row['contestants_lost'];
        $this->bet_multiplier = $row['bet_multiplier'];
        $this->base_pot = $row['base_pot'];
        $this->base_winner_pot = $row['base_winner_pot'];
        $this->base_loser_pot = $row['base_loser_pot'];
        $this->user_bet_cnt = $row['user_bet_cnt'];
        $this->user_bet_winner_cnt = $row['user_bet_winner_cnt'];
        $this->user_bet_loser_cnt = $row['user_bet_loser_cnt'];
        $this->user_rating_avg = $row['user_rating_avg'];
        $this->user_rating_cnt = $row['user_rating_cnt'];
        $this->last_updated = $row['last_updated'];
    }
}
