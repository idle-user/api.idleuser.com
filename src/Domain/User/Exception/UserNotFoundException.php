<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class UserNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The user you requested does not exist.';
}
