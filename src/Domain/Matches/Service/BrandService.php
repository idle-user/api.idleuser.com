<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\BrandRepository;
use Psr\Log\LoggerInterface;

abstract class BrandService
{
    protected $brandRepository;

    public function __construct(LoggerInterface $logger, BrandRepository $brandRepository)
    {
        $this->logger = $logger;
        $this->brandRepository = $brandRepository;
    }
}
