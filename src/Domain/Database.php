<?php
declare(strict_types=1);

namespace App\Domain;

use PDO;

class Database
{
    protected $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function uuid()
    {
        return $this->pdo->query('SELECT UUID()')->fetchColumn();
    }

    public function lastInsertId()
    {
        return $this->pdo->lastInsertId();
    }

    public function query($sql, $args = null)
    {
        if (!$args) {
            return $this->pdo->query($sql);
        }
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($args);
        return $stmt;
    }
}
