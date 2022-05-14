<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListContestantsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListContestantsAction extends Action
{
    private $listContestantsService;

    public function __construct(LoggerInterface $logger, ListContestantsService $listContestantsService)
    {
        parent::__construct($logger);
        $this->listContestantsService = $listContestantsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $contestantList = $this->listContestantsService->run();

        return $this->respondWithData($contestantList);
    }
}
