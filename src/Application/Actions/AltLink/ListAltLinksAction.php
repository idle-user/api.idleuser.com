<?php
declare(strict_types=1);

namespace App\Application\Actions\AltLink;

use App\Domain\AltLink\Service\ListAltLinksService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListAltLinksAction extends Action
{
    private $listAltLinksService;

    public function __construct(LoggerInterface $logger, ListAltLinksService $listAltLinksService)
    {
        parent::__construct($logger);
        $this->listAltLinksService = $listAltLinksService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $altLinkList = $this->listAltLinksService->run();

        return $this->respondWithData($altLinkList);
    }
}
