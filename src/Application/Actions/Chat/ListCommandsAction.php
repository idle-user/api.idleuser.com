<?php
declare(strict_types=1);

namespace App\Application\Actions\Chat;

use App\Application\Actions\Action;
use App\Domain\Chat\Service\ListCommandsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
