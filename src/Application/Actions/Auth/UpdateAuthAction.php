<?php
declare(strict_types=1);

namespace App\Application\Actions\Auth;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\UpdateAuthService;
use App\Domain\User\Service\LoginUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class UpdateAuthAction extends Action
{
    protected $updateAuthService;
    protected $loginUserService;

    public function __construct(
        LoggerInterface   $logger,
        UpdateAuthService $updateAuthService,
        LoginUserService  $loginUserService
    )
    {
        parent::__construct($logger);
        $this->updateAuthService = $updateAuthService;
        $this->loginUserService = $loginUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $this->logger->info('Auth update attempt.');

        $user = $this->loginUserService->run($this->request->getParsedBody());

        $auth = $this->updateAuthService->run($user);

        return $this->respondWithData($auth);
    }
}
