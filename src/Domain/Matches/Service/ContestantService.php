<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\ContestantRepository;
use Psr\Log\LoggerInterface;

abstract class ContestantService
{
    protected $contestantRepository;

    public function __construct(LoggerInterface $logger, ContestantRepository $contestantRepository)
    {
        $this->logger = $logger;
        $this->contestantRepository = $contestantRepository;
    }
}
