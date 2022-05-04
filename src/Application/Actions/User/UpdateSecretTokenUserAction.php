<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateSecretTokenUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class UpdateSecretTokenUserAction extends Action
{
    private $updateSecretTokenUserService;

    public function __construct(LoggerInterface $logger, UpdateSecretTokenUserService $updateSecretTokenUserService)
    {
        parent::__construct($logger);
        $this->updateSecretTokenUserService = $updateSecretTokenUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveBodyArg('user_id');

        $secretToken = $this->updateSecretTokenUserService->run($userId);

        return $this->respondWithData($secretToken);
    }
}
