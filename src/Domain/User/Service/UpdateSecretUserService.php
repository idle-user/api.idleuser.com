<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class UpdateSecretUserService extends UserService
{
    public function run($userId, array $data)
    {
        $this->validate($data);

        $user = $this->userRepository->updateSecretById($userId, $data['old_secret'], $data['secret']);

        $user = $this->userRepository->findById($userId);

        $user->setShowFullDetail(true);

        $this->logger->info(sprintf('User secret updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate(array $data)
    {
        if (empty($data['old_secret'])) {
            throw new ValidationException('Old Secret is required.');
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

        if ($data['secret'] == $data['old_secret']) {
            throw new ValidationException('Secret cannot be the same.');
        }

    }
}
