<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchesService extends MatchService
{
    public function run()
    {
        $matchList = $this->matchRepository->findAll();

        $this->logger->info('Match list was viewed.');

        return $matchList;
    }
}
