<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Application\Actions\Action;
use App\Domain\User\Service\SearchUsernameUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class SearchUsernameAction extends Action
{
    private $searchUsernameUserService;

    public function __construct(LoggerInterface $logger, SearchUsernameUserService $searchUsernameUserService)
    {
        parent::__construct($logger);
        $this->searchUsernameUserService = $searchUsernameUserService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $keyword = (string)$this->resolveArg('keyword');

        $userList = $this->searchUsernameUserService->run($keyword);

        $auth = $this->request->getAttribute('auth');
        if ($auth->isAdmin()) {
            foreach ($userList as $user) {
                $user->setShowFullDetail(true);
            }
        }

        return $this->respondWithData($userList);
    }
}
