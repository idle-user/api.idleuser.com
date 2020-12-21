<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class EmailAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'The email requested is registered.';
}
