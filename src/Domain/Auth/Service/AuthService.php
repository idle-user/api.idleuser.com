<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Repository\AuthRepository;
use App\Domain\Auth\Exception\AuthTokenNotFoundException;
use Psr\Log\LoggerInterface;

final class AuthService
{

    /**
     * @var AuthRepository
     */
    protected $authRepository;

    public function __construct(LoggerInterface $logger, AuthRepository $authRepository)
    {
        $this->logger = $logger;
        $this->authRepository = $authRepository;
    }

    public function run(array $data)
    {
        $this->validate($data);

        $auth = $this->authRepository->findByAuthToken($data['auth_token']);

        if($auth->isAuthExpired()){
            throw new AuthTokenExpiredException();
        }

        $this->logger->info(sprintf('Auth request successful: %s', $auth->getUserId()));

        return $auth;
    }

    private function validate(array $data)
    {
        $errors = [];

        if (empty($data['auth_token'])) {
            $errors['auth_token'] = 'Input required';
        }

        if ($errors) {
            throw new AuthTokenNotFoundException();
        }
    }
}
