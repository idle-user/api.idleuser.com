<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Event implements JsonSerializable
{
    private $id;
    private $name;
    private $date_time;
    private $ppv;

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

    public function getName(): ?string
    {
        return $this->name;
    }

    public function getDateTime(): ?string
    {
        return $this->date_time;
    }

    public function getPPV(): ?int
    {
        return $this->ppv;
    }

    public function hasPassed()
    {
        $eventTimeStamp = strtotime($this->date_time);
        return $eventTimeStamp < strtotime('now');
    }

    public function isToday()
    {
        $eventTimeStamp = strtotime($this->date_time);
        return strtotime('today') < $eventTimeStamp && $eventTimeStamp < strtotime('tomorrow');
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'date_time' => $this->date_time,
            'ppv' => $this->ppv,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->name = $row['name'];
        $this->date_time = $row['date_time'];
        $this->ppv = $row['ppv'];
    }
}
