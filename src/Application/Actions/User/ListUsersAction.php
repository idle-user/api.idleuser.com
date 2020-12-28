<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ListUsersService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListUsersAction extends Action
{
    private $listUserService;

    public function __construct(LoggerInterface $logger, ListUsersService $listUserService)
    {
        parent::__construct($logger);
        $this->listUserService = $listUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $isSelf = $this->request->getAttribute('auth_is_self');
        $isAdmin = $this->request->getAttribute('auth_is_admin');
        $showfullDetail = $isSelf || $isAdmin;

        $userList = $this->listUserService->run($showfullDetail);

        return $this->respondWithData($userList);
    }
}
