<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewCurrentMatchDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewCurrentMatchDetailAction extends Action
{
    private $viewCurrentMatchDetailService;

    public function __construct(LoggerInterface $logger, ViewCurrentMatchDetailService $viewCurrentMatchDetailService)
    {
        parent::__construct($logger);
        $this->viewCurrentMatchDetailService = $viewCurrentMatchDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchDetail = $this->viewCurrentMatchDetailService->run();

        return $this->respondWithData($matchDetail);
    }
}
