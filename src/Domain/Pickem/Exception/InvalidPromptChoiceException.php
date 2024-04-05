<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class InvalidPromptChoiceException extends DomainInvalidArgumentException
{
    protected $message = 'Choice does not exist for the selected Prompt.';
}
