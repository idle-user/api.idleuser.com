<?php
declare(strict_types=1);

namespace App\Application\Actions\Auth;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\UpdateAuthService;
use App\Domain\User\Service\ViewUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class OverrideAuthAction extends Action
{
    protected $updateAuthService;
    protected $viewUserService;

    public function __construct(
        LoggerInterface   $logger,
        UpdateAuthService $updateAuthService,
        ViewUserService   $viewUserService
    )
    {
        parent::__construct($logger);
        $this->updateAuthService = $updateAuthService;
        $this->viewUserService = $viewUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $this->logger->info('Override Auth attempt.');

        $userId = (int)$this->resolveArg('userId');

        $user = $this->viewUserService->run($userId);

        $auth = $this->updateAuthService->run($user);

        return $this->respondWithData($auth);
    }
}
