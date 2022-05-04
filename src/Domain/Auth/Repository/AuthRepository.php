<?php

declare(strict_types=1);

namespace App\Domain\Auth\Repository;

use App\Domain\Database;
use App\Domain\Auth\Data\Auth;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Domain\Auth\Exception\AuthTokenNotFoundException;

class AuthRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findByAuthToken($token)
    {
        $sql = 'SELECT * FROM api_auth WHERE auth_token=UNHEX(?)';
        $stmt = $this->db->query($sql, [$token]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new AuthTokenInvalidException();
        }
        return Auth::withRow($row);
    }

    public function findByUserId($userId)
    {
        $sql = 'SELECT * FROM api_auth WHERE user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new AuthTokenNotFoundException();
        }
        return Auth::withRow($row);
    }

    public function createAuthToken($userId, $access)
    {
        $token = bin2hex(random_bytes(32));
        $sql = 'INSERT INTO api_auth (auth_token, auth_token_exp, access_level, user_id, created, last_updated) VALUES (UNHEX(?), (SELECT NOW() + INTERVAL 1 YEAR), ?, ?, NOW(), NOW())';
        $this->db->query($sql, [$token, $access, $userId]);
        return $token;
    }

    public function updateAuthToken($userId)
    {
        $token = bin2hex(random_bytes(32));
        $sql = 'UPDATE api_auth SET auth_token=UNHEX(?), auth_token_exp=(SELECT NOW() + INTERVAL 1 YEAR), last_updated=NOW() WHERE user_id=?';
        $this->db->query($sql, [$token, $userId]);
        return $token;
    }
}
