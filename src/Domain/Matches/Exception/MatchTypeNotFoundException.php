<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class MatchTypeNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The match type requested does not exist.';
}
