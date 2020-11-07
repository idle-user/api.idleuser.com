<?php
declare(strict_types=1);

namespace App\Application\Actions\Auth;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\AuthService;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;


class AuthAction extends Action
{
    /**
     * @var AuthService
     */
    protected $authService;

    /**
     * @param LoggerInterface $logger
     * @param AuthService  $authService
     */
    public function __construct(LoggerInterface $logger, AuthService $authService)
    {
        parent::__construct($logger);
        $this->authService = $authService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $this->logger->info("Auth attempt.");

        $auth = $this->authService->run($this->request->getQueryParams());

        return $this->respondWithData($auth);
    }
}
