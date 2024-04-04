<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class ChoiceNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'Choice not found.';
}
