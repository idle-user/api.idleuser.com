<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchBetsDetailService extends BetDetailService
{
    public function run(int $matchId)
    {
        $matchBetsDetailList = $this->betDetailRepository->findByMatchId($matchId);

        $this->logger->info("Match `${matchId}` Bet details list was viewed.");

        return $matchBetsDetailList;
    }
}
