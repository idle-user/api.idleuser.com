<?php
declare(strict_types=1);

namespace App\Domain\Auth\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class AuthTokenNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'Auth token not found.';
}
