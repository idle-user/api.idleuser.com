<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Title implements JsonSerializable
{
    private $id;
    private $name;
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

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'last_updated' => $this->last_updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->name = $row['name'];
        $this->last_updated = $row['last_updated'];
    }
}
