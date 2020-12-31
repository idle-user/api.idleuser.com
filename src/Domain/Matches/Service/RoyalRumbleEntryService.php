<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\RoyalRumbleEntryRepository;
use Psr\Log\LoggerInterface;

abstract class RoyalRumbleEntryService
{
    protected $royalRumbleEntryRepository;

    public function __construct(LoggerInterface $logger, RoyalRumbleEntryRepository $royalRumbleEntryRepository)
    {
        $this->logger = $logger;
        $this->royalRumbleEntryRepository = $royalRumbleEntryRepository;
    }
}
