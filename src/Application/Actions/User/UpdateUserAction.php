<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\UpdateUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class UpdateUserAction extends Action
{
    private $updateUserService;

    public function __construct(LoggerInterface $logger, UpdateUserService $updateUserService)
    {
        parent::__construct($logger);
        $this->updateUserService = $updateUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');

        $user = $this->updateUserService->run($userId, $this->request->getParsedBody());

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
