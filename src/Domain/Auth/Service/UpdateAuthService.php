<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\User\Data\User;
use App\Exception\ValidationException;

final class UpdateAuthService extends AuthService
{
    public function run(User $user)
    {
        $this->validate($user);

        $authToken = $this->authRepository->updateAuthToken($user->getId());

        $auth = $this->authRepository->findByAuthToken($authToken);

        $this->logger->info(sprintf('Auth token update successful: %s', $auth->getUserId()));

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
