<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ViewDiscordUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewDiscordUserAction extends Action
{
    private $ViewDiscordUserservice;

    public function __construct(LoggerInterface $logger, ViewDiscordUserService $ViewDiscordUserservice)
    {
        parent::__construct($logger);
        $this->ViewDiscordUserservice = $ViewDiscordUserservice;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $discordId = (string) $this->resolveArg('discordId');

        $user = $this->ViewDiscordUserservice->run($discordId);

        return $this->respondWithData($user);
    }
}
