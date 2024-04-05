<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchMatchRatingsService extends MatchRatingService
{
    public function run(int $matchId)
    {
        $matchRatingList = $this->matchRatingRepository->findByMatchId($matchId);

        $this->logger->debug("Match `${matchId}` Match Rating list was viewed.");

        return $matchRatingList;
    }
}
