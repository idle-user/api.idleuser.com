<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class SeasonNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The season requested does not exist.';
}
