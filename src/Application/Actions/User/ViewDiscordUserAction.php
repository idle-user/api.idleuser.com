<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ViewDiscordUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewDiscordUserAction extends Action
{
    private $viewDiscordUserService;

    public function __construct(LoggerInterface $logger, ViewDiscordUserService $viewDiscordUserService)
    {
        parent::__construct($logger);
        $this->viewDiscordUserService = $viewDiscordUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $discordId = (string) $this->resolveArg('discordId');

        $isSelf = $this->request->getAttribute('auth_is_self');
        $isAdmin = $this->request->getAttribute('auth_is_admin');
        $showFullDetail = $isSelf || $isAdmin;

        $user = $this->viewDiscordUserService->run($discordId, $showFullDetail);

        return $this->respondWithData($user);
    }
}
