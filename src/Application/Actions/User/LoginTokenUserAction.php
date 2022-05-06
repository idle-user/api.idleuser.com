<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\AuthTokenAuthService;
use App\Domain\User\Service\LoginTokenUserService;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class LoginTokenUserAction extends Action
{
    private $loginTokenUserService;
    private $authTokenAuthService;

    public function __construct(LoggerInterface $logger, LoginTokenUserService $loginTokenUserService, AuthTokenAuthService $authTokenAuthService)
    {
        parent::__construct($logger);
        $this->loginTokenUserService = $loginTokenUserService;
        $this->authTokenAuthService = $authTokenAuthService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $user = $this->loginTokenUserService->run($this->queryParams);
        $auth = $this->authTokenAuthService->run($user);

        $user_auth = array_merge($user->jsonSerialize(), $auth->jsonSerializeToken());

        return $this->respondWithData($user_auth);
    }
}
