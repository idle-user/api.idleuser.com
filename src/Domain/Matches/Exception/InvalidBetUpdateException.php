<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class InvalidBetUpdateException extends DomainInvalidArgumentException
{
    protected $message = 'A bet update can only increase the original bet amount.';
}
