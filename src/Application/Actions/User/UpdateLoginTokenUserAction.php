<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\UpdateLoginTokenUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class UpdateLoginTokenUserAction extends Action
{
    private $updateLoginTokenUserService;

    public function __construct(LoggerInterface $logger, UpdateLoginTokenUserService $updateLoginTokenUserService)
    {
        parent::__construct($logger);
        $this->updateLoginTokenUserService = $updateLoginTokenUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');

        $loginToken = $this->updateLoginTokenUserService->run($userId);

        return $this->respondWithData($loginToken);
    }
}
