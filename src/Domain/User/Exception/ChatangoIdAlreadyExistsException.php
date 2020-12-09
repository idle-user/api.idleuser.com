<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class ChatangoIdAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'The Chatango ID requested is already registered.';
}
