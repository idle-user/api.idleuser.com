<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewMatchSeasonService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewMatchSeasonAction extends Action
{
    private $viewMatchSeasonService;

    public function __construct(LoggerInterface $logger, ViewMatchSeasonService $viewMatchSeasonService)
    {
        parent::__construct($logger);
        $this->viewMatchSeasonService = $viewMatchSeasonService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int) $this->resolveArg('matchId');

        $season = $this->viewMatchSeasonService->run($matchId);

        return $this->respondWithData($season);
    }
}
