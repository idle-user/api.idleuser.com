<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewBetDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewBetDetailAction extends Action
{
    private $viewBetDetailService;

    public function __construct(LoggerInterface $logger, ViewBetDetailService $viewBetDetailService)
    {
        parent::__construct($logger);
        $this->viewBetDetailService = $viewBetDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');
        $matchId = (int) $this->resolveArg('matchId');

        $betDetail = $this->viewBetDetailService->run($userId, $matchId);

        return $this->respondWithData($betDetail);
    }
}
