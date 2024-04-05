<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class StatsNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The stats requested do not exist.';
}
