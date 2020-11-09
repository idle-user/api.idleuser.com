<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\SearchSuperstarService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class SearchSuperstarAction extends Action
{
    private $searchSuperstarService;

    public function __construct(LoggerInterface $logger, SearchSuperstarService $searchSuperstarService)
    {
        parent::__construct($logger);
        $this->searchSuperstarService = $searchSuperstarService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $keyword = (string) $this->resolveArg('keyword');

        $superstars = $this->searchSuperstarService->run($keyword);

        return $this->respondWithData($superstars);
    }
}
