<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewEventService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $eventId = (int) $this->resolveArg('id');

        $event = $this->viewEventService->run($eventId);

        return $this->respondWithData($event);
    }
}
