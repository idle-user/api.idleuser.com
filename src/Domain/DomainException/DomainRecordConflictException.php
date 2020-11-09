<?php
declare(strict_types=1);

namespace App\Domain\DomainException;

class DomainRecordConflictException extends DomainException
{
    protected $code = 409;
}
