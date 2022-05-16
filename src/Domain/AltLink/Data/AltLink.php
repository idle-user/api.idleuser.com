<?php
declare(strict_types=1);

namespace App\Domain\AltLink\Data;

use JsonSerializable;

class AltLink implements JsonSerializable
{
    private $id;
    private $alias;
    private $target;
    private $access_limit;
    private $access_cnt;
    private $user_id;
    private $created;
    private $last_accessed;

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

    public function getId(): string
    {
        return $this->id;
    }

    public function getAlias(): string
    {
        return $this->alias;
    }

    public function getTarget(): string
    {
        return $this->target;
    }

    public function getAccessLimit(): int
    {
        return $this->access_limit;
    }

    public function getAccessCount(): int
    {
        return $this->access_cnt;
    }

    public function getUserId(): int
    {
        return $this->user_id;
    }

    public function getCreated(): string
    {
        return $this->created;
    }

    public function getLastAccessed(): string
    {
        return $this->last_accessed;
    }

    public function setId(string $id)
    {
        $this->id = $id;
        return $this;
    }

    public function setAlias(string $alias)
    {
        $this->alias = $alias;
        return $this;
    }

    public function setTarget(string $target)
    {
        $this->target = $target;
        return $this;
    }

    public function setUserId(int $user_id)
    {
        $this->user_id = $user_id;
        return $this;
    }

    public function setAccessLimit(int $access_limit)
    {
        $this->access_limit = $access_limit;
        return $this;
    }

    public function setAccessCount(int $access_cnt)
    {
        $this->access_cnt = $access_cnt;
        return $this;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'alias' => $this->alias,
            'target' => $this->target,
            'access_limit' => $this->access_limit,
            'access_cnt' => $this->access_cnt,
            'user_id' => $this->user_id,
            'created' => $this->created,
            'last_accessed' => $this->last_accessed,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = bin2hex($row['id']);
        $this->alias = $row['alias'];
        $this->target = $row['target'];
        $this->access_limit = $row['access_limit'];
        $this->access_cnt = $row['access_cnt'];
        $this->user_id = $row['user_id'];
        $this->created = $row['created'];
        $this->last_accessed = $row['last_accessed'];
    }
}
