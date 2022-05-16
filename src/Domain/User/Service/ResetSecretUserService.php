<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class ResetSecretUserService extends UserService
{
    public function run(array $data)
    {
        $this->validate($data);

        $user = $this->userRepository->resetSecretWithToken($data['reset_token'], $data['secret']);

        $this->logger->info(sprintf('User secret updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate(array $data)
    {
        if (empty($data['reset_token'])) {
            throw new ValidationException('Reset Token is required.');
        }

        if (empty($data['secret'])) {
            throw new ValidationException('Secret is required.');
        } elseif (strlen($data['secret']) < 6) {
            throw new ValidationException('Secret must contain at least 6 characters');
        }

        if (empty($data['secret_check'])) {
            throw new ValidationException('Secret Check is required.');
        }

        if ($data['secret'] != $data['secret_check']) {
            throw new ValidationException('Secret Check failed.');
        }

    }
}
