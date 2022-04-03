<?php
declare(strict_types=1);

namespace App\Domain\AltLink\Service;

final class ListAltLinksService extends AltLinkService
{
    public function run()
    {
        $altLinkList = $this->altLinkRepository->findAll();

        $this->logger->info('AltLink list was viewed.');

        return $altLinkList;
    }
}
