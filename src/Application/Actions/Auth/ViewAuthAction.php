<?php
declare(strict_types=1);

namespace App\Application\Actions\Auth;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\AuthService;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;


class ViewAuthAction extends Action
{
    protected $authService;

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
        $this->logger->info("Auth view attempt.");

        $auth = $this->authService->run($this->request->getQueryParams());

        return $this->respondWithData($auth);
    }
}
