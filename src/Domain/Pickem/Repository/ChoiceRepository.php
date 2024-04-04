<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Repository;

use App\Domain\Database;
use App\Domain\Pickem\Data\Choice;
use App\Domain\Pickem\Exception\ChoiceNotFoundException;
use PDOException;

class ChoiceRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll(): array
    {
        $sql = 'SELECT * FROM pickem_choice';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Choice::withRow($row);
        }
        if (empty($ret)) {
            throw new ChoiceNotFoundException();
        }
        return $ret;
    }

    public function findById($id): Choice
    {
        $sql = 'SELECT * FROM pickem_choice WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new ChoiceNotFoundException();
        }
        return Choice::withRow($row);
    }

    public function findByPromptId($prompt_id): array
    {
        $sql = 'SELECT * FROM pickem_choice WHERE prompt_id=?';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Choice::withRow($row);
        }
        if (empty($ret)) {
            throw new ChoiceNotFoundException();
        }
        return $ret;
    }

    public function add(Choice $choice): Choice
    {
        $sql = 'INSERT INTO pickem_choice (prompt_id, subject) VALUES (?, ?)';
        $args = [$choice->getPromptId(), $choice->getSubject()];
        try {
            $this->db->query($sql, $args);
            $lastInsertId = $this->db->lastInsertId();
            return $this->findById($lastInsertId);
        } catch (PDOException $e) {
            throw $e;
        }
    }

    public function update(Choice $choice): void
    {
        $sql = 'UPDATE pickem_choice SET picks=?, updated_at=NOW() WHERE id=?';
        $args = [$choice->getPicks(), $choice->getId()];

        $this->db->query($sql, $args);
    }
}
