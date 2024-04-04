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

    public function findAll(): array
    {
        $sql = 'SELECT * FROM pickem_pick';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Pick::withRow($row);
        }
        if (empty($ret)) {
            throw new PickNotFoundException();
        }
        return $ret;
    }

    public function find($prompt_id, $user_id): Pick
    {
        $sql = 'SELECT * FROM pickem_pick WHERE prompt_id=? AND user_id=?';
        $stmt = $this->db->query($sql, [$prompt_id, $user_id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new PickNotFoundException();
        }
        return Pick::withRow($row);
    }

    /**
     * @return Pick[]
     * @throws PickNotFoundException
     */
    public function findAllByPromptId($prompt_id): array
    {
        $sql = 'SELECT * FROM pickem_pick WHERE prompt_id=?';
        $stmt = $this->db->query($sql, [$prompt_id]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Pick::withRow($row);
        }
        if (empty($ret)) {
            throw new PickNotFoundException();
        }
        return $ret;
    }

    public function findAllByChoiceId($choice_id): Pick
    {
        $sql = 'SELECT * FROM pickem_pick WHERE choice_id=?';
        $stmt = $this->db->query($sql, [$choice_id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new PickNotFoundException();
        }
        return Pick::withRow($row);
    }

    public function findAllByUserId($user_id): array
    {
        $sql = 'SELECT * FROM pickem_pick WHERE user_id=?';
        $stmt = $this->db->query($sql, [$user_id]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Pick::withRow($row);
        }
        if (empty($ret)) {
            throw new PickNotFoundException();
        }
        return $ret;
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
