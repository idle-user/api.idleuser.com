<?php
declare(strict_types=1);

namespace App\Domain\Matches\Repository;

use App\Domain\Database;
use App\Domain\Matches\Data\RoyalRumbleEntry;
use App\Domain\Matches\Exception\RoyalRumbleEntryAlreadyExistsException;
use App\Domain\Matches\Exception\RoyalRumbleEntryNotFoundException;

use PDOException;

class RoyalRumbleEntryRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM matches_royalrumble_entry';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = RoyalRumbleEntry::withRow($row);
        }
        if (empty($ret)) {
            throw new RoyalRumbleEntryNotFoundException();
        }
        return $ret;
    }

    public function findById($royalrumbleId, $displayName)
    {
        $sql = 'SELECT * FROM matches_royalrumble_entry WHERE royalrumble_id=? AND display_name=?';
        $stmt = $this->db->query($sql, [$royalrumbleId, $displayName]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new RoyalRumbleEntryNotFoundException();
        }
        return RoyalRumbleEntry::withRow($row);
    }

    public function findByRoyalRumbleId($royalrumbleId)
    {
        $sql = 'SELECT * FROM matches_royalrumble_entry WHERE royalrumble_id=?';
        $stmt = $this->db->query($sql, [$royalrumbleId]);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = RoyalRumbleEntry::withRow($row);
        }
        if (empty($ret)) {
            throw new RoyalRumbleEntryNotFoundException();
        }
        return $ret;
    }

    public function findByRoyalRumbleIdUserId($royalrumbleId, $userId)
    {
        $sql = 'SELECT * FROM matches_royalrumble_entry WHERE royalrumble_id=? AND user_id=?';
        $stmt = $this->db->query($sql, [$royalrumbleId, $userId]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new RoyalRumbleEntryNotFoundException();
        }
        return RoyalRumbleEntry::withRow($row);
    }

    public function add(RoyalRumbleEntry $royalRumbleEntry)
    {
        $sql =
            'INSERT INTO matches_royalrumble_entry (royalrumble_id, entry, user_id, display_name, comment, created) VALUES (?, ?, ?, ?, ?, NOW())';
        $args = [
            $royalRumbleEntry->getRoyalRumbleId(),
            $royalRumbleEntry->getEntry(),
            $royalRumbleEntry->getUserId(),
            $royalRumbleEntry->getDisplayName(),
            $royalRumbleEntry->getComment(),
        ];
        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new RoyalRumbleEntryAlreadyExistsException();
            } else {
                throw $e;
            }
        }
    }
}
