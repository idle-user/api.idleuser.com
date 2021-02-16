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

    public function getUserId(): ?int
    {
        return $this->user_id;
    }

    public function getMatchId(): ?int
    {
        return $this->match_id;
    }

    public function getTeam(): ?int
    {
        return $this->team;
    }

    public function getPoints()
    {
        return $this->points;
    }

    public function setUserId(int $userId)
    {
        $this->user_id = $userId;
        return $this;
    }

    public function setMatchId(int $matchId)
    {
        $this->match_id = $matchId;
        return $this;
    }

    public function setTeam(int $team)
    {
        $this->team = $team;
        return $this;
    }

    public function setPoints($points)
    {
        $this->points = $points;
        return $this;
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
