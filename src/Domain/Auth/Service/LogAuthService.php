<?php

declare(strict_types=1);

namespace App\Domain\Auth\Service;

use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Repository\AuthRepository;
use Psr\Log\LoggerInterface;

final class LogAuthService
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
