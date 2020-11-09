<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewMatchRatingService extends MatchRatingService
{
    public function run(int $userId, int $matchId)
    {
        $matchRating = $this->matchRatingRepository->findById($userId, $matchId);

        $this->logger->info("Match Rating user id `${userId}` match id `${matchId}` was viewed.");

        return $matchRating;
    }
}
