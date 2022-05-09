<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\AddRoyalRumbleEntryService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Slim\Exception\HttpBadRequestException;
use Slim\Exception\HttpForbiddenException;

class AddRoyalRumbleEntryAction extends Action
{
    private $addRoyalRumbleEntryService;

    public function __construct(LoggerInterface $logger, AddRoyalRumbleEntryService $addRoyalRumbleEntryService)
    {
        parent::__construct($logger);
        $this->addRoyalRumbleEntryService = $addRoyalRumbleEntryService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $royalRumbleId = (int) $this->resolveArg('royalrumbleId');
        try {
            $userId = (int) $this->resolveBodyArg('user_id');
        } catch (HttpBadRequestException $e) {
            $userId = null;
        }
        $displayName = (string) $this->resolveBodyArg('display_name');
        $comment = (string) $this->resolveBodyArg('comment');

        if ($userId == 0) {
            $userId = null;
        }

        $royalrumbleEntry = $this->addRoyalRumbleEntryService->run($royalRumbleId, $userId, $displayName, $comment);

        return $this->respondWithData($royalrumbleEntry);
    }
}
