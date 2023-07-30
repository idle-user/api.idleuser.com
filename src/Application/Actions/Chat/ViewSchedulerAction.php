<?php
declare(strict_types=1);

namespace App\Application\Actions\Chat;

use App\Application\Actions\Action;
use App\Domain\Chat\Service\ViewSchedulerService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewSchedulerAction extends Action
{
    private $viewSchedulerService;

    public function __construct(LoggerInterface $logger, ViewSchedulerService $viewSchedulerService)
    {
        parent::__construct($logger);
        $this->viewSchedulerService = $viewSchedulerService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $schedulerId = (int)$this->resolveArg('schedulerId');

        $scheduler = $this->viewSchedulerService->run($schedulerId);

        return $this->respondWithData($scheduler);
    }
}
