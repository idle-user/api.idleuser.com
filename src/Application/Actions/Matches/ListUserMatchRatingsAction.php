<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListUserMatchRatingsService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListUserMatchRatingsAction extends Action
{
    private $listUserMatchRatingsService;

    public function __construct(LoggerInterface $logger, ListUserMatchRatingsService $listUserMatchRatingsService)
    {
        parent::__construct($logger);
        $this->listUserMatchRatingsService = $listUserMatchRatingsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveArg('userId');

        $userMatchRatingList = $this->listUserMatchRatingsService->run($userId);

        return $this->respondWithData($userMatchRatingList);
    }
}
