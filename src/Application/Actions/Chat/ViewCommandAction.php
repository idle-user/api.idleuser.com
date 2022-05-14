<?php
declare(strict_types=1);

namespace App\Application\Actions\Chat;

use App\Application\Actions\Action;
use App\Domain\Chat\Service\ViewCommandService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
        $commandName = (string)$this->resolveArg('command');

        $command = $this->viewCommandService->run($commandName);

        return $this->respondWithData($command);
    }
}
