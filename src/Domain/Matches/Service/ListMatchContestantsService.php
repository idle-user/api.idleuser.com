<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchContestantsService extends ContestantService
{
    public function run(int $matchId)
    {
        $matchContestantList = $this->contestantRepository->findByMatchId($matchId);

        $this->logger->debug("Match `${matchId}` contestant list was viewed.");

        return $matchContestantList;
    }
}
