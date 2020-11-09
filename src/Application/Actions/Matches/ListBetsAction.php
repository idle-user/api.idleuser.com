<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListBetsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListBetsAction extends Action
{
    private $listBetsService;

    public function __construct(LoggerInterface $logger, ListBetsService $listBetsService)
    {
        parent::__construct($logger);
        $this->listBetsService = $listBetsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $betList = $this->listBetsService->run();

        return $this->respondWithData($betList);
    }
}
