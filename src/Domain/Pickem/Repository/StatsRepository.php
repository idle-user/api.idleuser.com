<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Repository;

use App\Domain\Database;
use App\Domain\Pickem\Data\Stats;
use App\Domain\Pickem\Exception\StatsAlreadyExistsException;
use App\Domain\Pickem\Exception\StatsNotFoundException;
use PDOException;

class StatsRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    /**
     * @return Stats[]
     * @throws StatsNotFoundException
     */
    public function findAll(): array
    {
        $sql = 'SELECT * FROM pickem_stats';
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

    public function find($user_id): Stats
    {
        $sql = 'SELECT * FROM pickem_stats WHERE user_id=?';
        $stmt = $this->db->query($sql, [$user_id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new StatsNotFoundException();
        }
        return Stats::withRow($row);
    }

    public function add(Stats $stats): void
    {
        $sql = 'INSERT INTO pickem_stats (user_id) VALUES (?)';
        $args = [$stats->getUserId()];
        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new StatsAlreadyExistsException();
            } else {
                throw $e;
            }
        }
    }

    public function update(Stats $stats): void
    {
        $sql = 'UPDATE pickem_stats 
            SET
                prompts_created=?, 
                picks_made=?, 
                picks_correct=?, 
                picks_correct_others=?, 
                last_prompt_date=?, 
                prompts_created_today=?, 
                updated_at=NOW()
            WHERE 
                user_id=?';
        $args = [
            $stats->getPromptsCreated(),
            $stats->getPicksMade(),
            $stats->getPicksCorrect(),
            $stats->getPicksCorrectOthers(),
            $stats->getLastPromptDate(),
            $stats->getPromptsCreatedToday(),
            $stats->getUserId()
        ];

        $this->db->query($sql, $args);
    }
}
