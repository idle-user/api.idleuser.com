<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\LoginUserService;
use App\Application\Actions\Action;
use App\Domain\Auth\Service\AuthTokenAuthService;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class LoginUserAction extends Action
{
    private $loginUserService;
    private $authTokenAuthService;

    public function __construct(LoggerInterface $logger, LoginUserService $loginUserService, AuthTokenAuthService $authTokenAuthService)
    {
        parent::__construct($logger);
        $this->loginUserService = $loginUserService;
        $this->authTokenAuthService = $authTokenAuthService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $username = $this->resolveBodyArg('username');

        $this->logger->info("User `${username}` login attempt.");

        $user = $this->loginUserService->run($this->request->getParsedBody());
        $auth = $this->authTokenAuthService->run($user);

        $user_auth = array_merge($user->jsonSerialize(), $auth->jsonSerializeToken());

        return $this->respondWithData($user_auth);
    }
}
