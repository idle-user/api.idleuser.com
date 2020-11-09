<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListSeasonsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
