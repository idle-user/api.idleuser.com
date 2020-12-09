<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewRecentMatchDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewRecentMatchDetailAction extends Action
{
    private $viewRecentMatchDetailService;

    public function __construct(LoggerInterface $logger, ViewRecentMatchDetailService $viewRecentMatchDetailService)
    {
        parent::__construct($logger);
        $this->viewRecentMatchDetailService = $viewRecentMatchDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchDetail = $this->viewRecentMatchDetailService->run();

        return $this->respondWithData($matchDetail);
    }
}
