<?php
declare(strict_types=1);

use DI\ContainerBuilder;
use Monolog\Logger;

return function (ContainerBuilder $containerBuilder) {
    // Global Settings Object
    $containerBuilder->addDefinitions([
        'settings' => [
            'displayErrorDetails' => getenv('APP_ENV') === 'local',
            'logErrors' => true,
            'logErrorDetails' => true,
            'timezone' => getenv('TZ') ?: date_default_timezone_get(),
            'logger' => [
                'name' => 'slim-app',
                'path' => getenv('docker') ? 'php://stdout' : __DIR__ . '/../logs/app.log',
                'level' => Logger::DEBUG,
            ],
            'db' => [
                'driver' => 'mysql',
                'host' => 'db',
                'database' => getenv('MYSQL_DATABASE'),
                'username' => getenv('MYSQL_USER'),
                'password' => getenv('MYSQL_PASSWORD'),
                'charset' => 'utf8mb4',
                'collation' => 'utf8_unicode_ci',
                'prefix' => '',
                'options' => [
                    PDO::ATTR_EMULATE_PREPARES => false,
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                ],
            ],
            'ip' => [
                'checkProxyHeaders' => false,
                'trustedProxies' => null,
                'attributeName' => null,
                'headersToInspect' => [],
            ],
        ],
    ]);
};
