<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListBetsDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
