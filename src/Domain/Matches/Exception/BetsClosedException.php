<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class BetsClosedException extends DomainInvalidArgumentException
{
    protected $message = 'Bets are closed for the match requested.';
}
