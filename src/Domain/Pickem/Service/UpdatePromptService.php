<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Exception\InvalidPromptChoiceException;
use App\Domain\Pickem\Exception\PickNotFoundException;
use App\Domain\Pickem\Exception\PromptClosedException;
use App\Domain\Pickem\Exception\PromptExpiredException;
use App\Domain\Pickem\Exception\PromptMustBeClosedForResultException;
use App\Domain\Pickem\Repository\ChoiceRepository;
use App\Domain\Pickem\Repository\PickRepository;
use App\Domain\Pickem\Repository\PromptRepository;
use App\Domain\Pickem\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

final class UpdatePromptService
{
    protected $promptRepository;
    protected $choiceRepository;
    protected $pickRepository;
    protected $statsRepository;

    public function __construct(
        LoggerInterface  $logger,
        PromptRepository $promptRepository,
        ChoiceRepository $choiceRepository,
        PickRepository   $pickRepository,
        StatsRepository  $statsRepository
    )
    {
        $this->logger = $logger;
        $this->promptRepository = $promptRepository;
        $this->choiceRepository = $choiceRepository;
        $this->pickRepository = $pickRepository;
        $this->statsRepository = $statsRepository;
    }

    public function run(int $promptId, int $open, int $choiceResult)
    {
        $this->validate($promptId, $open, $choiceResult);

        $prompt = $this->promptRepository->findById($promptId);
        $prompt->setOpen($open)
            ->setChoiceResult($choiceResult);

        $this->logger->debug('Update Prompt attempt:', $prompt->jsonSerialize());
        $this->promptRepository->update($prompt);
        $prompt = $this->promptRepository->findById($promptId);
        $this->logger->info('Prompt updated:', $prompt->jsonSerialize());

        if ($choiceResult) {
            try {
                $promptUserPicks = $this->pickRepository->findAllByPromptId($promptId);
            } catch (PickNotFoundException $e) {
                $promptUserPicks = [];
            }

            foreach ($promptUserPicks as $pick) {
                $userPickCorrect = $prompt->getChoiceResult() === $pick->getChoiceId();

                if ($userPickCorrect) {
                    $userCreatedPrompt = $prompt->getUserId() === $pick->getUserId();
                    $userStats = $this->statsRepository->find($pick->getUserId());
                    $this->logger->debug('Increment Stats attempt:', $userStats->jsonSerialize());
                    $userStats = $userStats->incrementPicksCorrect($userCreatedPrompt);
                    $this->statsRepository->update($userStats);
                    $userStats = $this->statsRepository->find($pick->getUserId());
                    $this->logger->info('Stats incremented:', $userStats->jsonSerialize());
                }
            }
        }

        return $prompt;
    }

    private function validate(int $promptId, int $open, int $choiceResult): void
    {
        $prompt = $this->promptRepository->findById($promptId);
        $choice = $this->choiceRepository->findById($choiceResult);

        if ($open && !$prompt->isOpen()) {
            throw new PromptClosedException();
        }

        if ($prompt->isExpired()) {
            throw new PromptExpiredException();
        }

        if ($prompt->getId() !== $choice->getPromptId()) {
            throw new InvalidPromptChoiceException();
        }

        if ($open && $choiceResult) {
            throw new PromptMustBeClosedForResultException();
        }
    }
}
