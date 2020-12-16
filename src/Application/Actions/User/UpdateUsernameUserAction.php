<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateUsernameUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $username = (string) $this->resolvePost('username');

        $user = $this->updateUsernameUserService->run($userId, $username);

        return $this->respondWithData($user);
    }
}