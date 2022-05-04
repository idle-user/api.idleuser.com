<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Exception\AuthTokenNotFoundException;
use App\Domain\Auth\Service\AuthService;
use App\Exception\ValidationException;
use App\Domain\User\Data\User;

final class AuthTokenAuthService extends AuthService
{
    public function run(User $user)
    {
        $this->validate($user);

        try {
            $auth = $this->authRepository->findByUserId($user->getId());
        } catch (AuthTokenNotFoundException $e){
            $authToken = $this->authRepository->createAuthToken($user->getId(), $user->getAccessLevel());
            $auth = $this->authRepository->findByAuthToken($authToken);
        }

        $this->logger->info(sprintf('Auth retrieval successful: %s', $auth->getUserId()));

        return $auth;
    }

    private function validate(User $user)
    {
        $errors = [];

        if (empty($user->getId())) {
            $errors['user'] = 'Input required';
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
