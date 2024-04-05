<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptPicksClosedException extends DomainInvalidArgumentException
{
    protected $message = 'Picks are closed for the prompt requested.';
}
