<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class PickNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'Pick not found.';
}
