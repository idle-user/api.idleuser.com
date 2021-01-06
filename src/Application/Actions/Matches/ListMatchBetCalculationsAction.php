<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListMatchBetCalculationsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListMatchBetCalculationsAction extends Action
{
    private $listMatchBetCalculationsService;

    public function __construct(
        LoggerInterface $logger,
        ListMatchBetCalculationsService $listMatchBetCalculationsService
    ) {
        parent::__construct($logger);
        $this->listMatchBetCalculationsService = $listMatchBetCalculationsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int) $this->resolveArg('matchId');

        $matchBetCalculationList = $this->listMatchBetCalculationsService->run($matchId);

        return $this->respondWithData($matchBetCalculationList);
    }
}
