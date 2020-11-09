<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainUnauthorizedException;

class UserLoginFailedException extends DomainUnauthorizedException
{
    protected $message = 'Invalid credentials.';
}
