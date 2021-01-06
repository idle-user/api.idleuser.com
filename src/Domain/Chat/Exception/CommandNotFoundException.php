<?php
declare(strict_types=1);

namespace App\Domain\Chat\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class CommandNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'Command not found.';
}
