<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewBetService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewMatchRatingAction extends Action
{
    private $viewMatchRatingService;

    public function __construct(LoggerInterface $logger, ViewBetService $viewMatchRatingService)
    {
        parent::__construct($logger);
        $this->viewMatchRatingService = $viewMatchRatingService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');
        $matchId = (int)$this->resolveArg('matchId');

        $bet = $this->viewMatchRatingService->run($userId, $matchId);

        return $this->respondWithData($bet);
    }
}
