<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBetsDetailService extends BetDetailService
{
    public function run()
    {
        $betDetailList = $this->betDetailRepository->findAll();

        $this->logger->info('Bet detail list was viewed.');

        return $betDetailList;
    }
}
