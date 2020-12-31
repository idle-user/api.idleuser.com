<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class RoyalRumbleEntry implements JsonSerializable
{
    private $royalrumble_id;
    private $entry;
    private $user_id;
    private $display_name;
    private $comment;
    private $created;

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

    public function getRoyalRumbleId(): ?int
    {
        return $this->royalrumble_id;
    }

    public function getEntry(): ?int
    {
        return $this->entry;
    }

    public function getUserId(): ?int
    {
        return $this->user_id;
    }

    public function getDisplayName(): ?string
    {
        return $this->display_name;
    }

    public function getComment(): ?string
    {
        return $this->comment;
    }

    public function setRoyalRumbleId(int $royalRumbleId)
    {
        $this->royalrumble_id = $royalRumbleId;
        return $this;
    }

    public function setUserId(?int $userId)
    {
        $this->user_id = $userId;
        return $this;
    }

    public function setDisplayName(string $displayName)
    {
        $this->display_name = $displayName;
        return $this;
    }

    public function setEntry(int $entry)
    {
        $this->entry = $entry;
        return $this;
    }

    public function setComment(string $comment)
    {
        $this->comment = $comment;
        return $this;
    }

    public function jsonSerialize()
    {
        return [
            'royalrumble_id' => $this->royalrumble_id,
            'entry' => $this->entry,
            'user_id' => $this->user_id,
            'display_name' => $this->display_name,
            'comment' => $this->comment,
            'created' => $this->created,
        ];
    }

    protected function fill(array $row)
    {
        $this->royalrumble_id = $row['royalrumble_id'];
        $this->entry = $row['entry'];
        $this->user_id = $row['user_id'];
        $this->display_name = $row['display_name'];
        $this->comment = $row['comment'];
        $this->created = $row['created'];
    }
}
