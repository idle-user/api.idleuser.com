<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewMatchTypeService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewMatchTypeAction extends Action
{
    private $viewMatchTypeService;

    public function __construct(LoggerInterface $logger, ViewMatchTypeService $viewMatchTypeService)
    {
        parent::__construct($logger);
        $this->viewMatchTypeService = $viewMatchTypeService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchTypeId = (int) $this->resolveArg('matchTypeId');

        $matchType = $this->viewMatchTypeService->run($matchTypeId);

        return $this->respondWithData($matchType);
    }
}
