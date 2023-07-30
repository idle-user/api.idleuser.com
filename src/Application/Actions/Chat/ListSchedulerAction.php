<?php
declare(strict_types=1);

namespace App\Application\Actions\Chat;

use App\Application\Actions\Action;
use App\Domain\Chat\Service\ListSchedulerService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListSchedulerAction extends Action
{
    private $listSchedulerService;

    public function __construct(LoggerInterface $logger, ListSchedulerService $listSchedulerService)
    {
        parent::__construct($logger);
        $this->listSchedulerService = $listSchedulerService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $schedulerList = $this->listSchedulerService->run();

        return $this->respondWithData($schedulerList);
    }
}
