<?php
declare(strict_types=1);

namespace App\Domain\Chat\Service;

use App\Domain\Chat\Data\Command;
use App\Exception\ValidationException;

final class AddCommandService extends CommandService
{
    public function run(array $data)
    {
        $this->validate($data);

        $command = Command::create()
            ->setCommand($data['command'])
            ->setResponse($data['response'])
            ->setDescription($data['description']);

        $commandId = $this->commandRepository->add($command);

        $command = $this->commandRepository->findById($commandId);

        $this->logger->info(sprintf('Chat command created successfully: %s', $command->getCommand()));

        return $command;
    }

    private function validate(array $data)
    {
        $errors = [];

        if (empty($data['command'])) {
            $errors['command'] = 'Input required';
        }

        if (empty($data['response'])) {
            $errors['response'] = 'Input required';
        }

        if (empty($data['description'])) {
            $errors['description'] = 'Input required';
        }

        if ($errors) {
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
