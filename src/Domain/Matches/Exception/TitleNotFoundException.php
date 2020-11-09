<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class TitleNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The title requested does not exist.';
}
