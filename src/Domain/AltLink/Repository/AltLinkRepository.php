<?php
declare(strict_types=1);

namespace App\Domain\AltLink\Repository;

use App\Domain\AltLink\Data\AltLink;
use App\Domain\AltLink\Exception\AltLinkAlreadyExistsException;
use App\Domain\AltLink\Exception\AltLinkNotFoundException;
use App\Domain\Database;
use PDOException;

class AltLinkRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM altlink';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = AltLink::withRow($row);
        }
        if (empty($ret)) {
            throw new AltLinkNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM altlink WHERE id=?';
        $stmt = $this->db->query($sql, [bin2hex($id)]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new AltLinkNotFoundException();
        }
        return AltLink::withRow($row);
    }

    public function findByAlias($alias)
    {
        $sql = 'SELECT * FROM altlink WHERE id=UNHEX(MD5(?))';
        $stmt = $this->db->query($sql, [$alias]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new AltLinkNotFoundException();
        }
        return AltLink::withRow($row);
    }

    public function add(AltLink $altLink)
    {
        $sql = 'INSERT INTO altlink (id, alias, target, access_limit, access_cnt, user_id, created, last_accessed) VALUES (UNHEX(MD5(?)), ?, ?, ?, ?, ?, NOW(), NOW())';
        $args = [$altLink->getAlias(), $altLink->getAlias(), $altLink->getTarget(), $altLink->getAccessLimit(), $altLink->getAccessCount(), $altLink->getUserId()];

        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new AltLinkAlreadyExistsException();
            } else {
                throw $e;
            }
        }

        // TODO
        $altLinkId = $this->db->lastInsertId();

        return $altLinkId;
    }

    public function update(AltLink $altLink)
    {
        // TODO
        // $sql = 'UPDATE altlink access_cnt=?, last_updated=NOW() ON id=?;';
        // $args = [
        //     $altLink->getAccessCount(),
        //     $altLink->getId(),
        // ];

        // $this->db->query($sql, $args);

        // $altLinkId = bin2hex($this->db->lastInsertId());

        // return $altLinkId;
    }
}
