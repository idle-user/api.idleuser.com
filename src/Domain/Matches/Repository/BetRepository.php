<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Bet;
use App\Domain\Matches\Exception\BetAlreadyExistsException;
use App\Domain\Matches\Exception\BetNotFoundException;
use PDOException;

class BetRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_bet';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Bet::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }

    public function findById($userId, $matchId)
    {
        $sql = 'SELECT * FROM matches_bet WHERE user_id=? AND match_id=?';
        $stmt = $this->db->query($sql, [$userId, $matchId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new BetNotFoundException();
        }
        return Bet::withRow($row);
    }

    public function findByUserId($userId)
    {
        $sql = 'SELECT * FROM matches_bet WHERE user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Bet::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }

    public function findByMatchId($matchId)
    {
        $sql = 'SELECT * FROM matches_bet WHERE match_id=?';
        $stmt = $this->db->query($sql, [$matchId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Bet::withRow($row);
        }
        if (empty($ret)) {
            throw new BetNotFoundException();
        }
        return $ret;
    }

    public function add(Bet $bet)
    {
        $sql = 'INSERT INTO matches_bet (user_id, match_id, team, points, dt_placed) VALUES (?, ?, ?, ?, NOW())';
        $args = [$bet->getUserId(), $bet->getMatchId(), $bet->getTeam(), $bet->getPoints()];
        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new BetAlreadyExistsException();
            } else {
                throw $e;
            }
        }
    }

    public function update(Bet $bet)
    {
        $sql = 'UPDATE matches_bet SET points=?, dt_placed=NOW() WHERE user_id=? AND match_id=? AND team=?';
        $args = [$bet->getPoints(), $bet->getUserId(), $bet->getMatchId(), $bet->getTeam()];
        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new BetAlreadyExistsException();
            } else {
                throw $e;
            }
        }
    }
}
