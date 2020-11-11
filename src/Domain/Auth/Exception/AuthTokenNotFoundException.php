<?php
declare(strict_types=1);

namespace App\Domain\Auth\Exception;

use App\Domain\DomainException\DomainUnauthorizedException;

class AuthTokenNotFoundException extends DomainUnauthorizedException
{
    protected $message = 'Auth token not found.';
}
