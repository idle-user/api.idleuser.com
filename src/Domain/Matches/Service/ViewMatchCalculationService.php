<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewMatchCalculationService extends MatchCalculationService
{
    public function run(int $matchId)
    {
        $matchCalculationList = $this->matchCalculationRepository->findById($matchId);

        $this->logger->info("Match Calculation `${matchId}` was viewed.");

        return $matchCalculationList;
    }
}
