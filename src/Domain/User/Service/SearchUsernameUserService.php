<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

final class SearchUsernameUserService extends UserService
{
    public function run(string $keyword)
    {
        $users = $this->userRepository->searchByUsername("%${keyword}%");

        $this->logger->info("Username search list `${keyword}` was viewed.");

        return $users;
    }
}
