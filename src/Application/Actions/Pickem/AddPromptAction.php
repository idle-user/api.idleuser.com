<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\AddPromptService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class AddPromptAction extends Action
{
    private $addPromptService;

    public function __construct(LoggerInterface $logger, AddPromptService $addPromptService)
    {
        parent::__construct($logger);
        $this->addPromptService = $addPromptService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');
        $subject = $this->resolveBodyArg('subject');
        $choices = $this->resolveBodyArg('choices');

        $prompt = $this->addPromptService->run($userId, $subject, $choices);

        return $this->respondWithData($prompt);
    }
}
