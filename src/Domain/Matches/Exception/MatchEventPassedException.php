<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class MatchEventPassedException extends DomainInvalidArgumentException
{
    protected $message = 'The match event has passed.';
}
