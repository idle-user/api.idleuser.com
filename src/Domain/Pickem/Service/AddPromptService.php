<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Data\Choice;
use App\Domain\Pickem\Data\Prompt;
use App\Domain\Pickem\Data\Stats;
use App\Domain\Pickem\Exception\ChoiceSubjectEmptyException;
use App\Domain\Pickem\Exception\PromptChoicesCountException;
use App\Domain\Pickem\Exception\PromptChoicesEmptyException;
use App\Domain\Pickem\Exception\PromptDailyLimitReachedException;
use App\Domain\Pickem\Exception\PromptSubjectEmptyException;
use App\Domain\Pickem\Exception\StatsNotFoundException;
use App\Domain\Pickem\Repository\ChoiceRepository;
use App\Domain\Pickem\Repository\PromptRepository;
use App\Domain\Pickem\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

final class AddPromptService
{
    protected $promptRepository;
    protected $choiceRepository;
    protected $statsRepository;

    public function __construct(
        LoggerInterface  $logger,
        PromptRepository $promptRepository,
        ChoiceRepository $choiceRepository,
        StatsRepository  $statsRepository
    )
    {
        $this->logger = $logger;
        $this->promptRepository = $promptRepository;
        $this->choiceRepository = $choiceRepository;
        $this->statsRepository = $statsRepository;
    }

    public function run(int $userId, string $promptSubject, array $choiceSubjects)
    {
        $this->validate($userId, $promptSubject, $choiceSubjects);

        $prompt = Prompt::create()
            ->setUserId($userId)
            ->setSubject($promptSubject);

        $this->logger->debug('Add Prompt attempt:', $prompt->jsonSerialize());
        $prompt = $this->promptRepository->add($prompt);
        $this->logger->info('Prompt added:', $prompt->jsonSerialize());


        $choices = [];
        foreach ($choiceSubjects as $choiceSubject) {
            $choice = Choice::create()
                ->setPromptId($prompt->getId())
                ->setSubject($choiceSubject);
            $this->logger->debug('Add Choice attempt:', $choice->jsonSerialize());
            $choice = $this->choiceRepository->add($choice);
            $this->logger->info('Choice added:', $choice->jsonSerialize());

            $choices[] = $choice;
        }

        $userStats = $this->statsRepository->find($userId);
        $this->logger->debug('Increment Stats attempt:', $userStats->jsonSerialize());
        $userStats = $userStats->incrementPromptsCreated();
        $this->statsRepository->update($userStats);
        $userStats = $this->statsRepository->find($userId);
        $this->logger->info('Stats incremented:', $userStats->jsonSerialize());

        return [
            'prompt' => $prompt,
            'choices' => $choices
        ];
    }

    private function validate(int $userId, string $promptSubject, array $choiceSubjects): void
    {
        try {
            $userStats = $this->statsRepository->find($userId);
        } catch (StatsNotFoundException $e) {
            $userStats = Stats::create()->setUserId($userId);
            $this->statsRepository->add($userStats);
            $userStats = $this->statsRepository->find($userId);
        }

        if ($userStats->getPromptsCreatedToday() >= 10) {
            throw new PromptDailyLimitReachedException();
        }

        if ($promptSubject === '') {
            throw new PromptSubjectEmptyException();
        }

        $choiceCnt = count($choiceSubjects);

        if ($choiceCnt === 0) {
            throw new PromptChoicesEmptyException();
        }

        if ($choiceCnt === 1) {
            throw new PromptChoicesCountException();
        }

        foreach ($choiceSubjects as $subject) {
            if ($subject === '') {
                throw new ChoiceSubjectEmptyException();
            }
        }

    }
}
