<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListStatsService extends PickemService
{
    public function run()
    {
        $statsList = $this->statsRepository->findAll();

        $this->logger->debug('Stats list was viewed.');

        return $statsList;
    }
}
