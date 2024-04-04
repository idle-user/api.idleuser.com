<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Data;

use JsonSerializable;

class Choice implements JsonSerializable
{
    private $id;
    private $prompt_id;
    private $subject;
    private $picks;
    private $created_at;
    private $updated_at;

    public function __construct()
    {
    }

    public static function create(): Choice
    {
        return new self();
    }

    public static function withRow(array $row): Choice
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPromptId(): ?int
    {
        return $this->prompt_id;
    }

    public function getPicks(): int
    {
        return $this->picks;
    }

    public function getUpdatedAt(): string
    {
        return $this->updated_at;
    }

    public function getSubject(): ?string
    {
        return $this->subject;
    }

    public function setPromptId(int $promptId): Choice
    {
        $this->prompt_id = $promptId;
        return $this;
    }

    public function setSubject(string $subject): Choice
    {
        $this->subject = $subject;
        return $this;
    }

    public function setPicks(int $picks): Choice
    {
        $this->picks = $picks;
        return $this;
    }

    public function setUpdatedAt(string $updatedAt): Choice
    {
        $this->updated_at = $updatedAt;
        return $this;
    }

    public function incrementPicks(): Choice
    {
        $this->picks++;
        return $this;
    }

    public function decrementPicks(): Choice
    {
        $this->picks--;
        return $this;
    }

    public function jsonSerialize(): array
    {
        return [
            'id' => $this->id,
            'prompt_id' => $this->prompt_id,
            'subject' => $this->subject,
            'picks' => $this->picks,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    protected function fill(array $row): void
    {
        $this->id = $row['id'];
        $this->prompt_id = $row['prompt_id'];
        $this->subject = $row['subject'];
        $this->picks = $row['picks'];
        $this->created_at = $row['created_at'];
        $this->updated_at = $row['updated_at'];
    }
}
