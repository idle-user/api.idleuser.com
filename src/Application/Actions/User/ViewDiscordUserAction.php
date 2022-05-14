<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\ViewDiscordUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
        $discordId = (string)$this->resolveArg('discordId');

        $user = $this->viewDiscordUserService->run($discordId);

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
