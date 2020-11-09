<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListUserBetsService extends BetService
{
    public function run(int $userId)
    {
        $userBetList = $this->betRepository->findByUserId($userId);

        $this->logger->info("User `${userId}` bet list was viewed.");

        return $userBetList;
    }
}
