<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListSeasonsService extends SeasonService
{
    public function run()
    {
        $seasonList = $this->seasonRepository->findAll();

        $this->logger->debug('Season list was viewed.');

        return $seasonList;
    }
}
