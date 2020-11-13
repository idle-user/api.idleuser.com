<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

final class ListUsersService extends UserService
{
    public function run()
    {
        $users = $this->userRepository->findAll();

        $this->logger->info('User list was viewed.');

        return $users;
    }
}
