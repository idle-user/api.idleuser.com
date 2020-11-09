<?php
declare(strict_types=1);

use App\Application\Middleware\AuthMiddleware;
use Slim\App;

return function (App $app) {
    $app->add(AuthMiddleware::class);
    $app->addRoutingMiddleware();
    $app->addBodyParsingMiddleware();
};
