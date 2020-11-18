<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Match implements JsonSerializable
{
    private $id;
    private $event_id;
    private $title_id;
    private $match_type_id;
    private $match_note;
    private $team_won;
    private $winner_note;
    private $bet_open;
    private $last_updated_by;
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

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEventId(): ?int
    {
        return $this->event_id;
    }

    public function getTitleId(): ?int
    {
        return $this->title_id;
    }

    public function getMatchTypeId(): ?int
    {
        return $this->match_type_id;
    }

    public function getTeamWon(): ?int
    {
        return $this->team_won;
    }

    public function getBetOpen(): ?int
    {
        return $this->bet_open;
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
            'last_updated_by' => $this->last_updated_by,
            'last_updated' => $this->last_updated,
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
        $this->last_updated_by = $row['last_updated_by'];
        $this->last_updated = $row['last_updated'];
    }
}
