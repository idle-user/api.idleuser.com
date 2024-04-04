<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListEventsService extends EventService
{
    public function run()
    {
        $eventList = $this->eventRepository->findAll();

        $this->logger->debug('Event list was viewed.');

        return $eventList;
    }
}
