<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListUserBetsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListUserBetsAction extends Action
{
    private $listUserBetsService;

    public function __construct(LoggerInterface $logger, ListUserBetsService $listUserBetsService)
    {
        parent::__construct($logger);
        $this->listUserBetsService = $listUserBetsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');

        $userBetList = $this->listUserBetsService->run($userId);

        return $this->respondWithData($userBetList);
    }
}
