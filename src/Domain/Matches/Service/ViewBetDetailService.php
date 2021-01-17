<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewBetDetailService extends BetDetailService
{
    public function run(int $userId, int $matchId)
    {
        $betDetail = $this->betDetailRepository->findById($userId, $matchId);

        $this->logger->info("Bet detail user id `${userId}` match id `${matchId}` was viewed.");

        return $betDetail;
    }
}
