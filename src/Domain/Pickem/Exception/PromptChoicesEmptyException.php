<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptChoicesEmptyException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt choices is empty.';
}
