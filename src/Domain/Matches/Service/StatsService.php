<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

abstract class StatsService
{
    protected $statsRepository;

    public function __construct(LoggerInterface $logger, StatsRepository $statsRepository)
    {
        $this->logger = $logger;
        $this->statsRepository = $statsRepository;
    }
}
