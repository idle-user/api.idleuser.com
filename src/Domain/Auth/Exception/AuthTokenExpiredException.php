<?php
declare(strict_types=1);

namespace App\Domain\Auth\Exception;

use App\Domain\DomainException\DomainUnauthorizedException;

class AuthTokenExpiredException extends DomainUnauthorizedException
{
    protected $message = 'Auth token expired.';
}
