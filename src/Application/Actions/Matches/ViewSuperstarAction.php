<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewSuperstarService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewSuperstarAction extends Action
{
    private $viewSuperstarService;

    public function __construct(LoggerInterface $logger, ViewSuperstarService $viewSuperstarService)
    {
        parent::__construct($logger);
        $this->viewSuperstarService = $viewSuperstarService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $superstarId = (int)$this->resolveArg('superstarId');

        $superstar = $this->viewSuperstarService->run($superstarId);

        return $this->respondWithData($superstar);
    }
}
