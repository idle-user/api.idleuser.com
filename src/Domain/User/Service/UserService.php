<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Repository\UserRepository;
use Psr\Log\LoggerInterface;

abstract class UserService
{
    /**
     * @var UserRepository
     */
    protected $userRepository;

    public function __construct(LoggerInterface $logger, UserRepository $userRepository)
    {
        $this->logger = $logger;
        $this->userRepository = $userRepository;
    }
}
