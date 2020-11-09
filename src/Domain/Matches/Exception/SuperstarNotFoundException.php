<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class SuperstarNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The superstar requested does not exist.';
}
