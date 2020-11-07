<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\MatchRepository;
use Psr\Log\LoggerInterface;

abstract class MatchService
{
    /**
     * @var MatchRepository
     */
    protected $matchRepository;

    public function __construct(LoggerInterface $logger, MatchRepository $matchRepository)
    {
        $this->logger = $logger;
        $this->matchRepository = $matchRepository;
    }
}
