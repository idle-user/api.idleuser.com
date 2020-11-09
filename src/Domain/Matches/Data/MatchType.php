<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class MatchType implements JsonSerializable
{
    private $id;
    private $name;

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
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->name = $row['name'];
    }
}
