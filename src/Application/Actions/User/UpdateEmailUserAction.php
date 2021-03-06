<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateEmailUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class UpdateEmailUserAction extends Action
{
    private $updateEmailUserService;

    public function __construct(LoggerInterface $logger, UpdateEmailUserService $updateEmailUserService)
    {
        parent::__construct($logger);
        $this->updateEmailUserService = $updateEmailUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');
        $email = (string) $this->resolveBodyArg('email');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $user = $this->updateEmailUserService->run($userId, $email);

        return $this->respondWithData($user);
    }
}
