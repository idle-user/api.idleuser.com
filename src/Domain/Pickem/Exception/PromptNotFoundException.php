<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class PromptNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'Prompt not found.';
}
