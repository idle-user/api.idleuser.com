<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Service\AuthService;
use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Domain\Auth\Exception\AuthTokenNotFoundException;

final class ValidateAuthService extends AuthService
{
    public function run(array $data)
    {
        $this->validate($data);

        $auth = $this->authRepository->findByAuthToken($data['auth_token']);

        if ($auth->isAuthExpired()) {
            throw new AuthTokenExpiredException();
        }

        $this->logger->info(sprintf('Auth request successful: %s', $auth->getUserId()));

        return $auth;
    }

    private function validate(array $data)
    {
        if (!isset($data['auth_token'])) {
            throw new AuthTokenNotFoundException();
        }

        if (!(strlen($data['auth_token']) % 2 == 0 && ctype_xdigit($data['auth_token']))) {
            throw new AuthTokenInvalidException();
        }
    }
}
