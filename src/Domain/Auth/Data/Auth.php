<?php
declare(strict_types=1);

namespace App\Domain\Auth\Data;

use JsonSerializable;

class Auth implements JsonSerializable
{
    private $auth_token;
    private $auth_token_exp;
    private $access_level;
    private $user_id;
    private $created;
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

    public function getUserId(): ?int
    {
        return $this->user_id;
    }

    public function getAuthToken(): string
    {
        return $this->auth_token;
    }

    public function getAuthTokenExp(): string
    {
        return $this->auth_token_exp;
    }

    public function getAccessLevel(): int
    {
        return $this->access_level;
    }

    public function isAuthExpired(): bool
    {
        $authExpTimestamp = strtotime($this->auth_token_exp);
        return time() > $authExpTimestamp;
    }

    public function isMod(): bool
    {
        return $this->access_level == 2 || $this->isAdmin();
    }

    public function isAdmin(): bool
    {
        return $this->access_level == 3;
    }

    public function jsonSerialize()
    {
        return [
            'auth_token' => $this->auth_token,
            'auth_token_exp' => $this->auth_token_exp,
            'access_level' => $this->access_level,
            'user_id' => $this->user_id,
            'created' => $this->created,
            'last_updated' => $this->last_updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->auth_token = bin2hex($row['auth_token']);
        $this->auth_token_exp = $row['auth_token_exp'];
        $this->access_level = $row['access_level'];
        $this->user_id = $row['user_id'];
        $this->created = $row['created'];
        $this->last_updated = $row['last_updated'];
    }
}
