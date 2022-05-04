<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\RegisterUserService;
use App\Application\Actions\Action;
use App\Domain\Auth\Service\AuthTokenAuthService;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class RegisterUserAction extends Action
{
    private $registerUserService;
    private $authTokenAuthService;

    public function __construct(LoggerInterface $logger, RegisterUserService $registerUserService, AuthTokenAuthService $authTokenAuthService)
    {
        parent::__construct($logger);
        $this->registerUserService = $registerUserService;
        $this->authTokenAuthService = $authTokenAuthService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $username = $this->resolveBodyArg('username');

        $this->logger->info("User `${username}` register attempt.");

        $user = $this->registerUserService->run($this->request->getParsedBody());
        $auth = $this->authTokenAuthService->run($user);

        $user_auth = array_merge($user->jsonSerialize(), $auth->jsonSerializeToken());

        return $this->respondWithData($user_auth);
    }
}
