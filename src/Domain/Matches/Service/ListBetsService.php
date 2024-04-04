<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBetsService extends BetService
{
    public function run()
    {
        $betList = $this->betRepository->findAll();

        $this->logger->debug('Bet list was viewed.');

        return $betList;
    }
}
