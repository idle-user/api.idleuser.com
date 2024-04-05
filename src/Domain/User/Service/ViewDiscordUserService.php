<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class ViewDiscordUserService extends UserService
{
    public function run(string $discordId)
    {
        $this->validate($discordId);

        $user = $this->userRepository->findByDiscordId($discordId);

        $this->logger->debug("User discord_id `${discordId}` was viewed.");

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
