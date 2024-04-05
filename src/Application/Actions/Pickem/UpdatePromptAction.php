<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\UpdatePromptService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class UpdatePromptAction extends Action
{
    private $updatePromptService;

    public function __construct(LoggerInterface $logger, UpdatePromptService $updatePromptService)
    {
        parent::__construct($logger);
        $this->updatePromptService = $updatePromptService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');
        $promptId = (int)$this->resolveBodyArg('prompt_id');
        $open = (int)$this->resolveBodyArg('open');
        $choiceResult = (int)$this->resolveBodyArg('choice_result');

        $prompt = $this->updatePromptService->run($promptId, $open, $choiceResult);

        return $this->respondWithData($prompt);
    }
}
