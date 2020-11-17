<?php
declare(strict_types=1);

namespace App\Application\Actions\Auth;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\ValidateAuthService;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewAuthAction extends Action
{
    protected $validateAuthService;

    public function __construct(LoggerInterface $logger, ValidateAuthService $validateAuthService)
    {
        parent::__construct($logger);
        $this->validateAuthService = $validateAuthService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $this->logger->info('Auth view attempt.');

        $auth = $this->validateAuthService->run($this->request->getQueryParams());

        return $this->respondWithData($auth);
    }
}
