<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\LoginUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class LoginUserAction extends Action
{
    private $loginUserService;

    public function __construct(LoggerInterface $logger, LoginUserService $loginUserService)
    {
        parent::__construct($logger);
        $this->loginUserService = $loginUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $username = $this->resolveBodyArg('username');

        $this->logger->info("User `${username}` login attempt.");

        $user = $this->loginUserService->run($this->request->getParsedBody());

        return $this->respondWithData($user);
    }
}
