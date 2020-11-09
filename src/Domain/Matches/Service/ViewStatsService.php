<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewStatsService extends StatsService
{
    public function run(int $userId, int $seasonId)
    {
        $stats = $this->statsRepository->findById($userId, $seasonId);

        $this->logger->info("Stats user id `${userId}` season id `${seasonId}` was viewed.");

        return $stats;
    }
}
