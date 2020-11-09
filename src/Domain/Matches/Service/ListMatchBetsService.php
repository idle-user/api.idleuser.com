<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchBetsService extends BetService
{
    public function run(int $matchId)
    {
        $matchBetList = $this->betRepository->findByMatchId($matchId);

        $this->logger->info("Match `${matchId}` bet list was viewed.");

        return $matchBetList;
    }
}
