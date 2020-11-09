<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ViewUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewUserAction extends Action
{
    private $viewUserservice;

    public function __construct(LoggerInterface $logger, ViewUserService $viewUserservice)
    {
        parent::__construct($logger);
        $this->viewUserservice = $viewUserservice;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int) $this->resolveArg('userId');

        $user = $this->viewUserservice->run($userId);

        return $this->respondWithData($user);
    }
}
