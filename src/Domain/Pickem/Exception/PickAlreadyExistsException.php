<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class PickAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'Pick for that prompt already exists.';
}
