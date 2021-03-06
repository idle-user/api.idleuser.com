<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateChatangoIdUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class UpdateChatangoIdUserAction extends Action
{
    private $updateChatangoIdUserService;

    public function __construct(LoggerInterface $logger, UpdateChatangoIdUserService $updateChatangoIdUserService)
    {
        parent::__construct($logger);
        $this->updateChatangoIdUserService = $updateChatangoIdUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');
        $chatangoId = (string) $this->resolveBodyArg('chatango_id');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $user = $this->updateChatangoIdUserService->run($userId, $chatangoId);

        return $this->respondWithData($user);
    }
}
