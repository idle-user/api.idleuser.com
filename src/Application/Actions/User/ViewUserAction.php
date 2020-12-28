<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ViewUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewUserAction extends Action
{
    private $viewUserService;

    public function __construct(LoggerInterface $logger, ViewUserService $viewUserService)
    {
        parent::__construct($logger);
        $this->viewUserService = $viewUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');

        $isSelf = $this->request->getAttribute('auth_is_self');
        $isAdmin = $this->request->getAttribute('auth_is_admin');
        $showFullDetail = $isSelf || $isAdmin;

        $user = $this->viewUserService->run($userId, $showFullDetail);

        return $this->respondWithData($user);
    }
}
