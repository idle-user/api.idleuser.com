<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewSeasonService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewSeasonAction extends Action
{
    private $viewSeasonService;

    public function __construct(LoggerInterface $logger, ViewSeasonService $viewSeasonService)
    {
        parent::__construct($logger);
        $this->viewSeasonService = $viewSeasonService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $seasonId = (int)$this->resolveArg('seasonId');

        $season = $this->viewSeasonService->run($seasonId);

        return $this->respondWithData($season);
    }
}
