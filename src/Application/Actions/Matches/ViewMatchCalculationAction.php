<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewMatchCalculationService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewMatchCalculationAction extends Action
{
    private $viewMatchCalculationService;

    public function __construct(LoggerInterface $logger, ViewMatchCalculationService $viewMatchCalculationService)
    {
        parent::__construct($logger);
        $this->viewMatchCalculationService = $viewMatchCalculationService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int)$this->resolveArg('matchId');

        $matchCalculation = $this->viewMatchCalculationService->run($matchId);

        return $this->respondWithData($matchCalculation);
    }
}
