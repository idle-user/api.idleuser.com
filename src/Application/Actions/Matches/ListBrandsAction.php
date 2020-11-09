<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Domain\Matches\Service\ListBrandsService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ListBrandsAction extends Action
{
    private $listBrandsService;

    public function __construct(LoggerInterface $logger, ListBrandsService $listBrandsService)
    {
        parent::__construct($logger);
        $this->listBrandsService = $listBrandsService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $brandList = $this->listBrandsService->run();

        return $this->respondWithData($brandList);
    }
}
