<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListRoyalRumblesEntriesService extends RoyalRumbleEntryService
{
    public function run()
    {
        $royalrumbleList = $this->royalRumbleEntryRepository->findAll();

        $this->logger->debug('Royal Rumble entry list was viewed.');

        return $royalrumbleList;
    }
}
