<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class ViewDiscordUserService extends UserService
{
    public function run(string $discordId, $showFullDetail = false)
    {
        $this->validate($discordId);

        $user = $this->userRepository->findByDiscordId($discordId);
        $user->setShowFullDetail($showFullDetail);

        $this->logger->info("User discord_id `${discordId}` was viewed. Full detail: `${showFullDetail}`");

        return $user;
    }

    private function validate(string $discordId)
    {
        $errors = [];

        if (empty($discordId)) {
            $errors['discordId'] = 'Input required';
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
