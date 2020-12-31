<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class RoyalRumble implements JsonSerializable
{
    private $id;
    private $description;
    private $event_id;
    private $entry_max;
    private $entry_won;

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

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function getEventId(): ?int
    {
        return $this->event_id;
    }

    public function getEntryMax(): ?int
    {
        return $this->entry_max;
    }

    public function getEntryWon(): ?int
    {
        return $this->entry_won;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'description' => $this->description,
            'event_id' => $this->event_id,
            'entry_max' => $this->entry_max,
            'entry_won' => $this->entry_won,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->description = $row['description'];
        $this->event_id = $row['event_id'];
        $this->entry_max = $row['entry_max'];
        $this->entry_won = $row['entry_won'];
    }
}
