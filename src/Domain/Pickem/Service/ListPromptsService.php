<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListPromptsService extends PickemService
{
    public function run(bool $open, ?string $group_id = null)
    {
        $this->logger->debug("View Prompt list attempt. open:${open} group_id:${group_id}");

        if (is_null($group_id)) {
            if ($open) {
                $promptList = $this->promptRepository->findAllOpen();
            } else {
                $promptList = $this->promptRepository->findAll();
            }
        } else {
            if ($open) {
                $promptList = $this->promptRepository->findAllOpenByGroup($group_id);
            } else {
                $promptList = $this->promptRepository->findAllByGroup($group_id);
            }
        }

        $this->logger->debug("Prompt list was viewed. open:${open} group_id:${group_id}");

        return $promptList;
    }
}
