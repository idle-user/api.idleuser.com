<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\ChatangoIdAlreadyExistsException;
use App\Domain\User\Exception\DiscordIdAlreadyExistsException;
use App\Domain\User\Exception\EmailAlreadyExistsException;
use App\Domain\User\Exception\TwitterIdAlreadyExistsException;
use App\Domain\User\Exception\UsernameAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class RegisterUserService extends UserService
{
    public function run(array $data)
    {
        if (!array_key_exists('email', $data)) {
            $data['email'] = null;
        }

        if (!array_key_exists('discord_id', $data)) {
            $data['discord_id'] = null;
        }

        if (!array_key_exists('chatango_id', $data)) {
            $data['chatango_id'] = null;
        }

        if (!array_key_exists('twitter_id', $data)) {
            $data['twitter_id'] = null;
        }

        $this->validate($data);

        $userId = $this->userRepository->register($data['username'], $data['secret']);

        if ($data['email']) {
            $this->userRepository->updateEmailById($userId, $data['email']);
        }

        if ($data['discord_id']) {
            $this->userRepository->updateDiscordIdById($userId, $data['discord_id']);
        }

        if ($data['chatango_id']) {
            $this->userRepository->updateChatangoIdById($userId, $data['chatango_id']);
        }

        if ($data['twitter_id']) {
            $this->userRepository->updateTwitterIdById($userId, $data['twitter_id']);
        }

        $user = $this->userRepository->findById($userId);
        $user->setShowFullDetail(true);

        $this->logger->info(sprintf('User registered successfully: %s', $user->getId()));

        return $user;
    }

    private function validate(array $data)
    {
        if (empty($data['username'])) {
            throw new ValidationException('Username is required');
        } elseif (!preg_match('/^[\w\-]+$/i', $data['username'])) {
            throw new ValidationException('Username is invalid.');
        }

        try {
            $this->userRepository->findByUsername($data['username']);
            throw new UsernameAlreadyExistsException();
        } catch (UserNotFoundException $e) {
        }

        if (empty($data['secret'])) {
            throw new ValidationException('Secret is required.');
        } elseif (strlen($data['secret']) < 6) {
            throw new ValidationException('Secret must contain at least 6 characters');
        }

        if ($data['email'] != null) {
            if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
                throw new ValidationException('Email is invalid.');
            }
            try {
                $this->userRepository->findByEmail($data['email']);
                throw new EmailAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        }

        if ($data['discord_id'] != null) {
            if (empty($data['discord_id'])) {
                throw new ValidationException('chatango_id cannot be empty.');
            }
            if (strlen($data['discord_id']) > 45) {
                throw new ValidationException('discord_id is too long.');
            }
            try {
                $this->userRepository->findByDiscordId($data['discord_id']);
                throw new DiscordIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        }

        if ($data['chatango_id'] != null) {
            if (empty($data['chatango_id'])) {
                throw new ValidationException('chatango_id cannot be empty.');
            }
            if (strlen($data['chatango_id']) > 45) {
                throw new ValidationException('chatango_id is too long.');
            }
            try {
                $this->userRepository->findByChatangoId($data['chatango_id']);
                throw new ChatangoIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        }

        if ($data['twitter_id'] != null) {
            if (empty($data['twitter_id'])) {
                throw new ValidationException('twitter_id cannot be empty.');
            }
            if (strlen($data['twitter_id']) > 45) {
                throw new ValidationException('twitter_id is too long.');
            }
            try {
                $this->userRepository->findByTwitterId($data['twitter_id']);
                throw new TwitterIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        }
    }
}
