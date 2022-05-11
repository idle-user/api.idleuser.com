<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateSecretUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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

        $user = $this->updateSecretUserService->run($userId, $this->request->getParsedBody());

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
