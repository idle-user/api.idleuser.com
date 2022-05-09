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

        $user = $this->updateTwitterIdUserService->run($userId, $twitterId);

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
