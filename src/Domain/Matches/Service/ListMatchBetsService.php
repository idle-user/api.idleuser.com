<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchBetsService extends BetService
{
    public function run(int $matchId)
    {
        $matchBetList = $this->betRepository->findByMatchId($matchId);

        $this->logger->debug("Match `${matchId}` Bet list was viewed.");

        return $matchBetList;
    }
}
