<?php
declare(strict_types=1);

namespace App\Application\Actions\Chatroom;

use App\Domain\Chatroom\Service\ListCommandsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListCommandsAction extends Action
{
    private $listCommandsService;

    public function __construct(LoggerInterface $logger, ListCommandsService $listCommandsService)
    {
        parent::__construct($logger);
        $this->listCommandsService = $listCommandsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $commandList = $this->listCommandsService->run();

        return $this->respondWithData($commandList);
    }
}
