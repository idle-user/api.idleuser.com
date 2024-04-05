<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\ViewStatsService;
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

        $stats = $this->viewStatsService->run($userId);

        return $this->respondWithData($stats);
    }
}
