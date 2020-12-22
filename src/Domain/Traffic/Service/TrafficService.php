<?php
declare(strict_types=1);

namespace App\Domain\Traffic\Service;

use App\Domain\Traffic\Repository\TrafficRepository;
use Psr\Log\LoggerInterface;

abstract class TrafficService
{
    protected $trafficRepository;

    public function __construct(LoggerInterface $logger, TrafficRepository $trafficRepository)
    {
        $this->logger = $logger;
        $this->trafficRepository = $trafficRepository;
    }
}
