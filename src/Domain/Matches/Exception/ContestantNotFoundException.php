<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class ContestantNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The contestant requested does not exist.';
}
