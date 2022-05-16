<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListMatchMatchRatingsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListMatchMatchRatingsAction extends Action
{
    private $listMatchMatchRatingsService;

    public function __construct(LoggerInterface $logger, ListMatchMatchRatingsService $listMatchMatchRatingsService)
    {
        parent::__construct($logger);
        $this->listMatchMatchRatingsService = $listMatchMatchRatingsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int)$this->resolveArg('matchId');

        $matchMatchRatingList = $this->listMatchMatchRatingsService->run($matchId);

        return $this->respondWithData($matchMatchRatingList);
    }
}
