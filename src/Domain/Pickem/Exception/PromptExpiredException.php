<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptExpiredException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt is expired.';
}
