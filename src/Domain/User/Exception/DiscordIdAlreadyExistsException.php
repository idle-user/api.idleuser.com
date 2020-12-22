<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class DiscordIdAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'The Discord ID requested is registered.';
}
