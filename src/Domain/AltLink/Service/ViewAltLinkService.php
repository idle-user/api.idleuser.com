<?php
declare(strict_types=1);

namespace App\Domain\AltLink\Service;

final class ViewAltLinkService extends AltLinkService
{
    public function run(string $alias)
    {
        $altLink = $this->altLinkRepository->findByAlias($alias);

        $this->logger->debug("AltLink Alias `${alias}` was viewed.");

        return $altLink;
    }
}
