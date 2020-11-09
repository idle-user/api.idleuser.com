<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListMatchRatingsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListMatchRatingsAction extends Action
{
    private $listMatchRatingsService;

    public function __construct(LoggerInterface $logger, ListMatchRatingsService $listMatchRatingsService)
    {
        parent::__construct($logger);
        $this->listMatchRatingsService = $listMatchRatingsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchRatingList = $this->listMatchRatingsService->run();

        return $this->respondWithData($matchRatingList);
    }
}
