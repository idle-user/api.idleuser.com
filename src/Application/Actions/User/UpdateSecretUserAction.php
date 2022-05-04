<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateSecretUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class UpdateSecretUserAction extends Action
{
    private $updateSecretUserService;

    public function __construct(LoggerInterface $logger, UpdateSecretUserService $updateSecretUserService)
    {
        parent::__construct($logger);
        $this->updateSecretUserService = $updateSecretUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');

        $this->logger->info("User `${userId}` Update Secret attempt.");

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $user = $this->updateSecretUserService->run($userId, $this->request->getParsedBody());

        return $this->respondWithData($user);
    }
}
