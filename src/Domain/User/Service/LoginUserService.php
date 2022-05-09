<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class LoginUserService extends UserService
{
    public function run(array $data)
    {
        $this->validate($data);

        if(filter_var($data['username'], FILTER_VALIDATE_EMAIL)) {
            $user = $this->userRepository->loginWithEmail($data['username'], $data['secret']);
        }
        else {
            $user = $this->userRepository->loginWithUsername($data['username'], $data['secret']);
        }

        $user->setShowFullDetail(true);

        $this->logger->info(sprintf('User logged-in successfully: %s', $user->getId()));

        return $user;
    }

    private function validate(array $data)
    {
        if (empty($data['username'])) {
            throw new ValidationException('Username is required');
        }

        if (empty($data['secret'])) {
            throw new ValidationException('Secret is required.');
        }
    }
}
