<?php
declare(strict_types=1);

namespace App\Domain\Chat\Data;

use JsonSerializable;

class Scheduler implements JsonSerializable
{
    private $id;
    private $name;
    private $description;
    private $message;
    private $tweet;
    private $start_time;
    private $sunday_flag;
    private $monday_flag;
    private $tuesday_flag;
    private $wednesday_flag;
    private $thursday_flag;
    private $friday_flag;
    private $saturday_flag;
    private $active;

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

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->name = $row['name'];
        $this->description = $row['description'];
        $this->message = $row['message'];
        $this->tweet = $row['tweet'];
        $this->start_time = $row['start_time'];
        $this->sunday_flag = $row['sunday_flag'];
        $this->monday_flag = $row['monday_flag'];
        $this->tuesday_flag = $row['tuesday_flag'];
        $this->wednesday_flag = $row['wednesday_flag'];
        $this->thursday_flag = $row['thursday_flag'];
        $this->friday_flag = $row['friday_flag'];
        $this->saturday_flag = $row['saturday_flag'];
        $this->active = $row['active'];
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'description' => $this->description,
            'message' => $this->message,
            'tweet' => $this->tweet,
            'start_time' => $this->start_time,
            'sunday_flag' => $this->sunday_flag,
            'monday_flag' => $this->monday_flag,
            'tuesday_flag' => $this->tuesday_flag,
            'wednesday_flag' => $this->wednesday_flag,
            'thursday_flag' => $this->thursday_flag,
            'friday_flag' => $this->friday_flag,
            'saturday_flag' => $this->saturday_flag,
            'active' => $this->active,
        ];
    }
}
