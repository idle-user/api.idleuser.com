<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\AddMatchRatingService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;
use Slim\Exception\HttpForbiddenException;


class AddMatchRatingAction extends Action
{
    private $addMatchRatingService;

    public function __construct(LoggerInterface $logger, AddMatchRatingService $addMatchRatingService)
    {
        parent::__construct($logger);
        $this->addMatchRatingService = $addMatchRatingService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');
        $matchId = (int)$this->resolveBodyArg('match_id');
        $rating = (float)$this->resolveBodyArg('rating');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $bet = $this->addMatchRatingService->run($userId, $matchId, $rating);

        return $this->respondWithData($bet);
    }
}
