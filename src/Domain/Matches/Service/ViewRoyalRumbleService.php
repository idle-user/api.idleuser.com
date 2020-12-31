<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewRoyalRumbleService extends RoyalRumbleService
{
    public function run(int $royalrumbleId)
    {
        $royalRumble = $this->royalRumbleRepository->findById($royalrumbleId);

        $this->logger->info("Royal Rumble `${royalrumbleId}` was viewed.");

        return $royalRumble;
    }
}
