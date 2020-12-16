<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\EmailAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class UpdateEmailUserService extends UserService
{
    public function run($userId, $email)
    {
        $this->validate($userId, $email);

        $this->userRepository->updateEmailById($userId, $email);

        $user = $this->userRepository->findById($userId);

        $this->logger->info(sprintf('User email updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate($userId, $email)
    {
        $currentUser = $this->userRepository->findById($userId);

        if ($currentUser->getemail() != $email) {
            if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
                throw new ValidationException('Email is invalid.');
            }
            try {
                $this->userRepository->findByEmail($email);
                throw new emailAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        } else {
            throw new ValidationException('Nothing to update.');
        }
    }
}
