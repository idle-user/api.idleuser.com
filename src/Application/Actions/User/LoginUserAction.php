<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\LoginUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class LoginUserAction extends Action
{
    private $loginUserservice;

    public function __construct(LoggerInterface $logger, LoginUserService $loginUserservice)
    {
        parent::__construct($logger);
        $this->loginUserservice = $loginUserservice;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $username = $this->resolvePost('username');

        $this->logger->info("User `${username}` login attempt.");

        $user = $this->loginUserservice->run($this->request->getParsedBody());

        return $this->respondWithData($user);
    }
}
