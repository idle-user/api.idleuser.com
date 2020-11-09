<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class UpdateDiscordUserService extends UserService
{
    public function run(array $data)
    {
        $this->validate($data);

        $user = $this->userRepository->login($data);

        $this->logger->info(sprintf('User logged-in successfully: %s', $user->getUsername()));

        return $user;
    }

    private function validate(array $data)
    {
        $errors = [];

        if (empty($data['username'])) {
            $errors['username'] = 'Input required';
        }

        if (empty($data['secret'])) {
            $errors['secret'] = 'Input required';
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
