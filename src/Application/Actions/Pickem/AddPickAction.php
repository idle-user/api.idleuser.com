<?php
declare(strict_types=1);

namespace App\Application\Actions\Pickem;

use App\Application\Actions\Action;
use App\Domain\Pickem\Service\AddPickService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Log\LoggerInterface;

class AddPickAction extends Action
{
    private $addPickService;

    public function __construct(LoggerInterface $logger, AddPickService $addPickService)
    {
        parent::__construct($logger);
        $this->addPickService = $addPickService;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $userId = (int)$this->resolveBodyArg('user_id');
        $promptId = (int)$this->resolveBodyArg('prompt_id');
        $choiceId = (int)$this->resolveBodyArg('choice_id');

        $pick = $this->addPickService->run($userId, $promptId, $choiceId);

        return $this->respondWithData($pick);
    }
}
