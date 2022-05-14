<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListCurrentUserBetsDetailService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListCurrentUserBetsDetailAction extends Action
{
    private $listActiveUserBetsDetailService;

    public function __construct(
        LoggerInterface                  $logger,
        ListCurrentUserBetsDetailService $listActiveUserBetsDetailService
    )
    {
        parent::__construct($logger);
        $this->listActiveUserBetsDetailService = $listActiveUserBetsDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');

        $userBetNotCompleteDetailList = $this->listActiveUserBetsDetailService->run($userId);

        return $this->respondWithData($userBetNotCompleteDetailList);
    }
}
