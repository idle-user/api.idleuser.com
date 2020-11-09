<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class StatsNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The stats requested do not exist.';
}
