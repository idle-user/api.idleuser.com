<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ViewStatsService extends PickemService
{
    public function run(int $userId)
    {
        $stats = $this->statsRepository->find($userId);

        $this->logger->debug("Stats user id `${userId}` was viewed.");

        return $stats;
    }
}
