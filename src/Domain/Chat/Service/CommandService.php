<?php
declare(strict_types=1);

namespace App\Domain\Chat\Service;

use App\Domain\Chat\Repository\CommandRepository;
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
