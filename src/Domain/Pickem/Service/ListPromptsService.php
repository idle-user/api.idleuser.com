<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListPromptsService extends PickemService
{
    public function run(bool $open)
    {
        if ($open) {
            $promptList = $this->promptRepository->findAllOpen();
        } else {
            $promptList = $this->promptRepository->findAll();
        }

        $this->logger->debug('Prompt list was viewed.');

        return $promptList;
    }
}
