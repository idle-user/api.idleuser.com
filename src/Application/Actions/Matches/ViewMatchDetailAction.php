<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewMatchDetailService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
        $matchId = (int)$this->resolveArg('matchId');

        $matchDetail = $this->viewMatchDetailService->run($matchId);

        return $this->respondWithData($matchDetail);
    }
}
