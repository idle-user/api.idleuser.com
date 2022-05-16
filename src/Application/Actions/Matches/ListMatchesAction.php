<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListMatchesService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListMatchesAction extends Action
{
    private $listMatchesService;

    public function __construct(LoggerInterface $logger, ListMatchesService $listMatchesService)
    {
        parent::__construct($logger);
        $this->listMatchesService = $listMatchesService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchList = $this->listMatchesService->run();

        return $this->respondWithData($matchList);
    }
}
