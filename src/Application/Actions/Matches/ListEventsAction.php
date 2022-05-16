<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListEventsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListEventsAction extends Action
{
    private $listEventsService;

    public function __construct(LoggerInterface $logger, ListEventsService $listEventsService)
    {
        parent::__construct($logger);
        $this->listEventsService = $listEventsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $eventList = $this->listEventsService->run();

        return $this->respondWithData($eventList);
    }
}
