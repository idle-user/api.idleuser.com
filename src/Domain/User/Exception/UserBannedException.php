<?php
declare(strict_types=1);

namespace App\Domain\User\Exception;

use App\Domain\DomainException\DomainForbiddenException;

class UserBannedException extends DomainForbiddenException
{
    protected $message = 'The user is banned.';
}
