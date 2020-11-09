<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListUserMatchRatingsService extends MatchRatingService
{
    public function run(int $userId)
    {
        $userMatchRatingList = $this->matchRatingRepository->findByUserId($userId);

        $this->logger->info("User `${userId}` Match Rating list was viewed.");

        return $userMatchRatingList;
    }
}
