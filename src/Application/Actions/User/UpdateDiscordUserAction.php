<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateDiscordUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class UpdateDiscordUserAction extends Action
{
    private $updateDiscordUserService;

    public function __construct(LoggerInterface $logger, UpdateDiscordUserService $updateDiscordUserService)
    {
        parent::__construct($logger);
        $this->updateDiscordUserService = $updateDiscordUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    { 
        // TODO
        $username = $this->resolvePost('username');

        $user = $this->updateDiscordUserService->run($this->request->getParsedBody());

        return $this->respondWithData($user);
    }

}
