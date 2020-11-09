<?php
declare(strict_types=1);

use App\Domain\User\Repository\UserRepository;
use App\Domain\Matches\Repository\SuperstarRepository;
use DI\ContainerBuilder;

return function (ContainerBuilder $containerBuilder) {
    $containerBuilder->addDefinitions([
        UserRepository::class => \DI\autowire(UserRepository::class),
        SuperstarRepository::class => \DI\autowire(SuperstarRepository::class),

    ]);
};
