<?php
declare(strict_types=1);

namespace App\Application\Actions\Chat;

use App\Application\Actions\Action;
use App\Domain\Chat\Service\AddCommandService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
        $commandName = $this->resolveBodyArg('command');

        $this->logger->debug("Add chat command `${commandName}` attempt.");

        $command = $this->addCommandService->run($this->request->getParsedBody());

        return $this->respondWithData($command);
    }
}
