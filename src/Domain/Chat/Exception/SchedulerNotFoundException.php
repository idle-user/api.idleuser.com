<?php
declare(strict_types=1);

namespace App\Domain\Chat\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class SchedulerNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'Scheduler not found.';
}
