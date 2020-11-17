<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Contestant implements JsonSerializable
{
    private $match_id;
    private $superstar_id;
    private $team;
    private $bet_multiplier;

    public function __construct()
    {
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

    public function getSuperstarId(): ?int
    {
        return $this->superstar_id;
    }

    public function getTeam(): ?int
    {
        return $this->team;
    }

    public function getBetMultiplier(): ?int
    {
        return $this->bet_multiplier;
    }

    public function jsonSerialize()
    {
        return [
            'match_id' => $this->match_id,
            'superstar_id' => $this->superstar_id,
            'team' => $this->team,
            'bet_multiplier' => $this->bet_multiplier,
        ];
    }

    protected function fill(array $row)
    {
        $this->match_id = $row['match_id'];
        $this->superstar_id = $row['superstar_id'];
        $this->team = $row['team'];
        $this->bet_multiplier = $row['bet_multiplier'];
    }
}
