<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewSeasonService extends SeasonService
{
    public function run(int $seasonId)
    {
        $season = $this->seasonRepository->findById($seasonId);

        $this->logger->info("Season id `${seasonId}` was viewed.");

        return $season;
    }
}
