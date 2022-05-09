<?php
declare(strict_types=1);

namespace App\Domain\User\Data;

use JsonSerializable;

class User implements JsonSerializable
{
    private $showFullDetail;

    private $id;
    private $username;
    private $email;
    private $discord_id;
    private $chatango_id;
    private $twitter_id;
    private $last_login;
    private $date_created;
    private $username_last_updated;
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

    public function __construct()
    {
        $this->showFullDetail = false;
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function isShowingFullDetail()
    {
        return $this->showFullDetail;
    }

    public function setShowFullDetail(bool $showFullDetail)
    {
        $this->showFullDetail = $showFullDetail;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAccessLevel(): ?int
    {
        return $this->access;
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function getDiscordId(): ?string
    {
        return $this->discord_id;
    }

    public function getChatangoId(): ?string
    {
        return $this->chatango_id;
    }

    public function getTwitterId(): ?string
    {
        return $this->twitter_id;
    }

    public function getLoginToken(): ?string
    {
        return $this->login_token;
    }

    public function getSecretToken(): ?string
    {
        return $this->temp_secret;
    }

    public function canUpdateUsername()
    {
        if ($this->username_last_updated == 0) {
            return true;
        }
        $usernameLastUpdated = strtotime($this->username_last_updated);
        return strtotime('+14 day', $usernameLastUpdated) < strtotime('now');
    }

    public function jsonSerialize()
    {
        $publicDetail = [
            'id' => $this->id,
            'username' => $this->username,
            'last_login' => $this->last_login,
            'date_created' => $this->date_created,
        ];
        $privateDetail = [
            'access' => $this->access,
            'username_last_updated' => $this->username_last_updated,
            'email' => $this->email,
            'email_last_updated' => $this->email_last_updated,
            'secret_last_updated' => $this->secret_last_updated,
            'login_token' => $this->login_token,
            'login_token_exp' => $this->login_token_exp,
            'temp_secret' => $this->temp_secret,
            'temp_secret_exp' => $this->temp_secret_exp,
            'discord_id' => $this->discord_id,
            'discord_last_updated' => $this->discord_last_updated,
            'chatango_id' => $this->chatango_id,
            'chatango_last_updated' => $this->chatango_last_updated,
            'twitter_id' => $this->twitter_id,
            'twitter_last_updated' => $this->twitter_last_updated,
        ];
        if ($this->showFullDetail) {
            return array_merge($publicDetail, $privateDetail);
        }
        return $publicDetail;
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
        $this->username_last_updated = $row['username_last_updated'];
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
