<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Auth\Service\ValidateAuthService;
use App\Domain\Matches\Service\AddMatchRatingService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class AddMatchRatingAction extends Action
{
    private $addMatchRatingService;

    public function __construct(
        LoggerInterface $logger,
        ValidateAuthService $validateAuthService,
        AddMatchRatingService $addMatchRatingService
    ) {
        parent::__construct($logger);
        $this->validateAuthService = $validateAuthService;
        $this->addMatchRatingService = $addMatchRatingService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $authInfo = $this->validateAuthService->run($this->request->getQueryParams());

        $userId = (int) $authInfo->getUserId();
        $matchId = (int) $this->resolvePost('matchId');
        $rating = (float) $this->resolvePost('rating');

        $bet = $this->addMatchRatingService->run($userId, $matchId, $rating);

        return $this->respondWithData($bet);
    }
}
