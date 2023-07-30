<?php
declare(strict_types=1);

namespace App\Domain\Chat\Service;

final class ViewSchedulerService extends SchedulerService
{
    public function run(int $schedulerId)
    {
        $scheduler = $this->schedulerRepository->findById($schedulerId);

        $this->logger->info("Chat scheduler `${schedulerId}` was viewed.");

        return $scheduler;
    }
}
