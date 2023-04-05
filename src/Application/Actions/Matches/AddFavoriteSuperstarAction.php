<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\AddFavoriteSuperstarService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;
use Slim\Exception\HttpForbiddenException;


class AddFavoriteSuperstarAction extends Action
{
    private $addFavoriteSuperstarService;

    public function __construct(LoggerInterface $logger, AddFavoriteSuperstarService $addFavoriteSuperstarService)
    {
        parent::__construct($logger);
        $this->addFavoriteSuperstarService = $addFavoriteSuperstarService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');
        $superstarId = (int)$this->resolveBodyArg('superstar_id');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $favoriteSuperstar = $this->addFavoriteSuperstarService->run($userId, $superstarId);

        return $this->respondWithData($favoriteSuperstar);
    }
}
