<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListBetOpenMatchesService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
