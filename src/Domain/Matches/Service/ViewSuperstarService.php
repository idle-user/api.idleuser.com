<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewSuperstarService extends SuperstarService
{
    public function run(int $superstarId)
    {
        $superstar = $this->superstarRepository->findById($superstarId);

        $this->logger->info("Superstar id `${superstarId}` was viewed.");

        return $superstar;
    }
}
