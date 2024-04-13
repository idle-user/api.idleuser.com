<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Repository;

use App\Domain\Database;
use App\Domain\Pickem\Data\Pick;
use App\Domain\Pickem\Exception\PickAlreadyExistsException;
use App\Domain\Pickem\Exception\PickNotFoundException;
use PDOException;

class PickRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    /**
     * @return Pick[]
     * @throws PickNotFoundException
     */
    public function findAll($promptId = null, $choiceId = null, $userId = null): array
    {
        $whereConditions = [];
        $args = [];
        if ($promptId) {
            $whereConditions[] = 'prompt_id=?';
            $args[] = $promptId;
        }
        if ($choiceId) {
            $whereConditions[] = 'choice_id=?';
            $args[] = $choiceId;
        }
        if ($userId) {
            $whereConditions[] = 'user_id=?';
            $args[] = $userId;
        }

        $sql = 'SELECT * FROM pickem_pick';
        if (!empty($whereConditions)) {
            $sql .= " WHERE " . implode(" AND ", $whereConditions);
        }
        $stmt = $this->db->query($sql, $args);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Pick::withRow($row);
        }
        if (empty($ret)) {
            throw new PickNotFoundException();
        }
        return $ret;
    }

    public function find($promptId, $userId): Pick
    {
        $sql = 'SELECT * FROM pickem_pick WHERE prompt_id=? AND user_id=?';
        $stmt = $this->db->query($sql, [$promptId, $userId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new PickNotFoundException();
        }
        return Pick::withRow($row);
    }

    public function add(Pick $pick): void
    {
        $sql = 'INSERT INTO pickem_pick (prompt_id, choice_id, user_id) VALUES (?, ?, ?)';
        $args = [$pick->getPromptId(), $pick->getChoiceId(), $pick->getUserId()];
        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new PickAlreadyExistsException();
            } else {
                throw $e;
            }
        }
    }

    public function update(Pick $pick): void
    {
        $sql = 'UPDATE pickem_pick SET choice_id=?, updated_at=NOW() WHERE user_id=?';
        $args = [$pick->getChoiceId(), $pick->getUserId()];

        $this->db->query($sql, $args);
    }
}
