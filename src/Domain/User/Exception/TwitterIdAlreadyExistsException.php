<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainRecordConflictException;

class TwitterIdAlreadyExistsException extends DomainRecordConflictException
{
    protected $message = 'The Twitter ID requested is registered';
}
