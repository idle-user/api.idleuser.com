<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\ViewPromptService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class ViewPromptAction extends Action
{
    private $viewPromptService;

    public function __construct(LoggerInterface $logger, ViewPromptService $viewPromptService)
    {
        parent::__construct($logger);
        $this->viewPromptService = $viewPromptService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $promptId = (int)$this->resolveArg('promptId');

        $promptList = $this->viewPromptService->run($promptId);

        return $this->respondWithData($promptList);
    }
}
