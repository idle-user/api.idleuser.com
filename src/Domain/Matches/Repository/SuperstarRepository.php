<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Superstar;
use App\Domain\Matches\Exception\SuperstarNotFoundException;

class SuperstarRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_superstar';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Superstar::withRow($row);
        }
        if (empty($ret)) {
            throw new SuperstarNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM matches_superstar WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new SuperstarNotFoundException();
        }
        return Superstar::withRow($row);
    }

    public function searchByName($keyword)
    {
        $sql = 'SELECT * FROM matches_superstar WHERE name LIKE ?';
        $stmt = $this->db->query($sql, [$keyword]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Superstar::withRow($row);
        }
        if (empty($ret)) {
            throw new SuperstarNotFoundException();
        }
        return $ret;
    }
}
