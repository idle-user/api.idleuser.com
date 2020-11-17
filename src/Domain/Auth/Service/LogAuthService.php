<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Service\AuthService;

final class LogAuthService extends AuthService
{
    public function run(array $data)
    {
        $authInfo = $data[0];
        $request = $data[1];
        $userId = $authInfo->getUserId();
        $requestMethod = $request->getMethod();
        $requestPath = $request->getUri()->getPath();
        $requestText = "${requestMethod} ${requestPath}";

        $ret = $this->authRepository->addTraffic($userId, $requestText);

        return $ret;
    }
}
