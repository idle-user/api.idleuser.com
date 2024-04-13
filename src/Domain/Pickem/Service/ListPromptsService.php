<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListPromptsService extends PickemService
{
    public function run(bool $open, ?int $userId = null, ?string $groupId = null)
    {
        $this->logger->debug("View Prompt list attempt. open:${open} userId:${userId} groupId:${groupId}");

        $promptList = $this->promptRepository->findAll($open, $userId, $groupId);

        $this->logger->debug("Prompt list was viewed. open:${open} userId:${userId} groupId:${groupId}");

        return $promptList;
    }
}
