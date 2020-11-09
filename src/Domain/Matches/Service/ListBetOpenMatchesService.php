<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBetOpenMatchesService extends MatchService
{
    public function run()
    {
        $matchList = $this->matchRepository->findAllBetOpen();

        $this->logger->info("Open Bet Match list was viewed.");

        return $matchList;
    }
}
