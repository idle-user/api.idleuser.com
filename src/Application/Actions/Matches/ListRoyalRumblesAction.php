<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListRoyalRumblesService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListRoyalRumblesAction extends Action
{
    private $listRoyalRumblesService;

    public function __construct(LoggerInterface $logger, ListRoyalRumblesService $listRoyalRumblesService)
    {
        parent::__construct($logger);
        $this->listRoyalRumblesService = $listRoyalRumblesService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $royalrumbleList = $this->listRoyalRumblesService->run();

        return $this->respondWithData($royalrumbleList);
    }
}
