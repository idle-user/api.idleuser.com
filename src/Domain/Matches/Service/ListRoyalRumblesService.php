<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListRoyalRumblesService extends RoyalRumbleService
{
    public function run()
    {
        $royalrumbleList = $this->royalRumbleRepository->findAll();

        $this->logger->debug('Royal Rumble list was viewed.');

        return $royalrumbleList;
    }
}
