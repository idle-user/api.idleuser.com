<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewBetService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewBetAction extends Action
{
    private $viewBetService;

    public function __construct(LoggerInterface $logger, ViewBetService $viewBetService)
    {
        parent::__construct($logger);
        $this->viewBetService = $viewBetService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');
        $matchId = (int)$this->resolveArg('matchId');

        $bet = $this->viewBetService->run($userId, $matchId);

        return $this->respondWithData($bet);
    }
}
