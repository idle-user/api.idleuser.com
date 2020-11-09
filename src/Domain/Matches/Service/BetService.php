<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\BetRepository;
use Psr\Log\LoggerInterface;

abstract class BetService
{
    protected $betRepository;

    public function __construct(LoggerInterface $logger, BetRepository $betRepository)
    {
        $this->logger = $logger;
        $this->betRepository = $betRepository;
    }
}
