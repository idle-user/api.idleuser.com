<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListCurrentUserBetsDetailService extends BetDetailService
{
    public function run(int $userId)
    {
        $userBetDetailList = $this->betDetailRepository->findAllCurrentByUserId($userId);

        $this->logger->info("User `${userId}` Current Bet detail list was viewed.");

        return $userBetDetailList;
    }
}
