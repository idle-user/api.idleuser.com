<?php
declare(strict_types=1);

namespace App\Domain\Chat\Service;

final class ListSchedulerService extends SchedulerService
{
    public function run()
    {
        $schedulerList = $this->schedulerRepository->findAll();

        $this->logger->info('Chat scheduler list was viewed.');

        return $schedulerList;
    }
}
