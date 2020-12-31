<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateUsernameUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

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
        $userId = (int) $this->resolveArg('userId');
        $username = (string) $this->resolveBodyArg('username');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $user = $this->updateUsernameUserService->run($userId, $username);

        return $this->respondWithData($user);
    }
}
