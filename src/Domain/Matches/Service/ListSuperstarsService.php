<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListSuperstarsService extends SuperstarService
{
    public function run()
    {
        $superstars = $this->superstarRepository->findAll();

        $this->logger->debug('Superstar list was viewed.');

        return $superstars;
    }
}
