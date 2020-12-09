<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Domain\User\Exception\ChatangoIdAlreadyExistsException;
use App\Domain\User\Exception\DiscordIdAlreadyExistsException;
use App\Domain\User\Exception\UsernameAlreadyExistsException;
use App\Domain\User\Exception\UserNotFoundException;
use App\Exception\ValidationException;

final class RegisterUserService extends UserService
{
    public function run(array $data)
    {
        if (!array_key_exists('discord_id', $data)) {
            $data['discord_id'] = null;
        }

        if (!array_key_exists('chatango_id', $data)) {
            $data['chatango_id'] = null;
        }

        $this->validate($data);

        $userId = $this->userRepository->register($data);

        $user = $this->userRepository->findById($userId);

        $this->logger->info(sprintf('User registered successfully: %s', $user->getUsername()));

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

        if ($data['discord_id'] != null) {
            try {
                $this->userRepository->findByDiscordId($data['discord_id']);
                throw new DiscordIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        }

        if ($data['chatango_id'] != null) {
            try {
                $this->userRepository->findByChatangoId($data['chatango_id']);
                throw new ChatangoIdAlreadyExistsException();
            } catch (UserNotFoundException $e) {
            }
        }
    }
}
