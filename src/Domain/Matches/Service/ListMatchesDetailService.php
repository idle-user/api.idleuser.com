<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchesDetailService extends MatchService
{
    public function run()
    {
        $matchDetailList = $this->matchRepository->findAllWithDetail();
        foreach ($matchDetailList as $matchDetail) {
            $matchDetailTeamData = $this->matchRepository->findTeamInfoById($matchDetail->getId());
            $matchDetail->setTeams($matchDetailTeamData);
        }

        $this->logger->info('Match Detail list was viewed.');

        return $matchDetailList;
    }
}
