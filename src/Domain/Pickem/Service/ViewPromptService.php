<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

final class ViewPromptService extends PickemService
{
    public function run(int $promptId)
    {
        $prompt = $this->promptRepository->findById($promptId);
        $choices = $this->choiceRepository->findByPromptId($promptId);

        $this->logger->debug("Prompt `${promptId}` was viewed.");

        return [
            'prompt' => $prompt,
            'choices' => $choices
        ];
    }
}
