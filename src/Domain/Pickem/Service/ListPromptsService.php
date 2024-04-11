<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListPromptsService extends PickemService
{
    public function run(bool $open, ?int $user_id = null, ?string $group_id = null)
    {
        $this->logger->debug("View Prompt list attempt. open:${open} user_id:${user_id} group_id:${group_id}");

        $promptList = $this->promptRepository->findAll($open, $user_id, $group_id);

        $this->logger->debug("Prompt list was viewed. open:${open} user_id:${user_id} group_id:${group_id}");

        return $promptList;
    }
}
