<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListPicksService extends PickemService
{
    public function run(?int $promptId = null, ?int $choiceId = null, ?int $userId = null)
    {

        $this->logger->debug("View Picks list attempt. . userId:${userId} promptId:${promptId} choiceId:${choiceId}");

        $pickList = $this->pickRepository->findAll($promptId, $choiceId, $userId);

        $this->logger->debug("Picks list was viewed. userId:${userId} promptId:${promptId} choiceId:${choiceId}");
        return $pickList;
    }
}
