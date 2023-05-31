<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\ChatangoIdAlreadyExistsException;
use App\Domain\User\Exception\DiscordIdAlreadyExistsException;
use App\Domain\User\Exception\EmailAlreadyExistsException;
use App\Domain\User\Exception\TwitterIdAlreadyExistsException;
use App\Domain\User\Exception\UsernameAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Domain\User\Exception\UserUpdateForbiddenException;
use App\Exception\ValidationException;

final class UpdateUserService extends UserService
{
    public function run($userId, array $data, $auth)
    {
        $updateList = $this->validate($userId, $data, $auth);

        if (in_array('username', $updateList)) {
            $this->userRepository->updateUsernameById($userId, $data['username']);
        }

        if (in_array('email', $updateList)) {
            $this->userRepository->updateEmailById($userId, $data['email']);
        }

        if (in_array('access', $updateList)) {
            $this->userRepository->updateAccessById($userId, $data['access']);
        }

        if (in_array('discord_id', $updateList)) {
            $this->userRepository->updateDiscordIdById($userId, $data['discord_id']);
        }

        if (in_array('chatango_id', $updateList)) {
            $this->userRepository->updateChatangoIdById($userId, $data['chatango_id']);
        }

        if (in_array('twitter_id', $updateList)) {
            $this->userRepository->updateTwitterIdById($userId, $data['twitter_id']);
        }

        $user = $this->userRepository->findById($userId);

        $this->logger->info(sprintf('User updated successfully: %s', $user->getId()));

        return $user;
    }

    private function validate($userId, array $data, $auth)
    {
        if (empty($data['username'])) {
            throw new ValidationException('Username is required');
        }

        if (empty($data['email']) && $data['email'] != null) {
            throw new ValidationException('Email cannot be empty');
        }

        if (empty($data['discord_id']) && $data['discord_id'] != null) {
            throw new ValidationException('Discord ID cannot be empty');
        }

        if (empty($data['chatango_id']) && $data['chatango_id'] != null) {
            throw new ValidationException('Chatango ID cannot be empty');
        }

        if (empty($data['twitter_id']) && $data['twitter_id'] != null) {
            throw new ValidationException('Twitter ID cannot be empty');
        }

        $currentUser = $this->userRepository->findById($userId);
        $updateList = [];

        if ($currentUser->getUsername() != $data['username']) {
            if (!preg_match('/^[\w\-]+$/i', $data['username'])) {
                throw new ValidationException('Username is invalid.');
            }
            try {
                $this->userRepository->findByUsername($data['username']);
                throw new UsernameAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
            $updateList[] = 'username';
        }

        if ($currentUser->getEmail() != $data['email']) {
            if (filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
                throw new ValidationException('Email is invalid.');
            }
            try {
                $this->userRepository->findByEmail($data['email']);
                throw new EmailAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
            $updateList[] = 'email';
        }

        if ($currentUser->getDiscordId() != $data['discord_id']) {
            try {
                $this->userRepository->findByDiscordId($data['discord_id']);
                throw new DiscordIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
            $updateList[] = 'discord_id';
        }

        if ($currentUser->getChatangoId() != $data['chatango_id']) {
            try {
                $this->userRepository->findByChatangoId($data['chatango_id']);
                throw new ChatangoIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
            $updateList[] = 'chatango_id';
        }

        if ($currentUser->getTwitterId() != $data['twitter_id']) {
            try {
                $this->userRepository->findByTwitterId($data['twitter_id']);
                throw new TwitterIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
            $updateList[] = 'twitter_id';
        }

        if (isset($data['access']) && $currentUser->getAccessLevel() != $data['access']) {
            if (!$auth->isAdmin()) {
                throw new UserUpdateForbiddenException();
            }
            $updateList[] = 'access';
        }

        if (empty($updateList)) {
            throw new ValidationException('Nothing to update.');
        }

        return $updateList;
    }
}
