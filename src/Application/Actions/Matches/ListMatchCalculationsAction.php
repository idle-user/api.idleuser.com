<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListMatchCalculationsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListMatchCalculationsAction extends Action
{
    private $listMatchCalculationsService;

    public function __construct(LoggerInterface $logger, ListMatchCalculationsService $listMatchCalculationsService)
    {
        parent::__construct($logger);
        $this->listMatchCalculationsService = $listMatchCalculationsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchCalculationList = $this->listMatchCalculationsService->run();

        return $this->respondWithData($matchCalculationList);
    }
}
