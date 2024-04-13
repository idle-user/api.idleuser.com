<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\ListPicksService;
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
        $promptId = $this->resolveQueryParam('prompt_id', false);
        $choiceId = $this->resolveQueryParam('choiceId', false);
        $userId = $this->resolveQueryParam('user_id', false);

        if (!is_null($promptId)) {
            $promptId = (int)$promptId;
        }

        if (!is_null($choiceId)) {
            $choiceId = (int)$choiceId;
        }

        if (!is_null($userId)) {
            $userId = (int)$userId;
        }


        $picksList = $this->listPicksService->run($promptId, $choiceId, $userId);

        return $this->respondWithData($picksList);
    }
}
