<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Season;
use App\Domain\Matches\Exception\SeasonNotFoundException;

class SeasonRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_season';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Season::withRow($row);
        }
        if (empty($ret)) {
            throw new SeasonNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM matches_season WHERE season=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new SeasonNotFoundException();
        }
        return Season::withRow($row);
    }

    public function findByMatchId($matchId)
    {
        $sql = 'SELECT * FROM matches_season WHERE ? BETWEEN start_matchid AND IFNULL(end_matchid, ?)';
        $stmt = $this->db->query($sql, [$matchId, $matchId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new SeasonNotFoundException();
        }
        return Season::withRow($row);
    }
}
