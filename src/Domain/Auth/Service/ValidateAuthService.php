<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Exception\ValidationException;

final class ValidateAuthService extends AuthService
{
    public function run()
    {
        $token = $this->getBearerToken();

        $this->validate($token);

        $auth = $this->authRepository->findByAuthToken($token);

        if ($auth->isAuthExpired()) {
            throw new AuthTokenExpiredException();
        }

        $this->logger->debug(sprintf('Auth validation successful: %s', $auth->getUserId()));

        return $auth;
    }

    private function validate($token)
    {
        if (!$token) {
            throw new ValidationException('Authorization Token is required');
        }

        if (!ctype_xdigit($token)) {
            throw new AuthTokenInvalidException();
        }
    }

    public function getBearerToken(): ?string
    {
        $headers = $this->getAuthorizationHeaders();

        if (!empty($headers)) {
            foreach ($headers as $authHeader) {
                if (preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
                    return $matches[1];
                }
            }
        }
        return null;
    }

    private function getAuthorizationHeaders(): array
    {
        $headers = [];
        if (isset($_SERVER['Authorization'])) {
            $headers[] = trim($_SERVER['Authorization']);
        }
        if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
            $headers[] = trim($_SERVER['HTTP_AUTHORIZATION']);
        }
        if (isset($_SERVER['HTTP_X_AUTH_TOKEN'])) {
            $headers[] = trim($_SERVER['HTTP_X_AUTH_TOKEN']);
        }
        if (function_exists('apache_request_headers')) {
            $requestHeaders = apache_request_headers();
            $requestHeaders = array_combine(
                array_map('ucwords', array_keys($requestHeaders)),
                array_values($requestHeaders),
            );
            if (isset($requestHeaders['Authorization'])) {
                $headers[] = trim($requestHeaders['Authorization']);
            }
            if (isset($requestHeaders['X-Auth-Token'])) {
                $headers[] = trim($requestHeaders['X-Auth-Token']);
            }
        }
        return $headers;
    }
}
