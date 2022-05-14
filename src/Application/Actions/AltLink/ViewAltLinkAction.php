<?php
declare(strict_types=1);

namespace App\Application\Actions\AltLink;

use App\Application\Actions\Action;
use App\Domain\AltLink\Service\ViewAltLinkService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewAltLinkAction extends Action
{
    private $viewAltLinkService;

    public function __construct(LoggerInterface $logger, ViewAltLinkService $viewAltLinkService)
    {
        parent::__construct($logger);
        $this->viewAltLinkService = $viewAltLinkService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $alias = (string)$this->resolveArg('alias');

        $altLink = $this->viewAltLinkService->run($alias);

        return $this->respondWithData($altLink);
    }
}
