<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

class Leaderboard extends Stats
{
    private $username;

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function jsonSerialize()
    {
        $info = parent::jsonSerialize();
        $info["username"] = $this->username;
        return $info;
    }

    protected function fill(array $row)
    {
        parent::fill($row);
        $this->username = $row['username'];
    }
}
