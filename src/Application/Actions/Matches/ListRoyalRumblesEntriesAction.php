<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListRoyalRumblesEntriesService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListRoyalRumblesEntriesAction extends Action
{
    private $listRoyalRumbleEntriesService;

    public function __construct(LoggerInterface $logger, ListRoyalRumblesEntriesService $listRoyalRumblesEntriesService)
    {
        parent::__construct($logger);
        $this->listRoyalRumblesEntriesService = $listRoyalRumblesEntriesService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $royalrumbleEntriesList = $this->listRoyalRumblesEntriesService->run();

        return $this->respondWithData($royalrumbleEntriesList);
    }
}
