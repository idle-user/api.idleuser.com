<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewMatchTypeService extends MatchTypeService
{
    public function run(int $matchTypeId)
    {
        $brand = $this->matchTypeRepository->findById($matchTypeId);

        $this->logger->info("Match Type id `${matchTypeId}` was viewed.");

        return $brand;
    }
}
