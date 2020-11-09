<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\MatchTypeRepository;
use Psr\Log\LoggerInterface;

abstract class MatchTypeService
{
    protected $matchTypeRepository;

    public function __construct(LoggerInterface $logger, MatchTypeRepository $matchTypeRepository)
    {
        $this->logger = $logger;
        $this->matchTypeRepository = $matchTypeRepository;
    }
}
