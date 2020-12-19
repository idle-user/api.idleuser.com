<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $userId = (int) $this->resolveArg('userId');

        $user = $this->updateUserService->run($userId, $this->request->getParsedBody());

        return $this->respondWithData($user);
    }
}
