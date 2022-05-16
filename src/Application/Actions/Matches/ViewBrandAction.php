<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewBrandService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewBrandAction extends Action
{
    private $viewBrandService;

    public function __construct(LoggerInterface $logger, ViewBrandService $viewBrandService)
    {
        parent::__construct($logger);
        $this->viewBrandService = $viewBrandService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $brandId = (int)$this->resolveArg('brandId');

        $brand = $this->viewBrandService->run($brandId);

        return $this->respondWithData($brand);
    }
}
