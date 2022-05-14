<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewRoyalRumbleService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewRoyalRumbleAction extends Action
{
    private $viewRoyalRumbleService;

    public function __construct(LoggerInterface $logger, ViewRoyalRumbleService $viewRoyalRumbleService)
    {
        parent::__construct($logger);
        $this->viewRoyalRumbleService = $viewRoyalRumbleService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $royalrumbleId = (int)$this->resolveArg('royalrumbleId');

        $royalrumbleEntry = $this->viewRoyalRumbleService->run($royalrumbleId);

        return $this->respondWithData($royalrumbleEntry);
    }
}
