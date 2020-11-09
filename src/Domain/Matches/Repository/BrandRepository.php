<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\Brand;
use App\Domain\Matches\Exception\BrandNotFoundException;

class BrandRepository
{

    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = "SELECT * FROM matches_brand";
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Brand::withRow($row);
        }
        if (empty($ret)) {
            throw new BrandNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = "SELECT * FROM matches_brand WHERE id=?";
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new BrandNotFoundException();
        }
        return Brand::withRow($row);
    }

}
