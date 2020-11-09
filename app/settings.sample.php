<?php
declare(strict_types=1);

use DI\ContainerBuilder;
use Monolog\Logger;

return function (ContainerBuilder $containerBuilder) {
    // Global Settings Object
    $containerBuilder->addDefinitions([
        'settings' => [
            'displayErrorDetails' => true, // Should be set to false in production
            'logger' => [
                'name' => 'slim-app',
                'path' => isset($_ENV['docker']) ? 'php://stdout' : __DIR__ . '/../logs/app.log',
                'level' => Logger::DEBUG,
            ],
            'db' => [
                'driver' => 'mysql',
                'host' => '',
                'database' => '',
                'username' => '',
                'password' => '',
                'charset'   => 'utf8mb4',
                'collation' => 'utf8_unicode_ci',
                'prefix'    => '',
                'options' => [
                    PDO::ATTR_EMULATE_PREPARES   => false,
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                ],
            ],
        ],
    ]);
};
