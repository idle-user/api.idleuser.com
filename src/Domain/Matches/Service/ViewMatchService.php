<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewMatchService extends MatchService
{
    public function run(int $matchId)
    {
        $match = $this->matchRepository->findById($matchId);

        $this->logger->info("Match id `${matchId}` was viewed.");

        return $match;
    }

}
