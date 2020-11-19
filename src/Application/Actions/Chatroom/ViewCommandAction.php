<?php
declare(strict_types=1);

namespace App\Application\Actions\Chatroom;

use App\Domain\Chatroom\Service\ViewCommandService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewCommandAction extends Action
{
    private $viewCommandService;

    public function __construct(LoggerInterface $logger, ViewCommandService $viewCommandService)
    {
        parent::__construct($logger);
        $this->viewCommandService = $viewCommandService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $commandName = (string) $this->resolveArg('command');

        $command = $this->viewCommandService->run($commandName);

        return $this->respondWithData($command);
    }
}
