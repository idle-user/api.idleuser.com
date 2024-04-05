<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListStatsService extends StatsService
{
    public function run()
    {
        $statsList = $this->statsRepository->findAll();

        $this->logger->debug('Stats list was viewed.');

        return $statsList;
    }
}
