<?php
declare(strict_types=1);

namespace App\Domain\User\Data;

use JsonSerializable;

class User implements JsonSerializable
{
    private $id;
    private $username;
    private $email;
    private $discord_id;
    private $chatango_id;
    private $twitter_id;
    private $last_login;
    private $date_created;
    private $secret_last_updated;
    private $email_last_updated;
    private $discord_last_updated;
    private $chatango_last_updated;
    private $twitter_last_updated;
    private $access;
    private $login_token;
    private $login_token_exp;
    private $temp_secret;
    private $temp_secret_exp;
    private $api_token;
    private $api_token_exp;

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

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getApiToken(): string
    {
        return $this->api_token;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'access' => $this->access,
            'username' => $this->username,
            'discord_id' => $this->discord_id,
            'chatango_id' => $this->chatango_id,
            'twitter_id' => $this->twitter_id,
            'last_login' => $this->last_login,
            'date_created' => $this->date_created,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->username = $row['username'];
        $this->email = $row['email'];
        $this->discord_id = $row['discord_id'];
        $this->chatango_id = $row['chatango_id'];
        $this->twitter_id = $row['twitter_id'];
        $this->last_login = $row['last_login'];
        $this->date_created = $row['date_created'];
        $this->secret_last_updated = $row['secret_last_updated'];
        $this->email_last_updated = $row['email_last_updated'];
        $this->discord_last_updated = $row['discord_last_updated'];
        $this->chatango_last_updated = $row['chatango_last_updated'];
        $this->twitter_last_updated = $row['twitter_last_updated'];
        $this->access = $row['access'];
        $this->login_token = $row['login_token'];
        $this->login_token_exp = $row['login_token_exp'];
        $this->temp_secret = $row['temp_secret'];
        $this->temp_secret_exp = $row['temp_secret_exp'];
    }
}
