<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\AddBetService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class AddBetAction extends Action
{
    private $addBetService;

    public function __construct(LoggerInterface $logger, AddBetService $addBetService)
    {
        parent::__construct($logger);
        $this->addBetService = $addBetService;
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

        $bet = $this->addBetService->run($userId, $matchId, $team, $points);

        return $this->respondWithData($bet);
    }
}
