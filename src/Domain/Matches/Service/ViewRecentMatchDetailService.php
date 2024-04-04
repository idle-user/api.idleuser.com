<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewRecentMatchDetailService extends MatchService
{
    public function run()
    {
        $matchDetail = $this->matchRepository->findRecentWithDetail();
        $matchId = $matchDetail->getId();
        $matchDetailTeamData = $this->matchRepository->findTeamInfoById($matchId);
        $matchDetail->setTeams($matchDetailTeamData);

        $this->logger->debug("Match Recent id `${matchId}` was viewed.");

        return $matchDetail;
    }
}
