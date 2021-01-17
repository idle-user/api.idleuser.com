<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListUserBetsDetailService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListUserBetsDetailAction extends Action
{
    private $listUserBetsDetailService;

    public function __construct(LoggerInterface $logger, ListUserBetsDetailService $listUserBetsDetailService)
    {
        parent::__construct($logger);
        $this->listUserBetsDetailService = $listUserBetsDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');

        $userBetDetailList = $this->listUserBetsDetailService->run($userId);

        return $this->respondWithData($userBetDetailList);
    }
}
