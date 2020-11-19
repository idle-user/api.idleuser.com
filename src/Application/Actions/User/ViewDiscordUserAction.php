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

        $user = $this->viewDiscordUserService->run($discordId);

        return $this->respondWithData($user);
    }
}
