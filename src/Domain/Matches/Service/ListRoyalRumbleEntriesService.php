<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListRoyalRumbleEntriesService extends RoyalRumbleEntryService
{
    public function run($royalrumbleId)
    {
        $royalrumbleList = $this->royalRumbleEntryRepository->findByRoyalRumbleId($royalrumbleId);

        $this->logger->info("Royal Rumble `${royalrumbleId}` entry list was viewed.");

        return $royalrumbleList;
    }
}
