<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchCalculationsService extends MatchCalculationService
{
    public function run()
    {
        $matchCalculationList = $this->matchCalculationRepository->findAll();

        $this->logger->debug('Match Calculation list was viewed.');

        return $matchCalculationList;
    }
}
