<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class MatchRating implements JsonSerializable
{
    private $user_id;
    private $match_id;
    private $rating;
    private $updates;
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

    public function getMatchId(): ?int
    {
        return $this->match_id;
    }

    public function jsonSerialize()
    {
        return [
            'user_id' => $this->user_id,
            'match_id' => $this->match_id,
            'rating' => $this->rating,
            'updates' => $this->updates,
            'updated' => $this->updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->match_id = $row['match_id'];
        $this->rating = $row['rating'];
        $this->updates = $row['updates'];
        $this->updated = $row['updated'];
    }
}
