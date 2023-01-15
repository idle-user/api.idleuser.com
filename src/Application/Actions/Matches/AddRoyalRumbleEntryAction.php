<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Auth\Service\ValidateAuthService;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Domain\Matches\Service\AddRoyalRumbleEntryService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;
use Slim\Exception\HttpBadRequestException;

class AddRoyalRumbleEntryAction extends Action
{
    private $validateAuthService;
    private $addRoyalRumbleEntryService;

    public function __construct(LoggerInterface $logger, ValidateAuthService $validateAuthService, AddRoyalRumbleEntryService $addRoyalRumbleEntryService)
    {
        parent::__construct($logger);
        $this->validateAuthService = $validateAuthService;
        $this->addRoyalRumbleEntryService = $addRoyalRumbleEntryService;
    }

    /**
     * {@inheritdoc}
     * @throws AuthTokenInvalidException
     */
    protected function action(): Response
    {
        $royalRumbleId = (int)$this->resolveArg('royalrumbleId');
        try {
            $userId = (int)$this->resolveBodyArg('user_id');
            $auth = $this->validateAuthService->run();
            if (!($auth->isAdmin() || $auth->getUserId() == $userId)) {
                throw new AuthTokenInvalidException($auth->getAuthToken());
            }
        } catch (HttpBadRequestException $e) {
            $userId = null;
        }
        $displayName = (string)$this->resolveBodyArg('display_name');
        $comment = (string)$this->resolveBodyArg('comment');

        if ($userId == 0) {
            $userId = null;
        }

        $royalrumbleEntry = $this->addRoyalRumbleEntryService->run($royalRumbleId, $userId, $displayName, $comment);

        return $this->respondWithData($royalrumbleEntry);
    }
}
