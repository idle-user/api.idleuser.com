<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewStatsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewStatsAction extends Action
{
    private $viewStatsService;

    public function __construct(LoggerInterface $logger, ViewStatsService $viewStatsService)
    {
        parent::__construct($logger);
        $this->viewStatsService = $viewStatsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');
        $seasonId = (int)$this->resolveArg('seasonId');

        $stats = $this->viewStatsService->run($userId, $seasonId);

        return $this->respondWithData($stats);
    }
}
