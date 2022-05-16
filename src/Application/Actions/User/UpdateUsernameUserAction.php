<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\UpdateUsernameUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class UpdateUsernameUserAction extends Action
{
    private $updateUsernameUserService;

    public function __construct(LoggerInterface $logger, UpdateUsernameUserService $updateUsernameUserService)
    {
        parent::__construct($logger);
        $this->updateUsernameUserService = $updateUsernameUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');
        $username = (string)$this->resolveBodyArg('username');

        $user = $this->updateUsernameUserService->run($userId, $username);

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
