<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class UsernameAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'The username requested is already taken.';
}
