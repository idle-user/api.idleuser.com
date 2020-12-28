<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateLoginTokenUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class UpdateLoginTokenUserAction extends Action
{
    private $updateLoginTokenUserService;

    public function __construct(LoggerInterface $logger, UpdateLoginTokenUserService $updateLoginTokenUserService)
    {
        parent::__construct($logger);
        $this->updateLoginTokenUserService = $updateLoginTokenUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $user_id = (int) $this->resolveBodyArg('user_id');

        $this->logger->info("Login Token for user `${user_id}`.");

        $loginToken = $this->updateLoginTokenUserService->run($user_id);

        return $this->respondWithData($loginToken);
    }
}
