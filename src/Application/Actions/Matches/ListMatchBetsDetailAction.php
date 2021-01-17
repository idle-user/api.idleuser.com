<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListMatchBetsDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListMatchBetsDetailAction extends Action
{
    private $listMatchBetsDetailService;

    public function __construct(LoggerInterface $logger, ListMatchBetsDetailService $listMatchBetsDetailService)
    {
        parent::__construct($logger);
        $this->listMatchBetsDetailService = $listMatchBetsDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int) $this->resolveArg('matchId');

        $matchBetDetailList = $this->listMatchBetsDetailService->run($matchId);

        return $this->respondWithData($matchBetDetailList);
    }
}
