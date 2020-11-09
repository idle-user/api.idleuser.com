<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListStatsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListStatsAction extends Action
{
    private $listStatsService;

    public function __construct(LoggerInterface $logger, ListStatsService $listStatsService)
    {
        parent::__construct($logger);
        $this->listStatsService = $listStatsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $statList = $this->listStatsService->run();

        return $this->respondWithData($statList);
    }
}
