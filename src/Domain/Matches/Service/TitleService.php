<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\TitleRepository;
use Psr\Log\LoggerInterface;

abstract class TitleService
{
    protected $titleRepository;

    public function __construct(LoggerInterface $logger, TitleRepository $titleRepository)
    {
        $this->logger = $logger;
        $this->titleRepository = $titleRepository;
    }
}
