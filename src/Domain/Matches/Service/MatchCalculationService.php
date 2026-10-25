<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\MatchCalculationRepository;
use Psr\Log\LoggerInterface;

abstract class MatchCalculationService
{
    protected MatchCalculationRepository $matchCalculationRepository;
    protected LoggerInterface $logger;

    public function __construct(LoggerInterface $logger, MatchCalculationRepository $matchCalculationRepository)
    {
        $this->logger = $logger;
        $this->matchCalculationRepository = $matchCalculationRepository;
    }
}
