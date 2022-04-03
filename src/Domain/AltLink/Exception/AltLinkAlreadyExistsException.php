<?php
declare(strict_types=1);

namespace App\Domain\Altlink\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class AltLinkAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'That AltLink already exists.';
}
