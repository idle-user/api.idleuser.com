<?php
declare(strict_types=1);

namespace App\Domain\User\Repository;

use App\Domain\Database;
use App\Domain\User\Data\User;
use App\Domain\User\Exception\UserLoginFailedException;
use App\Domain\User\Exception\UsernameAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;

use PDOException;

class UserRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM user';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = User::withRow($row);
        }
        if (empty($ret)) {
            throw new UserNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM user WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new UserNotFoundException();
        }
        return User::withRow($row);
    }

    public function findByDiscordId($discordId)
    {
        $sql = 'SELECT * FROM user WHERE discord_id=?';
        $stmt = $this->db->query($sql, [$discordId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new UserNotFoundException();
        }
        return User::withRow($row);
    }

    public function findByChatangoId($chatangoId)
    {
        $sql = 'SELECT * FROM user WHERE chatango_id=?';
        $stmt = $this->db->query($sql, [$chatangoId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new UserNotFoundException();
        }
        return User::withRow($row);
    }

    public function findByUsername($username)
    {
        $sql = 'SELECT * FROM user WHERE username=?';
        $stmt = $this->db->query($sql, [$username]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new UserNotFoundException();
        }
        return User::withRow($row);
    }

    public function searchByUsername($username)
    {
        $sql = 'SELECT * FROM user WHERE username LIKE ?';
        $stmt = $this->db->query($sql, [$username]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = User::withRow($row);
        }
        if (empty($ret)) {
            throw new UserNotFoundException();
        }
        return $ret;
    }

    public function register(array $data)
    {
        $sql = 'INSERT INTO user (username, secret, discord_id, chatango_id, date_created) VALUES (?, ?, ?, ?, NOW())';
        $args = [
            $data['username'],
            password_hash($data['secret'], PASSWORD_BCRYPT),
            $data['discord_id'],
            $data['chatango_id'],
        ];

        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new UsernameAlreadyExistsException();
            } else {
                throw $e;
            }
        }

        $userId = $this->db->lastInsertId();

        return $userId;
    }

    public function login($username, $secret)
    {
        try {
            if (password_verify($secret, $this->findSecretByUsername($username))) {
                $sql = 'UPDATE user SET last_login=NOW() WHERE username=?';
                $this->db->query($sql, [$username]);
                return $this->findByUsername($username);
            } else {
                throw new UserLoginFailedException();
            }
        } catch (UserNotFoundException $e) {
            throw new UserLoginFailedException();
        }
    }

    private function findSecretByUsername($username)
    {
        $sql = 'SELECT secret FROM user WHERE username=?';
        $stmt = $this->db->query($sql, [$username]);
        $result = $stmt->fetchColumn();
        if (!$result) {
            throw new UserNotFoundException();
        }
        return $result;
    }

    public function updateLoginTokenById($userId, $loginToken)
    {
        $sql = 'UPDATE user SET login_token=?, login_token_exp=DATE_ADD(NOW(), INTERVAL 5 MINUTE) WHERE id=?';
        $this->db->query($sql, [$loginToken, $userId]);
        return $this->findById($userId);
    }
}
