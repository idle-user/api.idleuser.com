<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListFutureEventsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListFutureEventsAction extends Action
{
    private $listFutureEventsService;

    public function __construct(LoggerInterface $logger, ListFutureEventsService $listFutureEventsService)
    {
        parent::__construct($logger);
        $this->listFutureEventsService = $listFutureEventsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $futureEventList = $this->listFutureEventsService->run();

        return $this->respondWithData($futureEventList);
    }
}
