<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewTitleService extends TitleService
{
    public function run(int $titleId)
    {
        $title = $this->titleRepository->findById($titleId);

        $this->logger->debug("Title id `${titleId}` was viewed.");

        return $title;
    }
}
