<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewEventService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewEventAction extends Action
{
    private $viewEventService;

    public function __construct(LoggerInterface $logger, ViewEventService $viewEventService)
    {
        parent::__construct($logger);
        $this->viewEventService = $viewEventService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $eventId = (int)$this->resolveArg('eventId');

        $event = $this->viewEventService->run($eventId);

        return $this->respondWithData($event);
    }
}
