<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class MatchRatingNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The match rating requested does not exist.';
}
