<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ListUsersService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListUsersAction extends Action
{
    private $listUserservice;

    public function __construct(LoggerInterface $logger, ListUsersService $listUserservice)
    {
        parent::__construct($logger);
        $this->listUserservice = $listUserservice;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userList = $this->listUserservice->run();

        return $this->respondWithData($userList);
    }
}
