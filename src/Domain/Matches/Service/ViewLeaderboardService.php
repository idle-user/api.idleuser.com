<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewLeaderboardService extends StatsService
{
    public function run(int $seasonId)
    {
        $leaderboard = $this->statsRepository->findLeaderboardBySeasonId($seasonId);

        $this->logger->debug("Leaderboard season id `${seasonId}` was viewed.");

        return $leaderboard;
    }
}
