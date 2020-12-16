<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\ChatangoIdAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class UpdateChatangoIdUserService extends UserService
{
    public function run($userId, $chatangoId)
    {
        $this->validate($userId, $chatangoId);

        $this->userRepository->updatechatangoIdById($userId, $chatangoId);

        $user = $this->userRepository->findByChatangoId($chatangoId);

        $this->logger->info(sprintf('User chatangoId updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate($userId, $chatangoId)
    {
        $currentUser = $this->userRepository->findById($userId);

        if ($currentUser->getchatangoId() != $chatangoId) {
            try {
                $this->userRepository->findByChatangoId($chatangoId);
                throw new ChatangoIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        } else {
            throw new ValidationException('Nothing to update.');
        }
    }
}
