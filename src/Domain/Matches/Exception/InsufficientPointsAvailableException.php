<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class InsufficientPointsAvailableException extends DomainInvalidArgumentException
{
    protected $message = 'Insufficient points available.';
}
