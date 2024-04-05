<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Exception\InvalidPromptChoiceException;
use App\Domain\Pickem\Exception\PickAlreadyExistsException;
use App\Domain\Pickem\Exception\PromptExpiredException;
use App\Domain\Pickem\Exception\PromptPicksClosedException;

final class UpdatePickService extends PickemService
{
    public function run(int $userId, int $promptId, int $choiceId)
    {
        $this->validate($userId, $promptId, $choiceId);

        $pick = $this->pickRepository->find($promptId, $userId);
        $oldChoiceId = $pick->getChoiceId();
        $pick->setChoiceId($choiceId);

        $this->logger->debug('Update Pick attempt:', $pick->jsonSerialize());
        $this->pickRepository->update($pick);
        $pick = $this->pickRepository->find($promptId, $userId);
        $this->logger->info('Pick updated:', $pick->jsonSerialize());

        $oldChoice = $this->choiceRepository->findById($oldChoiceId);
        $this->logger->debug('Decrement Old Choice Picks attempt:', $oldChoice->jsonSerialize());
        $oldChoice = $oldChoice->decrementPicks();
        $this->choiceRepository->update($oldChoice);
        $oldChoice = $this->choiceRepository->findById($oldChoiceId);
        $this->logger->info('Prompt Old Choice Picks decremented:', $oldChoice->jsonSerialize());

        $newChoice = $this->choiceRepository->findById($choiceId);
        $this->logger->debug('Increment Choice Picks attempt:', $newChoice->jsonSerialize());
        $newChoice = $newChoice->incrementPicks();
        $this->choiceRepository->update($newChoice);
        $newChoice = $this->choiceRepository->findById($choiceId);
        $this->logger->info('Prompt Choice Picks incremented:', $newChoice->jsonSerialize());

        return $pick;
    }

    private function validate(int $userId, int $promptId, int $choiceId): void
    {
        $prompt = $this->promptRepository->findById($promptId);
        $choice = $this->choiceRepository->findById($choiceId);
        $pick = $this->pickRepository->find($promptId, $userId);

        if (!$prompt->isOpen()) {
            throw new PromptPicksClosedException();
        }

        if ($prompt->isExpired()) {
            throw new PromptExpiredException();
        }

        if ($prompt->getId() !== $choice->getPromptId()) {
            throw new InvalidPromptChoiceException();
        }

        if ($choiceId === $pick->getChoiceId()) {
            throw new PickAlreadyExistsException();
        }
    }
}
