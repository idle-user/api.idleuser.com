<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class PromptDailyLimitReachedException extends DomainInvalidArgumentException
{
    protected $message = 'Unable to create more prompts today. Try again tomorrow.';
}
