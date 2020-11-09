<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListSeasonStatsService extends StatsService
{
    public function run(int $seasonId)
    {
        $seasonStatsList = $this->statsRepository->findBySeasonId($seasonId);

        $this->logger->info("Season `${seasonId}` Stats list was viewed.");

        return $seasonStatsList;
    }
}
