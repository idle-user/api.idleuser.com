<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\SeasonRepository;
use Psr\Log\LoggerInterface;

abstract class SeasonService
{
    protected $seasonRepository;

    public function __construct(LoggerInterface $logger, SeasonRepository $seasonRepository)
    {
        $this->logger = $logger;
        $this->seasonRepository = $seasonRepository;
    }
}
