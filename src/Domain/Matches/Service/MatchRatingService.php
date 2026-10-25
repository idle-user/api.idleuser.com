<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\MatchRatingRepository;
use Psr\Log\LoggerInterface;

abstract class MatchRatingService
{
    protected MatchRatingRepository $matchRatingRepository;
    protected LoggerInterface $logger;

    public function __construct(LoggerInterface $logger, MatchRatingRepository $matchRatingRepository)
    {
        $this->logger = $logger;
        $this->matchRatingRepository = $matchRatingRepository;
    }
}
