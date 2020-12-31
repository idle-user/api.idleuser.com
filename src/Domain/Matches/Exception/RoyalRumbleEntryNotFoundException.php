<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class RoyalRumbleEntryNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The royal rumble entry requested does not exist.';
}
