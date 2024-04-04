<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewEventService extends EventService
{
    public function run(int $eventId)
    {
        $event = $this->eventRepository->findById($eventId);

        $this->logger->debug("Event id `${eventId}` was viewed.");

        return $event;
    }
}
