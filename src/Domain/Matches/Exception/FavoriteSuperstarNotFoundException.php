<?php
declare(strict_types=1);

namespace App\Domain\Matches\Exception;

use App\Domain\DomainException\DomainRecordNotFoundException;

class FavoriteSuperstarNotFoundException extends DomainRecordNotFoundException
{
    protected $message = 'The favorite superstar requested does not exist.';
}
