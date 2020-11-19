<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class InvalidMatchRatingException extends DomainInvalidArgumentException
{
    protected $message = 'The match rating must be 0-5.';
}
