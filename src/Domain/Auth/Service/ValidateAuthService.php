<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Service\AuthService;
use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Domain\Auth\Exception\AuthTokenNotFoundException;

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

        $this->logger->info(sprintf('Auth validation successful: %s', $auth->getUserId()));

        return $auth;
    }

    private function validate($token)
    {
        if (!$token) {
            throw new AuthTokenNotFoundException();
        }

        if (!(strlen($token) % 2 == 0 && ctype_xdigit($token))) {
            throw new AuthTokenInvalidException();
        }
    }

    function getAuthorizationHeader()
    {
        $headers = null;
        if (isset($_SERVER['Authorization'])) {
            $headers = trim($_SERVER['Authorization']);
        } elseif (isset($_SERVER['HTTP_AUTHORIZATION'])) {
            $headers = trim($_SERVER['HTTP_AUTHORIZATION']);
        } elseif (function_exists('apache_request_headers')) {
            $requestHeaders = apache_request_headers();
            $requestHeaders = array_combine(
                array_map('ucwords', array_keys($requestHeaders)),
                array_values($requestHeaders),
            );
            if (isset($requestHeaders['Authorization'])) {
                $headers = trim($requestHeaders['Authorization']);
            }
        }
        return $headers;
    }

    function getBearerToken()
    {
        $headers = $this->getAuthorizationHeader();
        if (!empty($headers)) {
            if (preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
                return $matches[1];
            }
        }
        return null;
    }
}
