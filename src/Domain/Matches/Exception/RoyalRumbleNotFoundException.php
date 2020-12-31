<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class RoyalRumbleNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The royal rumble requested does not exist.';
}
