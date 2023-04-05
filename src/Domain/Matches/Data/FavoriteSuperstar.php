<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class FavoriteSuperstar implements JsonSerializable
{
    private $user_id;
    private $superstar_id;
    private $updated;

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

    public function getUserId(): ?int
    {
        return $this->user_id;
    }

    public function getSuperstarId(): ?int
    {
        return $this->superstar_id;
    }

    public function setUserId(int $userId)
    {
        $this->user_id = $userId;
        return $this;
    }

    public function setSuperstarId(int $superstarId)
    {
        $this->superstar_id = $superstarId;
        return $this;
    }

    public function jsonSerialize()
    {
        return [
            'user_id' => $this->user_id,
            'superstar_id' => $this->superstar_id,
            'updated' => $this->updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->superstar_id = $row['superstar_id'];
        $this->updated = $row['updated'];
    }
}
