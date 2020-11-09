<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Bet implements JsonSerializable
{
    private $user_id;
    private $match_id;
    private $team;
    private $points;
    private $dt_placed;

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
            'team' => $this->team,
            'points' => $this->points,
            'dt_placed' => $this->dt_placed,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->match_id = $row['match_id'];
        $this->team = $row['team'];
        $this->points = $row['points'];
        $this->dt_placed = $row['dt_placed'];
    }
}
