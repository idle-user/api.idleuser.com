<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListUserStatsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListUserStatsAction extends Action
{
    private $listUserStatsService;

    public function __construct(LoggerInterface $logger, ListUserStatsService $listUserStatsService)
    {
        parent::__construct($logger);
        $this->listUserStatsService = $listUserStatsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');

        $userStatList = $this->listUserStatsService->run($userId);

        return $this->respondWithData($userStatList);
    }
}
