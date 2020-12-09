<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class MatchCalculationNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The match calculation requested does not exist.';
}
