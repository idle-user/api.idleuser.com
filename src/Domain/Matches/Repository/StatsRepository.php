<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Stats;
use App\Domain\Matches\Data\Leaderboard;
use App\Domain\Matches\Exception\StatsNotFoundException;

class StatsRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_stats';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Stats::withRow($row);
        }
        if (empty($ret)) {
            throw new StatsNotFoundException();
        }
        return $ret;
    }

    public function findById($userId, $seasonId)
    {
        $sql = 'SELECT * FROM matches_stats WHERE user_id=? AND season=?';
        $stmt = $this->db->query($sql, [$userId, $seasonId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new StatsNotFoundException();
        }
        return Stats::withRow($row);
    }

    public function findByUserId($userId)
    {
        $sql = 'SELECT * FROM matches_stats WHERE user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Stats::withRow($row);
        }
        if (empty($ret)) {
            throw new StatsNotFoundException();
        }
        return $ret;
    }

    public function findBySeasonId($seasonId)
    {
        $sql = 'SELECT * FROM matches_stats WHERE season=?';
        $stmt = $this->db->query($sql, [$seasonId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Stats::withRow($row);
        }
        if (empty($ret)) {
            throw new StatsNotFoundException();
        }
        return $ret;
    }

    public function findLeaderboardBySeasonId($seasonId)
    {
        $sql = 'SELECT a.*, b.username FROM matches_stats a JOIN user b ON a.user_id=b.id WHERE season=? AND (wins+losses+ratings)>0 ORDER BY a.total_points DESC';
        $stmt = $this->db->query($sql, [$seasonId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Leaderboard::withRow($row);
        }
        if (empty($ret)) {
            throw new StatsNotFoundException();
        }
        return $ret;
    }
}
