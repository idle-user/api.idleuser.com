<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListMatchBetsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListMatchBetsAction extends Action
{
    private $listMatchBetsService;

    public function __construct(LoggerInterface $logger, ListMatchBetsService $listMatchBetsService)
    {
        parent::__construct($logger);
        $this->listMatchBetsService = $listMatchBetsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int)$this->resolveArg('matchId');

        $matchBetList = $this->listMatchBetsService->run($matchId);

        return $this->respondWithData($matchBetList);
    }
}
