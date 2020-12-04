<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\MatchCalculation;
use App\Domain\Matches\Exception\MatchCalculationNotFoundException;

class MatchCalculationRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_match_calculation';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchCalculation::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchCalculationNotFoundException();
        }
        return $ret;
    }

    public function findById($matchId)
    {
        $sql = 'SELECT * FROM matches_match_calculation WHERE match_id=?';
        $stmt = $this->db->query($sql, [$matchId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchCalculationNotFoundException();
        }
        return MatchCalculation::withRow($row);
    }
}
