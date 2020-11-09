<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListUserMatchRatingsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $userId = (int) $this->resolveArg('userId');

        $userMatchRatingList = $this->listUserMatchRatingsService->run($userId);

        return $this->respondWithData($userMatchRatingList);
    }
}
