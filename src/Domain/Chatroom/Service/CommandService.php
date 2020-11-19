<?php
declare(strict_types=1);

namespace App\Domain\Chatroom\Service;

use App\Domain\Chatroom\Repository\CommandRepository;
use Psr\Log\LoggerInterface;

abstract class CommandService
{
    protected $commandRepository;

    public function __construct(LoggerInterface $logger, CommandRepository $commandRepository)
    {
        $this->logger = $logger;
        $this->commandRepository = $commandRepository;
    }
}
