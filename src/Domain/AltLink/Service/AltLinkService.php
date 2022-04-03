<?php
declare(strict_types=1);

namespace App\Domain\AltLink\Service;

use App\Domain\AltLink\Repository\AltLinkRepository;
use Psr\Log\LoggerInterface;

abstract class AltLinkService
{
    protected $altLinkRepository;

    public function __construct(LoggerInterface $logger, AltLinkRepository $altLinkRepository)
    {
        $this->logger = $logger;
        $this->altLinkRepository = $altLinkRepository;
    }
}
