<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewMatchTypeService extends MatchTypeService
{
    public function run(int $matchTypeId)
    {
        $matchType = $this->matchTypeRepository->findById($matchTypeId);

        $this->logger->debug("Match Type id `${matchTypeId}` was viewed.");

        return $matchType;
    }
}
