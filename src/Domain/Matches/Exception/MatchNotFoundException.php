<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class MatchNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The match you requested does not exist.';
}
