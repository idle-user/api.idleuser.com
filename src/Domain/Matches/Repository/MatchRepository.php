<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Match;
use App\Domain\Matches\Data\MatchDetail;
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
        $sql = 'SELECT * FROM matches_match';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Match::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM matches_match WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchNotFoundException();
        }
        return Match::withRow($row);
    }

    public function findAllBetOpen()
    {
        $sql = 'SELECT * FROM matches_match WHERE bet_open=1';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Match::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchNotFoundException();
        }
        return $ret;
    }

    public function findAllWithDetail()
    {
        $sql = 'SELECT * FROM uv_matches_match_detail';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchDetail::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchNotFoundException();
        }
        return $ret;
    }

    public function findByIdWithDetail($id)
    {
        $sql = 'SELECT * FROM uv_matches_match_detail WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchNotFoundException();
        }
        return MatchDetail::withRow($row);
    }

    public function findAllBetOpenWithDetail()
    {
        $sql = 'SELECT * FROM uv_matches_match_detail WHERE bet_open=1';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchDetail::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchNotFoundException();
        }
        return $ret;
    }

    public function findCurrentWithDetail()
    {
        $sql = 'SELECT * FROM uv_matches_match_detail WHERE completed=0 AND pot_valid=1 AND bet_open=0 LIMIT 1';
        $stmt = $this->db->query($sql);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchNotFoundException();
        }
        return MatchDetail::withRow($row);
    }

    public function findRecentWithDetail()
    {
        $sql =
            'SELECT * FROM uv_matches_match_detail WHERE completed=1 AND info_last_updated > NOW() - INTERVAL 10 MINUTE LIMIT 1';
        $stmt = $this->db->query($sql);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchNotFoundException();
        }
        return MatchDetail::withRow($row);
    }

    public function findTeamInfoById($id)
    {
        $sql = 'CALL usp_matches_sel_match_teams_by_id(?)';
        $stmt = $this->db->query($sql, [$id]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = $row;
        }
        if (empty($ret)) {
            throw new MatchNotFoundException();
        }
        return $ret;
    }

    public function updateCalculations($matchId)
    {
        $sql = 'CALL usp_matches_upd_match_calculation(?)';
        $this->db->query($sql, [$matchId]);
    }
}
