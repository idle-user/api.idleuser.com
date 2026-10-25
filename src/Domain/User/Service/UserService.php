<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Repository\UserRepository;
use Psr\Log\LoggerInterface;

abstract class UserService
{
    protected UserRepository $userRepository;
    protected LoggerInterface $logger;

    public function __construct(LoggerInterface $logger, UserRepository $userRepository)
    {
        $this->logger = $logger;
        $this->userRepository = $userRepository;
    }
}
