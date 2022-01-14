<?php
declare(strict_types=1);

namespace App\Domain\AltLink\Service;

use App\Domain\AltLink\Data\AltLink;
use App\Exception\ValidationException;

final class AddAltLinkService extends AltLinkService
{
    public function run(array $data)
    {
        $data['access_limit'] = empty($data['access_limit']) ? -1 : $data['access_limit'];
        $this->validate($data);
        $data['access_limit'] = intval($data['access_limit']);
        $data['user_id'] = intval($data['user_id']);

        $altLink = AltLink::create()
            ->setAlias($data['alias'])
            ->setTarget($data['target'])
            ->setAccessLimit(intval($data['access_limit']))
            ->setAccessCount(0)
            ->setUserId($data['user_id']);

        $altLinkId = $this->altLinkRepository->add($altLink);


        // TODO
        // $altLink = $this->altLinkRepository->findById($altLinkId);

        // $this->logger->info(sprintf('AltLink created successfully: %s', $altLink->getAlias()));

        return $altLink;
    }

    private function validate(array $data)
    {
        $errors = [];

        if (empty($data['alias'])) {
            $errors['alias'] = 'Input required';
        }

        if (strlen($data['alias']) < 6) {
            $errors['alias'] = 'Alias cannot be less than 6 characters';
        }

        if (empty($data['target'])) {
            $errors['target'] = 'Input required';
        }

        if (filter_var($data['target'], FILTER_VALIDATE_URL) === FALSE) {
            $errors['target'] = 'Target must be a URL';
        }

        if (intval($data['access_limit']) === 0) {
            $errors['access_limit'] = 'Access Limit cannot be 0';
        }

        if ($errors) {
            $this->logger->info('Invalid input', $errors);
            throw new ValidationException('Please check your input', $errors);
        }
    }
}
