<?php
declare(strict_types=1);

namespace App\Domain\Chat\Data;

use JsonSerializable;

class Command implements JsonSerializable
{
    private $id;
    private $command;
    private $response;
    private $description;
    private $last_updated;

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

    public function getCommand(): string
    {
        return $this->command;
    }

    public function getResponse(): string
    {
        return $this->response;
    }

    public function getDescription(): string
    {
        return $this->description;
    }

    public function setId(int $id)
    {
        $this->id = $id;
        return $this;
    }

    public function setCommand(string $command)
    {
        $this->command = $command;
        return $this;
    }

    public function setResponse(string $response)
    {
        $this->response = $response;
        return $this;
    }

    public function setDescription(string $description)
    {
        $this->description = $description;
        return $this;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'command' => $this->command,
            'response' => $this->response,
            'description' => $this->description,
            'last_updated' => $this->last_updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->command = $row['command'];
        $this->response = $row['response'];
        $this->description = $row['description'];
        $this->last_updated = $row['last_updated'];
    }
}
