<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Stats implements JsonSerializable
{
    private $user_id;
    private $season;
    private $wins;
    private $losses;
    private $ratings;
    private $rating_points;
    private $daily_points;
    private $bet_points;
    private $total_points;
    private $available_points;
    private $updated;

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

    public function getSeason(): ?int
    {
        return $this->season;
    }

    public function getAvailablePoints(): ?int
    {
        return $this->available_points;
    }

    public function jsonSerialize()
    {
        return [
            'user_id' => $this->user_id,
            'season' => $this->season,
            'wins' => $this->wins,
            'losses' => $this->losses,
            'ratings' => $this->ratings,
            'rating_points' => $this->rating_points,
            'daily_points' => $this->daily_points,
            'bet_points' => $this->bet_points,
            'total_points' => $this->total_points,
            'available_points' => $this->available_points,
            'updated' => $this->updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->season = $row['season'];
        $this->wins = $row['wins'];
        $this->losses = $row['losses'];
        $this->ratings = $row['ratings'];
        $this->rating_points = $row['rating_points'];
        $this->daily_points = $row['daily_points'];
        $this->bet_points = $row['bet_points'];
        $this->total_points = $row['total_points'];
        $this->available_points = $row['available_points'];
        $this->updated = $row['updated'];
    }
}
