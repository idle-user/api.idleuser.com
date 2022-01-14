<?php
declare(strict_types=1);

namespace App\Domain\Altlink\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class AltLinkNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'AltLink not found.';
}
