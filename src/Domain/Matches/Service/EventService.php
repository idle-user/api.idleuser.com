<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\EventRepository;
use Psr\Log\LoggerInterface;

abstract class EventService
{
    protected $eventRepository;

    public function __construct(LoggerInterface $logger, EventRepository $eventRepository)
    {
        $this->logger = $logger;
        $this->eventRepository = $eventRepository;
    }
}
