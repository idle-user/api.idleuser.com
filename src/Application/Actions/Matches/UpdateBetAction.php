<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\UpdateBetService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class UpdateBetAction extends Action
{
    private $updateBetService;

    public function __construct(LoggerInterface $logger, UpdateBetService $updateBetService)
    {
        parent::__construct($logger);
        $this->updateBetService = $updateBetService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveBodyArg('user_id');
        $matchId = (int) $this->resolveBodyArg('match_id');
        $team = (int) $this->resolveBodyArg('team');
        $points = $this->resolveBodyArg('points');

        $bet = $this->updateBetService->run($userId, $matchId, $team, $points);

        return $this->respondWithData($bet);
    }
}
