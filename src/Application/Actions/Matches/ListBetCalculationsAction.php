<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListBetCalculationsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListBetCalculationsAction extends Action
{
    private $listBetCalculationsService;

    public function __construct(LoggerInterface $logger, ListBetCalculationsService $listBetCalculationsService)
    {
        parent::__construct($logger);
        $this->listBetCalculationsService = $listBetCalculationsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $betCalculationList = $this->listBetCalculationsService->run();

        return $this->respondWithData($betCalculationList);
    }
}
