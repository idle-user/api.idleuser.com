<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListMatchesService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $matches = $this->listMatchesService->run();

        return $this->respondWithData($matches);
    }
}
