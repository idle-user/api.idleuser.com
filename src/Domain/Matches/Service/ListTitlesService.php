<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListTitlesService extends TitleService
{
    public function run()
    {
        $titleList = $this->titleRepository->findAll();

        $this->logger->info('Title list was viewed.');

        return $titleList;
    }
}
