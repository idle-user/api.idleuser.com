<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListUserBetCalculationsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListUserBetCalculationsAction extends Action
{
    private $listUserBetCalculationsService;

    public function __construct(LoggerInterface $logger, ListUserBetCalculationsService $listUserBetCalculationsService)
    {
        parent::__construct($logger);
        $this->listUserBetCalculationsService = $listUserBetCalculationsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');

        $userBetCalculationList = $this->listUserBetCalculationsService->run($userId);

        return $this->respondWithData($userBetCalculationList);
    }
}
