<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListMatchTypesService extends MatchTypeService
{
    public function run()
    {
        $matchTypeList = $this->matchTypeRepository->findAll();

        $this->logger->debug('Match Type list was viewed.');

        return $matchTypeList;
    }
}
