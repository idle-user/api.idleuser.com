<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\BetCalculationRepository;
use Psr\Log\LoggerInterface;

abstract class BetCalculationService
{
    protected $betCalculationRepository;

    public function __construct(LoggerInterface $logger, BetCalculationRepository $betCalculationRepository)
    {
        $this->logger = $logger;
        $this->betCalculationRepository = $betCalculationRepository;
    }
}
