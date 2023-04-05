<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\FavoriteSuperstar;
use App\Domain\Matches\Exception\FavoriteSuperstarNotFoundException;

class FavoriteSuperstarRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_favorite_superstar';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = FavoriteSuperstar::withRow($row);
        }
        if (empty($ret)) {
            throw new FavoriteSuperstarNotFoundException();
        }
        return $ret;
    }

    public function findById($userId, $superstarId)
    {
        $sql = 'SELECT * FROM matches_favorite_superstar WHERE user_id=? AND superstar_id=?';
        $stmt = $this->db->query($sql, [$userId, $superstarId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new FavoriteSuperstarNotFoundException();
        }
        return FavoriteSuperstar::withRow($row);
    }

    public function findByUserId($userId)
    {
        $sql = 'SELECT * FROM matches_favorite_superstar WHERE user_id=?';
        $stmt = $this->db->query($sql, [$userId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = FavoriteSuperstarNotFoundException::withRow($row);
        }
        if (empty($ret)) {
            throw new FavoriteSuperstarNotFoundException();
        }
        return $ret;
    }

    public function findBySuperstarId($superstarId)
    {
        $sql = 'SELECT * FROM matches_favorite_superstar WHERE superstar_id=?';
        $stmt = $this->db->query($sql, [$superstarId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = FavoriteSuperstarNotFoundException::withRow($row);
        }
        if (empty($ret)) {
            throw new FavoriteSuperstarNotFoundException();
        }
        return $ret;
    }

    public function add(FavoriteSuperstar $favoriteSuperstar)
    {
        $sql = 'INSERT INTO matches_favorite_superstar (user_id, superstar_id, updated) VALUES (?, ?, NOW())
                ON DUPLICATE KEY UPDATE superstar_id=?, updated=NOW();';
        $args = [$favoriteSuperstar->getUserId(), $favoriteSuperstar->getSuperstarId(), $favoriteSuperstar->getSuperstarId()];

        $this->db->query($sql, $args);
    }
}
