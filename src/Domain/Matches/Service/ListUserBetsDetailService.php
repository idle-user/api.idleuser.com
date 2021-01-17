<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListUserBetsDetailService extends BetDetailService
{
    public function run(int $userId)
    {
        $userBetDetailList = $this->betDetailRepository->findByUserId($userId);

        $this->logger->info("User `${userId}` Bet detail list was viewed.");

        return $userBetDetailList;
    }
}
