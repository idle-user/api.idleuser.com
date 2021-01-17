<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\BetDetail;
use App\Domain\Matches\Exception\BetNotFoundException;

class BetDetailRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM uv_matches_user_bets';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = BetDetail::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }

    public function findById($userId, $matchId)
    {
        $sql = 'SELECT * FROM uv_matches_user_bets WHERE user_id=? AND match_id=?';
        $stmt = $this->db->query($sql, [$userId, $matchId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new BetNotFoundException();
        }
        return BetDetail::withRow($row);
    }

    public function findByUserId($userId)
    {
        $sql = 'SELECT * FROM uv_matches_user_bets WHERE user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = BetDetail::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }

    public function findByMatchId($matchId)
    {
        $sql = 'SELECT * FROM uv_matches_user_bets WHERE match_id=?';
        $stmt = $this->db->query($sql, [$matchId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = BetDetail::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }

    public function findAllCurrentByUserId($userId)
    {
        $sql = 'SELECT * FROM uv_matches_user_bets WHERE completed=0 AND user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = BetDetail::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }
}
