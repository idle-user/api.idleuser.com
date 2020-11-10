<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class RegisterUserService extends UserService
{
    public function run(array $data)
    {
        $this->validate($data);

        $userId = $this->userRepository->register($data);

        $user = $this->userRepository->findById($userId);

        $this->logger->info(sprintf('User registered successfully: %s', $user->getUsername()));

        return $user;
    }

    private function validate(array $data)
    {
        $errors = [];

        if (empty($data['username'])) {
            $errors['username'] = 'Input required';
        } elseif (!preg_match('/^[\w\-]+$/i', $data['username'])) {
            $errors['username'] = "Invalid username.";
        }

        if (empty($data['secret'])) {
            $errors['secret'] = 'Input required';
        } elseif (strlen($data["secret"]) < 6) {
            $errors['secret']  = "Must contain at least 6 characters.";
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
