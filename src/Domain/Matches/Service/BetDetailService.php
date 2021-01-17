<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\BetDetailRepository;
use Psr\Log\LoggerInterface;

abstract class BetDetailService
{
    protected $betDetailRepository;

    public function __construct(LoggerInterface $logger, BetDetailRepository $betDetailRepository)
    {
        $this->logger = $logger;
        $this->betDetailRepository = $betDetailRepository;
    }
}
