<?php
declare(strict_types=1);

namespace App\Application\Actions\AltLink;

use App\Application\Actions\Action;
use App\Domain\AltLink\Service\AddAltLinkService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class AddAltLinkAction extends Action
{
    private $addAltLinkService;

    public function __construct(LoggerInterface $logger, AddAltLinkService $addAltLinkService)
    {
        parent::__construct($logger);
        $this->addAltLinkService = $addAltLinkService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $alias = $this->resolveBodyArg('alias');

        $this->logger->info("Add AltLink `${alias}` attempt.");

        $altLink = $this->addAltLinkService->run($this->request->getParsedBody());

        return $this->respondWithData($altLink);
    }
}
