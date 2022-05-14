<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListSeasonsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListSeasonsAction extends Action
{
    private $listSeasonsService;

    public function __construct(LoggerInterface $logger, ListSeasonsService $listSeasonsService)
    {
        parent::__construct($logger);
        $this->listSeasonsService = $listSeasonsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $seasonList = $this->listSeasonsService->run();

        return $this->respondWithData($seasonList);
    }
}
