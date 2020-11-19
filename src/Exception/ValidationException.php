<?php

namespace App\Exception;

use App\Domain\DomainException\DomainInvalidArgumentException;
use Throwable;

final class ValidationException extends DomainInvalidArgumentException
{
    private $errors;

    public function __construct(string $message, array $errors = [], int $code = 422, Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);

        $this->errors = $errors;
    }

    public function getErrors(): array
    {
        return $this->errors;
    }
}
