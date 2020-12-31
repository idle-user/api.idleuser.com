<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\UpdateTwitterIdUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpForbiddenException;

class UpdateTwitterIdUserAction extends Action
{
    private $updateTwitterIdUserService;

    public function __construct(LoggerInterface $logger, UpdateTwitterIdUserService $updateTwitterIdUserService)
    {
        parent::__construct($logger);
        $this->updateTwitterIdUserService = $updateTwitterIdUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');
        $twitterId = (string) $this->resolveBodyArg('twitter_id');

        $auth = $this->request->getAttribute('auth');
        if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
            throw new HttpForbiddenException($this->request);
        }

        $user = $this->updateTwitterIdUserService->run($userId, $twitterId);

        return $this->respondWithData($user);
    }
}
