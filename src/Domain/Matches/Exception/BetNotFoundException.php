<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class BetNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The bet requested does not exist.';
}
