<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\ViewChatangoUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewChatangoUserAction extends Action
{
    private $viewChatangoUserService;

    public function __construct(LoggerInterface $logger, ViewChatangoUserService $viewChatangoUserService)
    {
        parent::__construct($logger);
        $this->viewChatangoUserService = $viewChatangoUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $chatangoId = (string)$this->resolveArg('chatangoId');

        $user = $this->viewChatangoUserService->run($chatangoId);

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin() || $auth->getUserId() == $user->getId()) {
            $user->setShowFullDetail(true);
        }

        return $this->respondWithData($user);
    }
}
