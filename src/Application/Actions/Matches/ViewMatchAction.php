<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewMatchService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewMatchAction extends Action
{
    private $viewMatchService;

    public function __construct(LoggerInterface $logger, ViewMatchService $viewMatchService)
    {
        parent::__construct($logger);
        $this->viewMatchService = $viewMatchService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchId = (int)$this->resolveArg('matchId');

        $match = $this->viewMatchService->run($matchId);

        return $this->respondWithData($match);
    }
}
