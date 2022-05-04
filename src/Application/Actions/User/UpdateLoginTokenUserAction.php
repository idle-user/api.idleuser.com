<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateLoginTokenUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

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
        $userId = (int) $this->resolveBodyArg('user_id');

        $loginToken = $this->updateLoginTokenUserService->run($userId);

        return $this->respondWithData($loginToken);
    }
}
