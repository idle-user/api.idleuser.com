<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

final class ViewUserService extends UserService
{
    public function run(int $userId)
    {
        $user = $this->userRepository->findById($userId);

        $this->logger->info("User id `${userId}` was viewed.");

        return $user;
    }

}
