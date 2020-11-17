<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Contestant;
use App\Domain\Matches\Exception\ContestantNotFoundException;

class ContestantRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_contestant';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Contestant::withRow($row);
        }
        if (empty($ret)) {
            throw new ContestantNotFoundException();
        }
        return $ret;
    }

    public function findById($match_id, $superstar_id, $team)
    {
        $sql = 'SELECT * FROM matches_contestant WHERE match_id=? AND superstar_id=? AND team=?';
        $stmt = $this->db->query($sql, [$match_id, $superstar_id, $team]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new ContestantNotFoundException();
        }
        return Contestant::withRow($row);
    }

    public function findByMatchId($match_id)
    {
        $sql = 'SELECT * FROM matches_contestant WHERE match_id=?';
        $stmt = $this->db->query($sql, [$match_id]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Contestant::withRow($row);
        }
        if (empty($ret)) {
            throw new ContestantNotFoundException();
        }
        return $ret;
    }
}
