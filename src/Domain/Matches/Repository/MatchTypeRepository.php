<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\MatchType;
use App\Domain\Matches\Exception\MatchTypeNotFoundException;

class MatchTypeRepository
{

    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = "SELECT * FROM matches_match_type";
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchType::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchTypeNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = "SELECT * FROM matches_match_type WHERE id=?";
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchTypeNotFoundException();
        }
        return MatchType::withRow($row);
    }

}
