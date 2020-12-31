<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class RoyalRumbleEntryAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'A matching entry for the requested Royal Rumble already exists.';
}
