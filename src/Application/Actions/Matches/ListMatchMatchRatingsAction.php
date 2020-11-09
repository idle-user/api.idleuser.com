<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListMatchMatchRatingsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $matchId = (int) $this->resolveArg('matchId');

        $matchMatchRatingList = $this->listMatchMatchRatingsService->run($matchId);

        return $this->respondWithData($matchMatchRatingList);
    }
}
