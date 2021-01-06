<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewBetCalculationService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewBetCalculationAction extends Action
{
    private $viewBetCalculationService;

    public function __construct(LoggerInterface $logger, ViewBetCalculationService $viewBetCalculationService)
    {
        parent::__construct($logger);
        $this->viewBetCalculationService = $viewBetCalculationService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');
        $matchId = (int) $this->resolveArg('matchId');

        $betCalculation = $this->viewBetCalculationService->run($userId, $matchId);

        return $this->respondWithData($betCalculation);
    }
}
