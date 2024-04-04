<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;

class ChoiceSubjectEmptyException extends DomainInvalidArgumentException
{
    protected $message = 'Prompt choice subject is empty.';
}
