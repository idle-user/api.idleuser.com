<?php
declare(strict_types=1);

namespace App\Domain\Chatroom\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class CommandAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'That command already exists.';
}
