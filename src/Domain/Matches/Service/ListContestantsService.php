<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListContestantsService extends ContestantService
{
    public function run()
    {
        $contestantList = $this->contestantRepository->findAll();

        $this->logger->debug('Contestant list was viewed.');

        return $contestantList;
    }
}
