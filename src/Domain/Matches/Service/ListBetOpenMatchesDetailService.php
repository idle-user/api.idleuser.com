<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBetOpenMatchesDetailService extends MatchService
{
    public function run()
    {
        $matchDetailList = $this->matchRepository->findAllBetOpenWithDetail();
        foreach ($matchDetailList as $matchDetail) {
            $matchDetailTeamData = $this->matchRepository->findTeamInfoById($matchDetail->getId());
            $matchDetail->setTeams($matchDetailTeamData);
        }

        $this->logger->debug('Open Bet Match Detail list was viewed.');

        return $matchDetailList;
    }
}
