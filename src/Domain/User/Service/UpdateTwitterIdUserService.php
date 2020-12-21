<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\TwitterIdAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class UpdateTwitterIdUserService extends UserService
{
    public function run($userId, $twitterId)
    {
        $this->validate($userId, $twitterId);

        $this->userRepository->updateTwitterIdById($userId, $twitterId);

        $user = $this->userRepository->findByTwitterId($twitterId);

        $this->logger->info(sprintf('User twitter_id updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate($userId, $twitterId)
    {
        $currentUser = $this->userRepository->findById($userId);

        if ($currentUser->getTwitterId() != $twitterId) {
            try {
                $this->userRepository->findByTwitterId($twitterId);
                throw new twitterIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        } else {
            throw new ValidationException('Nothing to update.');
        }
    }
}
