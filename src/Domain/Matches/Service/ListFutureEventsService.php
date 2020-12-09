<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListFutureEventsService extends EventService
{
    public function run()
    {
        $futureEventList = $this->eventRepository->findFuture();

        $this->logger->info('Future Event list was viewed.');

        return $futureEventList;
    }
}
