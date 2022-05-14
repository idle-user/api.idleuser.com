<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListTitlesService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListTitlesAction extends Action
{
    private $listTitlesService;

    public function __construct(LoggerInterface $logger, ListTitlesService $listTitlesService)
    {
        parent::__construct($logger);
        $this->listTitlesService = $listTitlesService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $titleList = $this->listTitlesService->run();

        return $this->respondWithData($titleList);
    }
}
