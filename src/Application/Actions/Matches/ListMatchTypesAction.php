<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListMatchTypesService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListMatchTypesAction extends Action
{
    private $listMatchTypesService;

    public function __construct(LoggerInterface $logger, ListMatchTypesService $listMatchTypesService)
    {
        parent::__construct($logger);
        $this->listMatchTypesService = $listMatchTypesService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchTypeList = $this->listMatchTypesService->run();

        return $this->respondWithData($matchTypeList);
    }
}
