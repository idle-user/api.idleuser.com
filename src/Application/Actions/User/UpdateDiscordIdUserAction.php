<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateDiscordIdUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class UpdateDiscordIdUserAction extends Action
{
    private $updateDiscordIdUserService;

    public function __construct(LoggerInterface $logger, UpdateDiscordIdUserService $updateDiscordIdUserService)
    {
        parent::__construct($logger);
        $this->updateDiscordIdUserService = $updateDiscordIdUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');
        $discordId = (string) $this->resolveBodyArg('discord_id');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $user = $this->updateDiscordIdUserService->run($userId, $discordId);

        return $this->respondWithData($user);
    }
}
