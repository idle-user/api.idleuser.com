<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class StatsAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'Stats for that user already exists.';
}
