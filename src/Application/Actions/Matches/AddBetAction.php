<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Auth\Service\ValidateAuthService;
use App\Domain\Matches\Service\AddBetService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class AddBetAction extends Action
{
    private $addBetService;

    public function __construct(
        LoggerInterface $logger,
        ValidateAuthService $validateAuthService,
        AddBetService $addBetService
    ) {
        parent::__construct($logger);
        $this->validateAuthService = $validateAuthService;
        $this->addBetService = $addBetService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $authInfo = $this->validateAuthService->run($this->request->getQueryParams());

        $userId = (int) $authInfo->getUserId();
        $matchId = (int) $this->resolvePost('matchId');
        $team = (int) $this->resolvePost('team');
        $points = (int) $this->resolvePost('points');

        $bet = $this->addBetService->run($userId, $matchId, $team, $points);

        return $this->respondWithData($bet);
    }
}
