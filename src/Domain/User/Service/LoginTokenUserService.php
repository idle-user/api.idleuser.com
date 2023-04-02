<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\UserBannedException;
use App\Exception\ValidationException;

final class LoginTokenUserService extends UserService
{
    public function run(array $data)
    {
        $this->validate($data);

        $user = $this->userRepository->loginWithToken($data['login_token']);

        if($user->getAccessLevel() < 1)
        {
            throw new UserBannedException();
        }

        $user->setShowFullDetail(true);

        $this->logger->info(sprintf('User logged-in with token successfully: %s', $user->getId()));

        return $user;
    }

    private function validate(array $data)
    {
        if (empty($data['login_token'])) {
            throw new ValidationException('Login Token is required' . var_dump($data));
        }
    }
}
