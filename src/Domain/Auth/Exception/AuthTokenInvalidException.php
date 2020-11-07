<?php
declare(strict_types=1);

namespace App\Domain\Auth\Exception;

use App\Domain\DomainException\DomainUnauthorizedException;

class AuthTokenInvalidException extends DomainUnauthorizedException
{
    protected $message = 'Auth token invalid.';
}
