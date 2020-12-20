<?php
declare(strict_types=1);

namespace App\Domain\Traffic\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class TrafficNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The traffic requested does not exist.';
}
