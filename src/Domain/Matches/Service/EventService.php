<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\EventRepository;
use Psr\Log\LoggerInterface;

abstract class EventService
{
    protected EventRepository $eventRepository;
    protected LoggerInterface $logger;

    public function __construct(LoggerInterface $logger, EventRepository $eventRepository)
    {
        $this->logger = $logger;
        $this->eventRepository = $eventRepository;
    }
}
