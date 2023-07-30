<?php
declare(strict_types=1);

namespace App\Domain\Chat\Repository;

use App\Domain\Chat\Data\Scheduler;
use App\Domain\Chat\Exception\SchedulerNotFoundException;
use App\Domain\Database;

class SchedulerRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM chatroom_scheduler';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Scheduler::withRow($row);
        }
        if (empty($ret)) {
            throw new SchedulerNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM chatroom_scheduler WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new SchedulerNotFoundException();
        }
        return Scheduler::withRow($row);
    }
}
