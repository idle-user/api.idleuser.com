<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainForbiddenException;

class UserUpdateForbiddenException extends DomainForbiddenException
{
    protected $message = 'Insufficient access to update user.';
}
