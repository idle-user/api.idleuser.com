<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBetOpenMatchesDetailService extends MatchService
{
    public function run()
    {
        $matchDetailList = $this->matchRepository->findAllBetOpenWithDetail();

        $this->logger->info('Open Bet Match Detail list was viewed.');

        return $matchDetailList;
    }
}
