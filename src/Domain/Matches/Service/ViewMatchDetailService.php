<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewMatchDetailService extends MatchService
{
    public function run(int $matchId)
    {
        $matchDetail = $this->matchRepository->findByIdWithDetail($matchId);

        $this->logger->info("Match Detail id `${matchId}` was viewed.");

        return $matchDetail;
    }
}
