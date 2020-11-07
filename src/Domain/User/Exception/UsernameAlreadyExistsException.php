<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class UsernameAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'The username you requested is already taken.';
}
