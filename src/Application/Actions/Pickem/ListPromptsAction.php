<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\ListPromptsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListPromptsAction extends Action
{
    private $listPromptsService;

    public function __construct(LoggerInterface $logger, ListPromptsService $listPromptsService)
    {
        parent::__construct($logger);
        $this->listPromptsService = $listPromptsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $open = (bool)$this->resolveQueryParam('open', false);
        $userId = $this->resolveQueryParam('user_id', false);
        $groupId = $this->resolveQueryParam('group_id', false);

        if (!is_null($userId)) {
            $userId = (int)$userId;
        }

        if (!is_null($groupId)) {
            $groupId = (string)$groupId;
        }

        $promptList = $this->listPromptsService->run($open, $userId, $groupId);

        return $this->respondWithData($promptList);
    }
}
