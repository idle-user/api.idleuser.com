<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptMustBeClosedForResultException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt must be closed when applying a result.';
}
