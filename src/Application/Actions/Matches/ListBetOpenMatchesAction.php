<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListBetOpenMatchesService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListBetOpenMatchesAction extends Action
{
    private $listBetOpenMatchesService;

    public function __construct(LoggerInterface $logger, ListBetOpenMatchesService $listBetOpenMatchesService)
    {
        parent::__construct($logger);
        $this->listBetOpenMatchesService = $listBetOpenMatchesService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $betOpenMatchList = $this->listBetOpenMatchesService->run();

        return $this->respondWithData($betOpenMatchList);
    }
}
