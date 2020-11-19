<?php
declare(strict_types=1);

namespace App\Domain\Chatroom\Service;

final class ViewCommandService extends CommandService
{
    public function run(string $keyword)
    {
        $command = $this->commandRepository->findByCommand($keyword);

        $this->logger->info("Chatroom command `${keyword}` was viewed.");

        return $command;
    }
}
