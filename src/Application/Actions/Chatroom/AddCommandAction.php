<?php
declare(strict_types=1);

namespace App\Application\Actions\Chatroom;

use App\Domain\Chatroom\Service\AddCommandService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class AddCommandAction extends Action
{
    private $addCommandService;

    public function __construct(LoggerInterface $logger, AddCommandService $addCommandService)
    {
        parent::__construct($logger);
        $this->addCommandService = $addCommandService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $commandName = $this->resolvePost('command');

        $this->logger->info("Add chatroom command `${commandName}` attempt.");

        $command = $this->addCommandService->run($this->request->getParsedBody());

        return $this->respondWithData($command);
    }
}
