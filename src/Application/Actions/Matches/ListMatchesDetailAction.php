<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListMatchesDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListMatchesDetailAction extends Action
{
    private $listMatchesDetailService;

    public function __construct(LoggerInterface $logger, ListMatchesDetailService $listMatchesDetailService)
    {
        parent::__construct($logger);
        $this->listMatchesDetailService = $listMatchesDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchDetailList = $this->listMatchesDetailService->run();

        return $this->respondWithData($matchDetailList);
    }
}
