<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\SuperstarRepository;
use Psr\Log\LoggerInterface;

abstract class SuperstarService
{
    /**
     * @var SuperstarRepository
     */
    protected $superstarRepository;

    public function __construct(LoggerInterface $logger, SuperstarRepository $superstarRepository)
    {
        $this->logger = $logger;
        $this->superstarRepository = $superstarRepository;
    }
}
