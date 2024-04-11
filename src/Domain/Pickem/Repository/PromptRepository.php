<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Repository;

use App\Domain\Database;
use App\Domain\Pickem\Data\Prompt;
use App\Domain\Pickem\Exception\PromptNotFoundException;
use PDOException;

class PromptRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll($open = null, $user_id = null, $group_id = null): array
    {
        $whereConditions = [];
        $args = [];
        if ($open) {
            $whereConditions[] = 'open=? AND expires_at>NOW()';
            $args[] = $open;
        }
        if ($user_id) {
            $whereConditions[] = 'user_id=?';
            $args[] = $user_id;
        }
        if ($group_id) {
            $whereConditions[] = 'group_id=?';
            $args[] = $group_id;
        }

        $sql = 'SELECT * FROM pickem_prompt';
        if (!empty($whereConditions)) {
            $sql .= " WHERE " . implode(" AND ", $whereConditions);
        }
        $stmt = $this->db->query($sql, $args);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Prompt::withRow($row);
        }
        if (empty($ret)) {
            throw new PromptNotFoundException();
        }
        return $ret;
    }

    public function findById($id): Prompt
    {
        $sql = 'SELECT * FROM pickem_prompt WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new PromptNotFoundException();
        }
        return Prompt::withRow($row);
    }

    public function add(Prompt $prompt): Prompt
    {
        $sql = 'INSERT INTO pickem_prompt (subject, user_id, group_id, expires_at) VALUES (?, ?, ?, DATE_ADD(NOW(), INTERVAL 1 DAY))';
        $args = [$prompt->getSubject(), $prompt->getUserId(), $prompt->getGroupId()];
        try {
            $this->db->query($sql, $args);
            $lastInsertId = $this->db->lastInsertId();
            return $this->findById($lastInsertId);
        } catch (PDOException $e) {
            throw $e;
        }
    }

    public function update(Prompt $prompt): void
    {
        $sql = 'UPDATE pickem_prompt SET open=?, choice_result=?, picks=?, updated_at=NOW() WHERE id=?';
        $args = [$prompt->getOpen(), $prompt->getChoiceResult(), $prompt->getPicks(), $prompt->getId()];

        $this->db->query($sql, $args);
    }
}
