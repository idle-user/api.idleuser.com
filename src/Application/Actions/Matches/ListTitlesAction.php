<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListTitlesService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

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
