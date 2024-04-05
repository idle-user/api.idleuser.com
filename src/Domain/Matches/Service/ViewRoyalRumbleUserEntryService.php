<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewRoyalRumbleUserEntryService extends RoyalRumbleEntryService
{
    public function run(int $royalrumbleId, int $userId)
    {
        $royalRumbleEntry = $this->royalRumbleEntryRepository->findByRoyalRumbleIdUserId($royalrumbleId, $userId);

        $this->logger->debug("Royal Rumble `${royalrumbleId}` entry user_id `${userId}` was viewed.");

        return $royalRumbleEntry;
    }
}
