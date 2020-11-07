<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\SearchUsernameUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $keyword = (string) $this->resolveArg('keyword');

        $user = $this->searchUsernameUserService->run($keyword);

        return $this->respondWithData($user);
    }
}
