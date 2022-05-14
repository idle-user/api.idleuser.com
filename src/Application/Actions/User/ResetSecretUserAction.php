<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\ResetSecretUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ResetSecretUserAction extends Action
{
    private $resetSecretUserAction;

    public function __construct(LoggerInterface $logger, ResetSecretUserService $resetSecretUserAction)
    {
        parent::__construct($logger);
        $this->resetSecretUserAction = $resetSecretUserAction;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $this->logger->info("User Reset Secret attempt.");

        $user = $this->resetSecretUserAction->run($this->request->getParsedBody());

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
