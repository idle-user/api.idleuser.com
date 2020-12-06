<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchesDetailService extends MatchService
{
    public function run()
    {
        $matchDetailList = $this->matchRepository->findAllWithDetail();

        $this->logger->info('Match Detail list was viewed.');

        return $matchDetailList;
    }
}
