<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class MatchType implements JsonSerializable
{
    private ?int $id;
    private string $name;

    public function __construct()
    {
    }

    public static function withRow(array $row): MatchType
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function jsonSerialize(): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
        ];
    }

    protected function fill(array $row): void
    {
        $this->id = $row['id'];
        $this->name = $row['name'];
    }
}
