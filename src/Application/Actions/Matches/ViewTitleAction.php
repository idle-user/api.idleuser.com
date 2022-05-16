<?php
declare(strict_types=1);

namespace App\Application\Actions\Matches;

use App\Application\Actions\Action;
use App\Domain\Matches\Service\ViewTitleService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewTitleAction extends Action
{
    private $viewTitleService;

    public function __construct(LoggerInterface $logger, ViewTitleservice $viewTitleService)
    {
        parent::__construct($logger);
        $this->viewTitleService = $viewTitleService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $titleId = (int)$this->resolveArg('titleId');

        $title = $this->viewTitleService->run($titleId);

        return $this->respondWithData($title);
    }
}
