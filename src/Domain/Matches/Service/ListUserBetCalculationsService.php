<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListUserBetCalculationsService extends BetCalculationService
{
    public function run(int $userId)
    {
        $userBetCalculationList = $this->betCalculationRepository->findByUserId($userId);

        $this->logger->info("User `${userId}` Bet calculation list was viewed.");

        return $userBetCalculationList;
    }
}
