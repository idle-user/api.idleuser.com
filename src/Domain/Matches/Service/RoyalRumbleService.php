<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\RoyalRumbleRepository;
use Psr\Log\LoggerInterface;

abstract class RoyalRumbleService
{
    protected $royalRumbleRepository;

    public function __construct(LoggerInterface $logger, RoyalRumbleRepository $royalRumbleRepository)
    {
        $this->logger = $logger;
        $this->royalRumbleRepository = $royalRumbleRepository;
    }
}
