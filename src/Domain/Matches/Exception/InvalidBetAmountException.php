<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class InvalidBetAmountException extends DomainInvalidArgumentException
{
    protected $message = 'The bet amount must be greater than 0.';
}
