<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListUserStatsService extends StatsService
{
    public function run(int $userId)
    {
        $userStatsList = $this->statsRepository->findByUserId($userId);

        $this->logger->info("User `${userId}` Stats list was viewed.");

        return $userStatsList;
    }
}
