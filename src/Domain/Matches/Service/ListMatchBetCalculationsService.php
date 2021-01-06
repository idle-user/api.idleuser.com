<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchBetCalculationsService extends BetCalculationService
{
    public function run(int $matchId)
    {
        $matchBetCalculationsList = $this->betCalculationRepository->findByMatchId($matchId);

        $this->logger->info("Match `${matchId}` Bet calculations list was viewed.");

        return $matchBetCalculationsList;
    }
}
