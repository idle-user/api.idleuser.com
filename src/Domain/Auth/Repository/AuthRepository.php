<?php

declare(strict_types=1);

namespace App\Domain\Auth\Repository;

use App\Domain\Database;
use App\Domain\Auth\Data\Auth;
use App\Domain\Auth\Exception\AuthTokenInvalidException;

class AuthRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findByAuthToken($authToken)
    {
        $token = hex2bin($authToken);
        $sql = 'SELECT * FROM api_auth WHERE auth_token=?';
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
            throw new AuthTokenInvalidException();
        }
        return Auth::withRow($row);
    }

    public function updateAuthToken($userId)
    {
        $token = random_bytes(32);
        $sql = 'CALL usp_api_ins_auth(?, ?)';
        $this->db->query($sql, [$userId, $token]);
        return bin2hex($token);
    }
}
