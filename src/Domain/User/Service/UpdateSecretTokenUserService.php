<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

final class UpdateSecretTokenUserService extends UserService
{
    public function run(int $userId)
    {
        $token = bin2hex(random_bytes(32));

        $this->userRepository->updateSecretTokenById($userId, $token);

        $user = $this->userRepository->findById($userId);

        $this->logger->info(sprintf('Updated user secret token successfully: %s', $user->getId()));

        return $user->getSecretToken();
    }
}
