<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\RegisterUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class RegisterUserAction extends Action
{
    private $registerUserService;

    public function __construct(LoggerInterface $logger, RegisterUserService $registerUserService)
    {
        parent::__construct($logger);
        $this->registerUserService = $registerUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $username = $this->resolveBodyArg('username');

        $this->logger->info("User `${username}` register attempt.");

        $user = $this->registerUserService->run($this->request->getParsedBody());

        return $this->respondWithData($user);
    }
}
