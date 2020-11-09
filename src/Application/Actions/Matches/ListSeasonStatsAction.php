<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListSeasonStatsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListSeasonStatsAction extends Action
{
    private $listSeasonStatsService;

    public function __construct(LoggerInterface $logger, ListSeasonStatsService $listSeasonStatsService)
    {
        parent::__construct($logger);
        $this->listSeasonStatsService = $listSeasonStatsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $seasonId = (int) $this->resolveArg('seasonId');
        
        $seasonStatList = $this->listSeasonStatsService->run($seasonId);

        return $this->respondWithData($seasonStatList);
    }
}
