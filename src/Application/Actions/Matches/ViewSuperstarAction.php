<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewSuperstarService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
        $superstarId = (int) $this->resolveArg('id');

        $superstar = $this->viewSuperstarService->run($superstarId);

        return $this->respondWithData($superstar);
    }
}
