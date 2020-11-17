<?php
declare(strict_types=1);

namespace App\Domain\DomainException;

class DomainInvalidArgumentException extends DomainException
{
    protected $code = 422;
}
