<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewMatchDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewMatchDetailAction extends Action
{
    private $viewMatchDetailService;

    public function __construct(LoggerInterface $logger, ViewMatchDetailService $viewMatchDetailService)
    {
        parent::__construct($logger);
        $this->viewMatchDetailService = $viewMatchDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int) $this->resolveArg('matchId');

        $matchDetail = $this->viewMatchDetailService->run($matchId);

        return $this->respondWithData($matchDetail);
    }
}
