<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\SeasonRepository;
use Psr\Log\LoggerInterface;

abstract class SeasonService
{
    protected SeasonRepository $seasonRepository;
    protected LoggerInterface $logger;

    public function __construct(LoggerInterface $logger, SeasonRepository $seasonRepository)
    {
        $this->logger = $logger;
        $this->seasonRepository = $seasonRepository;
    }
}
