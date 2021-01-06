<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBetCalculationsService extends BetCalculationService
{
    public function run()
    {
        $betCalculationList = $this->betCalculationRepository->findAll();

        $this->logger->info('Bet calculation list was viewed.');

        return $betCalculationList;
    }
}
