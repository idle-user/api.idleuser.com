<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class ChoicesNotUniqueException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt choices are not unique.';
}
