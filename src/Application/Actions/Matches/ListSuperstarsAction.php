<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListSuperstarsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListSuperstarsAction extends Action
{
    private $listSuperstarsService;

    public function __construct(LoggerInterface $logger, ListSuperstarsService $listSuperstarsService)
    {
        parent::__construct($logger);
        $this->listSuperstarsService = $listSuperstarsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $matchList = $this->listSuperstarsService->run();

        return $this->respondWithData($matchList);
    }
}
