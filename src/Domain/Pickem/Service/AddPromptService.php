<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Data\Choice;
use App\Domain\Pickem\Data\Prompt;
use App\Domain\Pickem\Data\Stats;
use App\Domain\Pickem\Exception\ChoicesNotUniqueException;
use App\Domain\Pickem\Exception\ChoiceSubjectEmptyException;
use App\Domain\Pickem\Exception\PromptChoicesCountException;
use App\Domain\Pickem\Exception\PromptChoicesEmptyException;
use App\Domain\Pickem\Exception\PromptDailyLimitReachedException;
use App\Domain\Pickem\Exception\PromptSubjectEmptyException;
use App\Domain\Pickem\Exception\StatsNotFoundException;

final class AddPromptService extends PickemService
{
    public function run(int $userId, string $promptSubject, $choiceSubjects, ?string $groupId = null): array
    {
        $promptSubject = trim($promptSubject);
        $this->validate($userId, $promptSubject, $choiceSubjects);

        $prompt = Prompt::create()
            ->setUserId($userId)
            ->setGroupId($groupId)
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

    private function validate(int $userId, string $promptSubject, &$choiceSubjects): void
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

        if (trim($promptSubject) === '') {
            throw new PromptSubjectEmptyException();
        }

        if (!is_array($choiceSubjects)) {
            throw new PromptChoicesCountException();
        }

        $choiceCnt = count($choiceSubjects);

        if ($choiceCnt < 2 || $choiceCnt > 5) {
            throw new PromptChoicesEmptyException();
        }

        $uniqueChoiceSubjects = [];
        foreach ($choiceSubjects as &$subject) {
            if (!is_string($subject)) {
                $subject = (string)$subject;
            }

            $subject = trim($subject);

            if ($subject === '') {
                throw new ChoiceSubjectEmptyException();
            }

            if (in_array($subject, $uniqueChoiceSubjects)) {
                throw new ChoicesNotUniqueException();
            }

            $uniqueChoiceSubjects[] = $subject;
        }
    }
}
