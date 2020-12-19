<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\UsernameAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class UpdateUsernameUserService extends UserService
{
    public function run($userId, $username)
    {
        $this->validate($userId, $username);

        $user = $this->userRepository->updateUsernameById($userId, $username);

        $user = $this->userRepository->findByUsername($username);

        $this->logger->info(sprintf('User username updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate($userId, $username)
    {
        $currentUser = $this->userRepository->findById($userId);

        if ($currentUser->getUsername() != $username) {
            if (!preg_match('/^[\w\-]+$/i', $username)) {
                throw new ValidationException('Username is invalid.');
            }
            try {
                $this->userRepository->findByUsername($username);
                throw new UsernameAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
            $updateList[] = 'username';
        } else {
            throw new ValidationException('Nothing to update.');
        }
    }
}
