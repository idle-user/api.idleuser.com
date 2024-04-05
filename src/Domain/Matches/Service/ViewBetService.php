<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewBetService extends BetService
{
    public function run(int $userId, int $matchId)
    {
        $bet = $this->betRepository->findById($userId, $matchId);

        $this->logger->debug("Bet user id `${userId}` match id `${matchId}` was viewed.");

        return $bet;
    }
}
