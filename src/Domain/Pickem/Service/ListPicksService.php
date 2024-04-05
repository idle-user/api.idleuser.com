<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ListPicksService extends PickemService
{
    public function run(int $promptId = 0, int $choiceId = 0, int $userId = 0)
    {
        if ($promptId && $choiceId === 0 && $userId === 0) {
            $picks = $this->pickRepository->findAllByPromptId($promptId);
        } elseif ($promptId === 0 && $choiceId && $userId === 0) {
            $picks = $this->pickRepository->findAllByChoiceId($choiceId);
        } elseif ($promptId === 0 && $choiceId === 0 && $userId) {
            $picks = $this->pickRepository->findAllByUserId($userId);
        } else {
            $picks = $this->pickRepository->findAll();
        }

        $this->logger->debug('Picks list was viewed.');
        return $picks;
    }
}
