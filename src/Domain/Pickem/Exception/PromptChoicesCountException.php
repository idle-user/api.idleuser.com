<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptChoicesCountException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt must have 2-5 Choices.';
}
