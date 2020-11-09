<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewBetService extends BetService
{
    public function run(int $userId, int $matchId)
    {
        $title = $this->betRepository->findById($userId, $matchId);

        $this->logger->info("Bet user id `${userId}` match id `${matchId}` was viewed.");

        return $title;
    }
}
