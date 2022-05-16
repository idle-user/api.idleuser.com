<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewRecentMatchDetailService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
