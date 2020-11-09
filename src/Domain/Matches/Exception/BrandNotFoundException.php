<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class BrandNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The brand requested does not exist.';
}
