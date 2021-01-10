<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewBetCalculationService extends BetCalculationService
{
    public function run(int $userId, int $matchId)
    {
        $betCalculation = $this->betCalculationRepository->findById($userId, $matchId);

        $this->logger->info("Bet calculation user id `${userId}` match id `${matchId}` was viewed.");

        return $betCalculation;
    }
}
