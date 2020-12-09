<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewCurrentMatchDetailService extends MatchService
{
    public function run()
    {
        $matchDetail = $this->matchRepository->findCurrentWithDetail();
        $matchId = $matchDetail->getId();
        $matchDetailTeamData = $this->matchRepository->findTeamInfoById($matchId);
        $matchDetail->setTeams($matchDetailTeamData);

        $this->logger->info("Match Current id `${matchId}` was viewed.");

        return $matchDetail;
    }
}
