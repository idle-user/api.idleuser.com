<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

final class UpdateLoginTokenUserService extends UserService
{
    public function run(int $userId)
    {
        $token = bin2hex(random_bytes(32));

        $this->userRepository->updateLoginTokenById($userId, $token);

        $user = $this->userRepository->findById($userId);

        $this->logger->info(sprintf('Updated user login token successfully: %s', $user->getId()));

        return $user->getLoginToken();
    }
}
