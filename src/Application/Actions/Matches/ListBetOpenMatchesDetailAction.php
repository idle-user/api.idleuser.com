<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ListBetOpenMatchesDetailService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ListBetOpenMatchesDetailAction extends Action
{
    private $listBetOpenMatchesDetailService;

    public function __construct(LoggerInterface $logger, ListBetOpenMatchesDetailService $listBetOpenMatchesDetailService)
    {
        parent::__construct($logger);
        $this->listBetOpenMatchesDetailService = $listBetOpenMatchesDetailService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $betOpenMatchDetailList = $this->listBetOpenMatchesDetailService->run();

        return $this->respondWithData($betOpenMatchDetailList);
    }
}
