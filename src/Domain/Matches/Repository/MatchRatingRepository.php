<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\MatchRating;
use App\Domain\Matches\Exception\MatchRatingNotFoundException;

class MatchRatingRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_match_rating';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchRating::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchRatingNotFoundException();
        }
        return $ret;
    }

    public function findById($userId, $matchId)
    {
        $sql = 'SELECT * FROM matches_match_rating WHERE user_id=? AND match_id=?';
        $stmt = $this->db->query($sql, [$userId, $matchId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new MatchRatingNotFoundException();
        }
        return MatchRating::withRow($row);
    }

    public function findByUserId($userId)
    {
        $sql = 'SELECT * FROM matches_match_rating WHERE user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchRating::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchRatingNotFoundException();
        }
        return $ret;
    }

    public function findByMatchId($matchId)
    {
        $sql = 'SELECT * FROM matches_match_rating WHERE match_id=?';
        $stmt = $this->db->query($sql, [$matchId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = MatchRating::withRow($row);
        }
        if (empty($ret)) {
            throw new MatchRatingNotFoundException();
        }
        return $ret;
    }

    public function add(MatchRating $rating)
    {
        $sql = 'INSERT INTO matches_match_rating (user_id, match_id, rating, updated) VALUES (?, ?, ?, NOW())
                ON DUPLICATE KEY UPDATE rating=?, updates=updates+1, updated=NOW();';
        $args = [$rating->getUserId(), $rating->getMatchId(), $rating->getRating(), $rating->getRating()];

        $this->db->query($sql, $args);
    }
}
