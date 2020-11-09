<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Season implements JsonSerializable
{
    private $season;
    private $start_date;
    private $end_date;
    private $start_matchid;
    private $end_matchid;

    public function __construct()
    {
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getId(): ?int
    {
        return $this->season;
    }

    public function jsonSerialize()
    {
        return [
            'season' => $this->season,
            'start_date' => $this->start_date,
            'end_date' => $this->end_date,
            'start_matchid' => $this->start_matchid,
            'end_matchid' => $this->end_matchid,
        ];
    }

    protected function fill(array $row)
    {
        $this->season = $row['season'];
        $this->start_date = $row['start_date'];
        $this->end_date = $row['end_date'];
        $this->start_matchid = $row['start_matchid'];
        $this->end_matchid = $row['end_matchid'];
    }
}
