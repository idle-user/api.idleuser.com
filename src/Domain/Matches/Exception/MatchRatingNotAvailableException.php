<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class MatchRatingNotAvailableException extends DomainInvalidArgumentException
{
    protected $message = 'Match rating is unavailable.';
}
