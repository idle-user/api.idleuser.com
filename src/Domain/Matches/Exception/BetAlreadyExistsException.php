<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class BetAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'A bet for the match already exists.';
}
