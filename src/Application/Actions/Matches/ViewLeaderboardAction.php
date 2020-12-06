<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewLeaderboardService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewLeaderboardAction extends Action
{
    private $viewLeaderboardService;

    public function __construct(LoggerInterface $logger, ViewLeaderboardService $viewLeaderboardService)
    {
        parent::__construct($logger);
        $this->viewLeaderboardService = $viewLeaderboardService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $seasonId = (int) $this->resolveArg('seasonId');

        $leaderboard = $this->viewLeaderboardService->run($seasonId);

        return $this->respondWithData($leaderboard);
    }
}
