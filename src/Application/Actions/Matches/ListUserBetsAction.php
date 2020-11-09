<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListUserBetsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $userId = (int) $this->resolveArg('userId');
        
        $userBetList = $this->listUserBetsService->run($userId);

        return $this->respondWithData($userBetList);
    }
}
