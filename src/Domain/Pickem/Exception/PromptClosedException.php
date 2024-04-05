<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptClosedException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt is closed and cannot be re-opened.';
}
