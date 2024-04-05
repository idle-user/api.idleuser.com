<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\UpdatePickService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class UpdatePickAction extends Action
{
    private $updatePickService;

    public function __construct(LoggerInterface $logger, UpdatePickService $updatePickService)
    {
        parent::__construct($logger);
        $this->updatePickService = $updatePickService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');
        $promptId = (int)$this->resolveBodyArg('prompt_id');
        $choiceId = (int)$this->resolveBodyArg('choice_id');

        $prompt = $this->updatePickService->run($userId, $promptId, $choiceId);

        return $this->respondWithData($prompt);
    }
}
