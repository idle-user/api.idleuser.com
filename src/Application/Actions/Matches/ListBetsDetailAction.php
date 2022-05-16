<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListBetsDetailService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListBetsDetailAction extends Action
{
    private $listBetsDetailService;

    public function __construct(LoggerInterface $logger, ListBetsDetailService $listBetsDetailService)
    {
        parent::__construct($logger);
        $this->listBetsDetailService = $listBetsDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $betDetailList = $this->listBetsDetailService->run();

        return $this->respondWithData($betDetailList);
    }
}
