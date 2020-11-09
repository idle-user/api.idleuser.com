<?php

declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Match;
use App\Domain\Matches\Exception\MatchNotFoundException;

class MatchRepository
{

    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = "SELECT * FROM matches_match";
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Match::withRow($row);
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = "SELECT * FROM matches_match WHERE id=?";
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchNotFoundException();
        }
        return Match::withRow($row);
    }

    public function findAllBetOpen()
    {
        $sql = "SELECT * FROM matches_match WHERE betOpen=1";
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Match::withRow($row);
        }
        if(empty($ret)){
            throw new MatchNotFoundException();
        }
        return $ret;
    }

}
