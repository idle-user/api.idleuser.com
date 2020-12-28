<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

final class ListUsersService extends UserService
{
    public function run($showFullDetail = false)
    {
        $users = $this->userRepository->findAll();

        if ($showFullDetail) {
            foreach ($users as $user) {
                $user->setShowFullDetail($showFullDetail);
            }
        }

        $this->logger->info('User list was viewed.');

        return $users;
    }
}
