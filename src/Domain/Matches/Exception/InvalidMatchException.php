<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class InvalidMatchException extends DomainInvalidArgumentException
{
    protected $message = 'The match requested is invalid.';
}
