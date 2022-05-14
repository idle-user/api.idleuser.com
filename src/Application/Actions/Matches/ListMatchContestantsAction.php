<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListMatchContestantsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListMatchContestantsAction extends Action
{
    private $listMatchContestantsService;

    public function __construct(LoggerInterface $logger, ListMatchContestantsService $listMatchContestantsService)
    {
        parent::__construct($logger);
        $this->listMatchContestantsService = $listMatchContestantsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int)$this->resolveArg('matchId');

        $matchContestantList = $this->listMatchContestantsService->run($matchId);

        return $this->respondWithData($matchContestantList);
    }
}
