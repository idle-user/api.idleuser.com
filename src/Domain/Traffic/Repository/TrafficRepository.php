<?php

declare(strict_types=1);

namespace App\Domain\Traffic\Repository;

use App\Domain\Database;
use App\Domain\Traffic\Data\Traffic;
use App\Domain\Traffic\Exception\TrafficNotFoundException;

class TrafficRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findById($id)
    {
        $sql = 'SELECT id AS uuid, traffic.* FROM traffic WHERE id=UUID_TO_BIN(?)';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new TrafficNotFoundException();
        }
        return Traffic::withRow($row);
    }

    public function addTraffic($domain, $requestText, $userAgent, $ipAddress, $userId, $note = null)
    {
        $sql = 'CALL usp_traffic_ins(?, ?, ?, ?, ?, ?)';
        $stmt = $this->db->query($sql, [$domain, $requestText, $userAgent, $ipAddress, $userId, $note]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new TrafficNotFoundException();
        }
        return Traffic::withRow($row);
    }

    public function updateResponseCode($trafficId, $responseCode)
    {
        $sql = 'UPDATE traffic SET response_code=?, response_updated=NOW() WHERE id=UUID_TO_BIN(?)';
        $this->db->query($sql, [$responseCode, $trafficId]);
    }
}
