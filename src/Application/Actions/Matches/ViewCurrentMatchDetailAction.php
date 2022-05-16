<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewCurrentMatchDetailService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
