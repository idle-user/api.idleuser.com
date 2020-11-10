<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class ViewUserService extends UserService
{
    public function run(int $userId)
    {
        $this->validate($userId);

        $user = $this->userRepository->findById($userId);

        $this->logger->info("User id `${userId}` was viewed.");

        return $user;
    }

    private function validate(int $userId)
    {
        $errors = [];

        if (!$userId) {
            $errors['userId'] = 'Input required';
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }

}
