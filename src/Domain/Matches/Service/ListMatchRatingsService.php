<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchRatingsService extends MatchRatingService
{
    public function run()
    {
        $matchRatingList = $this->matchRatingRepository->findAll();

        $this->logger->info("Match Rating list was viewed.");

        return $matchRatingList;
    }
}
