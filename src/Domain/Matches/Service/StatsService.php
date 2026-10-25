<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

abstract class StatsService
{
    protected StatsRepository $statsRepository;
    protected LoggerInterface $logger;

    public function __construct(LoggerInterface $logger, StatsRepository $statsRepository)
    {
        $this->logger = $logger;
        $this->statsRepository = $statsRepository;
    }
}
