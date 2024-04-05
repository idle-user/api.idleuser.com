<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\ListPicksService;
use App\Domain\Pickem\Service\ListPromptsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListPicksAction extends Action
{
    private $listPicksService;

    public function __construct(LoggerInterface $logger, ListPicksService $listPicksService)
    {
        parent::__construct($logger);
        $this->listPicksService = $listPicksService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $promptId = (int)$this->resolveQueryParam('promptId', false);
        $choiceId = (int)$this->resolveQueryParam('choiceId', false);
        $userId = (int)$this->resolveQueryParam('userId', false);

        $picksList = $this->listPicksService->run($promptId, $choiceId, $userId);

        return $this->respondWithData($picksList);
    }
}
