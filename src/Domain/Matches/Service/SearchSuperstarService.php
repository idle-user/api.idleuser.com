<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class SearchSuperstarService extends SuperstarService
{
    public function run(string $keyword)
    {
        $superstar = $this->superstarRepository->searchByName("%${keyword}%");

        $this->logger->info("Superstar search list `${keyword}` was viewed.");

        return $superstar;
    }
}
