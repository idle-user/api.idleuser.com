<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\RoyalRumble;
use App\Domain\Matches\Exception\RoyalRumbleNotFoundException;

class RoyalRumbleRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_royalrumble';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = RoyalRumble::withRow($row);
        }
        if (empty($ret)) {
            throw new RoyalRumbleNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM matches_royalrumble WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new RoyalRumbleNotFoundException();
        }
        return RoyalRumble::withRow($row);
    }
}
