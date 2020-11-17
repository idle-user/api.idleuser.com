<?php
declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Repository\AuthRepository;
use Psr\Log\LoggerInterface;

abstract class AuthService
{
    protected $authRepository;

    public function __construct(LoggerInterface $logger, AuthRepository $authRepository)
    {
        $this->logger = $logger;
        $this->authRepository = $authRepository;
    }
}
