<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\DiscordIdAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class UpdateDiscordIdUserService extends UserService
{
    public function run($userId, $discordId)
    {
        $this->validate($userId, $discordId);

        $this->userRepository->updateDiscordIdById($userId, $discordId);

        $user = $this->userRepository->findByDiscordId($discordId);

        $this->logger->info(sprintf('User discord_id updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate($userId, $discordId)
    {
        $currentUser = $this->userRepository->findById($userId);

        if ($currentUser->getdiscordId() != $discordId) {
            try {
                $this->userRepository->findByDiscordId($discordId);
                throw new DiscordIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        } else {
            throw new ValidationException('Nothing to update.');
        }
    }
}
