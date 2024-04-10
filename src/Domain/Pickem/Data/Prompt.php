<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Data;

use DateTime;
use JsonSerializable;

class Prompt implements JsonSerializable
{
    private $id;
    private $subject;
    private $open;
    private $choice_result;
    private $picks;
    private $user_id;
    private $group_id;
    private $expires_at;
    private $created_at;
    private $updated_at;


    public function __construct()
    {
    }

    public static function create(): Prompt
    {
        return new self();
    }

    public static function withRow(array $row): Prompt
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getSubject(): string
    {
        return $this->subject;
    }

    public function getOpen(): int
    {
        return $this->open;
    }

    public function getChoiceResult(): ?int
    {
        return $this->choice_result;
    }

    public function getPicks(): int
    {
        return $this->picks;
    }

    public function getUserId(): int
    {
        return $this->user_id;
    }

    public function getGroupId(): ?string
    {
        return $this->group_id;
    }

    public function getExpiresAt(): string
    {
        return $this->expires_at;
    }

    public function getCreatedAt(): string
    {
        return $this->created_at;
    }

    public function getUpdatedAt(): string
    {
        return $this->updated_at;
    }

    public function setSubject(string $subject): Prompt
    {
        $this->subject = $subject;
        return $this;
    }

    public function setOpen(int $open): Prompt
    {
        $this->open = $open;
        return $this;
    }

    public function setChoiceResult(int $choiceResult): Prompt
    {
        $this->choice_result = $choiceResult;
        return $this;
    }

    public function setPicks(int $picks): Prompt
    {
        $this->picks = $picks;
        return $this;
    }

    public function setUserId(int $userId): Prompt
    {
        $this->user_id = $userId;
        return $this;
    }

    public function setGroupId(?string $groupId): Prompt
    {
        $this->group_id = $groupId;
        return $this;
    }

    public function setUpdatedAt(string $updatedAt): Prompt
    {
        $this->updated_at = $updatedAt;
        return $this;
    }

    public function isOpen(): bool
    {
        return $this->open > 0;
    }

    public function isExpired(): bool
    {
        $expiresAtDatetime = new DateTime($this->expires_at);
        $currentDatetime = new DateTime();
        return $currentDatetime >= $expiresAtDatetime;
    }

    public function incrementPicks(): Prompt
    {
        $this->picks++;
        return $this;
    }

    public function jsonSerialize(): array
    {
        return [
            'id' => $this->id,
            'subject' => $this->subject,
            'open' => $this->open,
            'choice_result' => $this->choice_result,
            'picks' => $this->picks,
            'user_id' => $this->user_id,
            'group_id' => $this->group_id,
            'expires_at' => $this->expires_at,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    protected function fill(array $row): void
    {
        $this->id = $row['id'];
        $this->subject = $row['subject'];
        $this->open = $row['open'];
        $this->choice_result = $row['choice_result'];
        $this->picks = $row['picks'];
        $this->user_id = $row['user_id'];
        $this->group_id = $row['group_id'];
        $this->expires_at = $row['expires_at'];
        $this->created_at = $row['created_at'];
        $this->updated_at = $row['updated_at'];
    }
}
