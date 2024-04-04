<?php
declare(strict_types=1);

namespace App\Domain\User\Service;

use App\Exception\ValidationException;

final class ViewChatangoUserService extends UserService
{
    public function run(string $chatangoId)
    {
        $this->validate($chatangoId);

        $user = $this->userRepository->findByChatangoId($chatangoId);

        $this->logger->debug("User Chatango_id `${chatangoId}` was viewed.");

        return $user;
    }

    private function validate(string $chatangoId)
    {
        $errors = [];

        if (empty($chatangoId)) {
            $errors['chatangoId'] = 'Input required';
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
