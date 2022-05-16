<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\ListUsersService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

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
        $userList = $this->listUserService->run();

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin()) {
            foreach ($userList as $user) {
                $user->setShowFullDetail(true);
            }
        }

        return $this->respondWithData($userList);
    }
}
