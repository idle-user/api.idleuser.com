<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Data;

use JsonSerializable;

class Pick implements JsonSerializable
{
    private $prompt_id;
    private $choice_id;
    private $user_id;
    private $created_at;
    private $updated_at;

    public function __construct()
    {
    }

    public static function create(): Pick
    {
        return new self();
    }

    public static function withRow(array $row): Pick
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getPromptId(): int
    {
        return $this->prompt_id;
    }

    public function getChoiceId(): int
    {
        return $this->choice_id;
    }

    public function getUpdatedAt(): string
    {
        return $this->updated_at;
    }

    public function getUserId(): ?int
    {
        return $this->user_id;
    }

    public function setPromptId(int $promptId): Pick
    {
        $this->prompt_id = $promptId;
        return $this;
    }

    public function setChoiceId(int $choiceId): Pick
    {
        $this->choice_id = $choiceId;
        return $this;
    }

    public function setUserId(int $userId): Pick
    {
        $this->user_id = $userId;
        return $this;
    }

    public function setUpdatedAt(string $updatedAt): Pick
    {
        $this->updated_at = $updatedAt;
        return $this;
    }

    public function jsonSerialize(): array
    {
        return [
            'prompt_id' => $this->prompt_id,
            'choice_id' => $this->choice_id,
            'user_id' => $this->user_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    protected function fill(array $row): void
    {
        $this->prompt_id = $row['prompt_id'];
        $this->choice_id = $row['choice_id'];
        $this->user_id = $row['user_id'];
        $this->created_at = $row['created_at'];
        $this->updated_at = $row['updated_at'];
    }
}
