<?php
declare(strict_types=1);

namespace App\Domain\Chat\Service;

use App\Domain\Chat\Repository\SchedulerRepository;
use Psr\Log\LoggerInterface;

abstract class SchedulerService
{
    protected $schedulerRepository;

    public function __construct(LoggerInterface $logger, SchedulerRepository $schedulerRepository)
    {
        $this->logger = $logger;
        $this->schedulerRepository = $schedulerRepository;
    }
}
