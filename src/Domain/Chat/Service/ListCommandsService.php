<?php
declare(strict_types=1);

namespace App\Domain\Chat\Service;

final class ListCommandsService extends CommandService
{
    public function run()
    {
        $commandList = $this->commandRepository->findAll();

        $this->logger->info('Chat command list was viewed.');

        return $commandList;
    }
}
