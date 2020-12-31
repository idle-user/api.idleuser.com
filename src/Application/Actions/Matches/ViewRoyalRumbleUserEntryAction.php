<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ViewRoyalRumbleUserEntryService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewRoyalRumbleUserEntryAction extends Action
{
    private $viewRoyalRumbleUserEntryService;

    public function __construct(
        LoggerInterface $logger,
        ViewRoyalRumbleUserEntryService $viewRoyalRumbleUserEntryService
    ) {
        parent::__construct($logger);
        $this->viewRoyalRumbleUserEntryService = $viewRoyalRumbleUserEntryService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $royalrumbleId = (int) $this->resolveArg('royalrumbleId');
        $userId = (int) $this->resolveArg('userId');

        $royalrumbleEntry = $this->viewRoyalRumbleUserEntryService->run($royalrumbleId, $userId);

        return $this->respondWithData($royalrumbleEntry);
    }
}
